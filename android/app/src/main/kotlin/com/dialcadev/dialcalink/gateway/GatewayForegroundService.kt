package com.dialcadev.dialcalink.gateway

import android.app.NotificationChannel
import android.app.NotificationManager
import android.app.Service
import android.content.BroadcastReceiver
import android.content.Context
import android.content.Intent
import android.content.IntentFilter
import android.content.pm.ServiceInfo
import android.os.Build
import android.os.IBinder
import android.provider.Telephony
import android.telephony.TelephonyManager
import android.util.Log
import androidx.core.app.NotificationCompat
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.embedding.engine.dart.DartExecutor
import io.flutter.embedding.engine.loader.FlutterLoader
import io.flutter.plugin.common.EventChannel
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugins.GeneratedPluginRegistrant

class GatewayForegroundService : Service() {
    companion object {
        private const val TAG = "GatewayFgService"
        private const val CHANNEL_ID = "dialca_link_gateway_channel"
        private const val NOTIFICATION_ID = 1001

        const val EVENT_CHANNEL_NAME = "com.dialcadev.dialcalink/gateway_events"
        const val METHOD_CHANNEL_NAME = "com.dialcadev.dialcalink/gateway_control"
    }

    private var flutterEngine: FlutterEngine? = null
    private var eventSink: EventChannel.EventSink? = null
    private var uiBridgeEventSink: EventChannel.EventSink? = null

    private val smsReceiver = object : BroadcastReceiver() {
        override fun onReceive(context: Context?, intent: Intent?) {
            if (intent?.action != Telephony.Sms.Intents.SMS_RECEIVED_ACTION) return
            val messages = Telephony.Sms.Intents.getMessagesFromIntent(intent)
            for (message in messages) {
                val sender = message.displayOriginatingAdress ?: continue
                val content = message.displayMessageBody ?: ""
                emitEvent(
                    mapOf(
                        "type" to "sms_received",
                        "phoneNumber" to sender,
                        "content" to content,
                        "receivedAtMillis" to System.currentTimeMillis()
                    )
                )
            }
        }
    }
    private val phoneStateReceiver = object : BroadcastReceiver() {
        override fun onReceive(context: Context?, intent: Intent?) {
            if (intent?.action != TelephonyManager.ACTION_PHONE_STATE_CHANGED) return

            val state = intent.getStringExtra(TelephonyManager.EXTRA_STATE)
            when (state) {
                TelephonyManager.EXTRA_STATE_RINGING -> {
                    val number = intent.getStringExtra(
                        TelephonyManager.EXTRA_INCOMING_NUMBER
                    ) ?: "unknown"
                    emitEvent(
                        mapOf(
                            "type" to "call_incoming",
                            "phoneNumber" to number,
                            "startedAtMillis" to System.currentTimeMillis(),
                        )
                    )
                }
                TelephonyManager.EXTRA_STATE_IDLE -> {
                    emitEvent(
                        mapOf(
                            "type" to "call_ended",
                            "endedAtMillis" to System.currentTimeMillis(),
                        )
                    )
                }
                // EXTRA_STATE_OFFHOOK (llamada en curso, contestada) se
                // ignora deliberadamente: el documento tecnico solo
                // contempla deteccion de llamadas entrantes/finalizadas,
                // no el estado "en curso" como evento propio.
                else -> return
            }
        }
    }
    override fun onCreate() {
        super.onCreate()
        Log.i(TAG, "onCreate")

        createNotificationChannel()
        startForegroundWithNotification()
        setupFlutterEngine()
        registerReceivers()
    }
    override fun onStartCommand(intent: Intent?, flags: Int, startId: Int): Int {
        Log.i(TAG, "onStartCommand")
        if (intent?.action == "SET_PAIRING_TOKEN") {
            val token = intent.getStringExtra("token") ?: ""
            uiBridgeEventSink?.success(mapOf(
                "type" to "pairing_token_updated",
                "token" to token
            ))
        }
        return START_STICKY
    }
    override fun onDestroy() {
        super.onDestroy()
        Log.i(TAG, "onDestroy")
        unregisterReceivers()
        eventSink = null
        flutterEngine?.destroy()
        flutterEngine = null
    }

    override fun onBind(intent: Intent?): IBinder? = null

    private fun createNotificationChannel() {
        if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.O) {
            val channel = NotificationChannel(
                CHANNEL_ID,
                "Dialca Link — Gateway activo",
                NotificationManager.IMPORTANCE_LOW
            )
            val manager = getSystemService(NotificationManager::class.java)
            manager.createNotificationChannel(channel)
        }
    }
    private fun startForegroundWithNotification() {
        val notification = NotificationCompat.Builder(this, CHANNEL_ID)
            .setContentTitle("Dialca Link")
            .setContentText("Actuando como Gateway — sincronizando SMS y llamadas")
            .setSmallIcon(android.R.drawable.ic_dialog_info) // TODO: icono propio de la app
            .setOngoing(true)
            .build()

        if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.Q) {
            startForeground(
                NOTIFICATION_ID,
                notification,
                ServiceInfo.FOREGROUND_SERVICE_TYPE_DATA_SYNC
            )
        } else {
            startForeground(NOTIFICATION_ID, notification)
        }
    }
    private fun setupFlutterEngine() {
        val loader = FlutterLoader()
        loader.startInitialization(applicationContext)
        loader.ensureInitializationComplete(applicationContext, null)

        val engine = FlutterEngine(applicationContext)
        engine.dartExecutor.executeDartEntrypoint(
            DartExecutor.DartEntrypoint(
                loader.findAppBundlePath(),
                "gatewayServiceEntrypoint", // ver subfase 3.4/3.5: entrypoint Dart dedicado
            )
        )
        GeneratedPluginRegistrant.registerWith(engine)

        EventChannel(engine.dartExecutor.binaryMessenger, EVENT_CHANNEL_NAME)
            .setStreamHandler(object : EventChannel.StreamHandler {
                override fun onListen(arguments: Any?, sink: EventChannel.EventSink?) {
                    eventSink = sink
                    Log.i(TAG, "EventChannel: Dart se suscribio a eventos")
                }

                override fun onCancel(arguments: Any?) {
                    eventSink = null
                    Log.i(TAG, "EventChannel: Dart se desuscribio")
                }
            })

        MethodChannel(engine.dartExecutor.binaryMessenger, METHOD_CHANNEL_NAME)
            .setMethodCallHandler { call, result ->
                when (call.method) {
                    "stopService" -> {
                        stopSelf()
                        result.success(null)
                    }
                    else -> result.notImplemented()
                }
            }
        
        MethodChannel(engine.dartExecutor.binaryMessenger,
            GatewayUiBridgeChannel.METHOD_CHANNEL)
            .setMethodCallHandler { call, result ->
                when (call.method) {
                    "setPairingToken" -> {
                        val token = call.argument<String>("token")
                        uiBridgeEventSink?.success(mapOf(
                            "type" to "pairing_token_updated",
                            "token" to (token ?: "")
                        ))
                        result.success(null)
                    }
                    "emitConnectionUpdate" -> {
                        val isConnected = call.argument<Boolean>("isConnected") ?: false
                        val clientDeviceId = call.argument<String>("clientDeviceId")
                        uiBridgeEventSink?.success(mapOf(
                            "type" to "client_connection_changed",
                            "isConnected" to isConnected,
                            "clientDeviceId" to clientDeviceId
                        ))
                        result.success(null)
                    }
                    else -> result.notImplemented()
                }
             }

        EventChannel(engine.dartExecutor.binaryMessenger,
            GatewayUiBridgeChannel.EVENT_CHANNEL)
            .setStreamHandler(object : EventChannel.StreamHandler {
                override fun onListen(arguments: Any?, sink: EventChannel.EventSink?) {
                    uiBridgeEventSink = sink
                }
                override fun onCancel(arguments: Any?) {
                    uiBridgeEventSink = null
                }
            })  
        flutterEngine = engine
    }
    private fun registerReceivers() {
        registerReceiver(smsReceiver, IntentFilter(Telephony.Sms.Intents.SMS_RECEIVED_ACTION))
        registerReceiver(phoneStateReceiver, IntentFilter(TelephonyManager.ACTION_PHONE_STATE_CHANGED))
    }

    private fun unregisterReceivers() {
        try {
            unregisterReceiver(smsReceiver)
        } catch (e: IllegalArgumentException) {
            Log.w(TAG, "smsReceiver already unregistered")
        }
        try {
            unregisterReceiver(phoneStateReceiver)
        } catch (e: IllegalArgumentException) {
            Log.w(TAG, "phoneStateReceiver already unregistered")
        }
    }
    private fun emitEvent(data: Map<String, Any?>) {
        Log.d(TAG, "emitEvent: $data")
        eventSink?.success(data)
    }
}
package com.dialcadev.dialcalink.client

import android.app.NotificationChannel
import android.app.NotificationManager
import android.app.Service
import android.content.Intent
import android.content.IntentFilter
import android.content.pm.ServiceInfo
import android.os.Build
import android.os.IBinder
import android.util.Log
import androidx.core.app.NotificationCompat
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.embedding.engine.dart.DartExecutor
import io.flutter.plugin.common.EventChannel
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugins.GeneratedPluginRegistrant
import com.dialcadev.dialcalink.MainActivity
import com.dialcadev.dialcalink.client.ClientUiBridgeChannel

class ClientForegroundService : Service() {

    companion object {
        private const val TAG = "ClientFgService"
        private const val CHANNEL_ID = "dialca_link_client_channel"
        private const val NOTIFICATION_ID = 1002

        const val EVENT_CHANNEL_NAME = "com.dialcadev.dialcalink/client_events"
        const val METHOD_CHANNEL_NAME = "com.dialcadev.dialcalink/client_control"
    }

    private var flutterEngine: FlutterEngine? = null

    private var serviceSink: EventChannel.EventSink? = null

    private var pendingConnectionState: Map<String, Any?>? = null

    override fun onCreate() {
        super.onCreate()
        Log.i(TAG, "onCreate")
        createNotificationChannel()
        startForegroundWithNotification()
        setupFlutterEngine()
    }
    override fun onStartCommand(intent: Intent?, flags: Int, startId: Int): Int {
        Log.i(TAG, "onStartCommand action=${intent?.action}, serviceSink=${if (serviceSink == null) "NULL" else "OK"}")
        when (intent?.action) {
            "RECONNECT" -> {
                Log.i(TAG, "Enviando comando reconnect_requested")
                serviceSink?.success(mapOf("type" to "reconnect_requested")) ?: Log.e(TAG, "NO SE PUDO ENVIAR COMANDO: serviceSink ES NULL!")
            }
            "DISCONNECT" -> {
                Log.i(TAG, "Enviando comando disconnect_requested")
                serviceSink?.success(mapOf("type" to "disconnect_requested")) ?: Log.e(TAG, "NO SE PUDO ENVIAR COMANDO: serviceSink ES NULL!")
            }
        }
        return START_STICKY
    }
    override fun onDestroy() {
        super.onDestroy()
        Log.i(TAG, "onDestroy")
        serviceSink = null
        flutterEngine?.destroy()
        flutterEngine = null
    }
    override fun onBind(intent: Intent?): IBinder? = null

    private fun createNotificationChannel() {
        if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.O) {
            val channel = NotificationChannel(
                CHANNEL_ID,
                "Dialca Link - Cliente activo",
                NotificationManager.IMPORTANCE_LOW
            )
            getSystemService(NotificationManager::class.java).createNotificationChannel(channel)
        }
    }
    private fun startForegroundWithNotification() {
        val iconResId = resources.getIdentifier("ic_notification_gateway", "drawable", packageName)
        val smallIcon = if (iconResId != 0) iconResId else android.R.drawable.ic_dialog_info

        val notification = NotificationCompat.Builder(this, CHANNEL_ID)
            .setContentTitle("Dialca Link")
            .setContentText("Escuchando SMS y llamadas del Gateway")
            .setSmallIcon(smallIcon)
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
        val loader = io.flutter.FlutterInjector.instance().flutterLoader()
        loader.ensureInitializationComplete(applicationContext, null)

        val engine = FlutterEngine(applicationContext)
        engine.dartExecutor.executeDartEntrypoint(
            DartExecutor.DartEntrypoint(
                loader.findAppBundlePath(),
                "clientServiceEntrypoint"
            )
        )
        GeneratedPluginRegistrant.registerWith(engine)

        EventChannel(engine.dartExecutor.binaryMessenger, EVENT_CHANNEL_NAME)
            .setStreamHandler(object : EventChannel.StreamHandler {
                override fun onListen(arguments: Any?, sink: EventChannel.EventSink?) {
                    serviceSink = sink
                    Log.i(TAG, "Service EventChannel: Dart se suscribio a eventos")
                }
                override fun onCancel(arguments: Any?) {
                    serviceSink = null
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
                    "emitConnectionState" -> {
                val state = call.argument<String>("state") ?: "disconnected"
                val gatewayName = call.argument<String>("gatewayName")
                val payload = mapOf(
                    "type" to "connection_state_changed",
                    "state" to state,
                    "gatewayName" to gatewayName
                )
                MainActivity.pendingClientConnectionState = payload
                Log.i(TAG, "Guardando estado pendiente: $payload")
                if (ClientUiBridgeChannel.uiEventSink != null) {
                    ClientUiBridgeChannel.uiEventSink?.success(payload)
                } else {
                    pendingConnectionState = payload
                }
                result.success(null)
            }
                    else -> result.notImplemented()
                }
            }

        pendingConnectionState?.let {
            ClientUiBridgeChannel.uiEventSink?.success(it)
            pendingConnectionState = null
        }
        flutterEngine = engine
    }
}
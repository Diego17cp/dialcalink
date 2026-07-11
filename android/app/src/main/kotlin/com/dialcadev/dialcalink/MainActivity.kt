package com.dialcadev.dialcalink

import android.content.Intent
import android.os.Build
import androidx.core.content.ContextCompat
import com.dialcadev.dialcalink.gateway.GatewayForegroundService
import com.dialcadev.dialcalink.gateway.GatewayUiBridgeChannel
import com.dialcadev.dialcalink.client.ClientForegroundService
import com.dialcadev.dialcalink.client.ClientUiBridgeChannel
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugin.common.EventChannel
import android.util.Log

class MainActivity : FlutterActivity() {
    companion object {
        const val ACTIVITY_CONTROL_CHANNEL = "com.dialcadev.dialcalink/gateway_service_control"
        var pendingClientConnectionState: Map<String, Any?>? = null
    }

    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)

        MethodChannel(
            flutterEngine.dartExecutor.binaryMessenger,
            ACTIVITY_CONTROL_CHANNEL
        ).setMethodCallHandler { call, result ->
            when (call.method) {
                "startGatewayService" -> {
                    startGatewayService()
                    result.success(null)
                }
                "stopGatewayService" -> {
                    stopGatewayService()
                    result.success(null)
                }
                "isGatewayServiceRunning" -> {
                    result.success(isGatewayServiceRunning())
                }
                "startClientService" -> {
                    val serviceIntent = Intent(this, ClientForegroundService::class.java)
                    if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.O) {
                        ContextCompat.startForegroundService(this, serviceIntent)
                    } else {
                        startService(serviceIntent)
                    }
                    result.success(null)
                }
                "stopClientService" -> {
                    stopService(Intent(this, ClientForegroundService::class.java))
                    result.success(null)
                }
                "isClientServiceRunning" -> {
                    result.success(isServiceRunning(ClientForegroundService::class.java))
                }
                else -> {
                    result.notImplemented()
                }
            }
        }
        MethodChannel(
            flutterEngine.dartExecutor.binaryMessenger,
            GatewayUiBridgeChannel.METHOD_CHANNEL
        ).setMethodCallHandler { call, result ->
            when (call.method) {
                "setPairingToken" -> {
                    val token = call.argument<String>("token") ?: ""
                    val serviceIntent = Intent(this, GatewayForegroundService::class.java)
                    serviceIntent.action = "SET_PAIRING_TOKEN"
                    serviceIntent.putExtra("token", token)
                    startService(serviceIntent)
                    result.success(null)
                }
                else -> result.notImplemented()
            }
        }
        EventChannel(flutterEngine.dartExecutor.binaryMessenger, GatewayUiBridgeChannel.EVENT_CHANNEL)
            .setStreamHandler(object : EventChannel.StreamHandler {
                override fun onListen(arguments: Any?, sink: EventChannel.EventSink?) {
                    GatewayUiBridgeChannel.uiEventSink = sink
                }
                override fun onCancel(arguments: Any?) {
                    GatewayUiBridgeChannel.uiEventSink = null
                }
            })
        MethodChannel(
            flutterEngine.dartExecutor.binaryMessenger,
            ClientUiBridgeChannel.METHOD_CHANNEL
        ).setMethodCallHandler { call, result ->
            when (call.method) {
                "reconnect" -> {
                    val serviceIntent = Intent(this, ClientForegroundService::class.java)
                    serviceIntent.action = "RECONNECT"
                    startService(serviceIntent)
                    result.success(null)
                }
                "disconnect" -> {
                    val serviceIntent = Intent(this, ClientForegroundService::class.java)
                    serviceIntent.action = "DISCONNECT"
                    startService(serviceIntent)
                    result.success(null)
                }
                else -> result.notImplemented()
            }
        }
        EventChannel(flutterEngine.dartExecutor.binaryMessenger, ClientUiBridgeChannel.EVENT_CHANNEL)
            .setStreamHandler(object : EventChannel.StreamHandler {
                override fun onListen(arguments: Any?, sink: EventChannel.EventSink?) {
                    ClientUiBridgeChannel.uiEventSink = sink
                    pendingClientConnectionState?.let {
                        Log.i("MainActivity", "Enviando estado pendiente a la UI: $it")
                        sink?.success(it)
                    }
                }
                override fun onCancel(arguments: Any?) {
                    ClientUiBridgeChannel.uiEventSink = null
                }
            })
    }

    private fun startGatewayService() {
        val serviceIntent = Intent(this, GatewayForegroundService::class.java)
        if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.O) {
            ContextCompat.startForegroundService(this, serviceIntent)
        } else {
            startService(serviceIntent)
        }
    }

    private fun stopGatewayService() {
        val serviceIntent = Intent(this, GatewayForegroundService::class.java)
        stopService(serviceIntent)
    }

    @Suppress("DEPRECATION")
    private fun isServiceRunning(serviceClass: Class<*>): Boolean {
        val manager = getSystemService(ACTIVITY_SERVICE) as android.app.ActivityManager
        return manager.getRunningServices(Integer.MAX_VALUE).any {
            it.service.className == serviceClass.name
        }
    }

    @Suppress("DEPRECATION")
    private fun isGatewayServiceRunning(): Boolean {
        val manager = getSystemService(ACTIVITY_SERVICE) as android.app.ActivityManager
        return manager.getRunningServices(Integer.MAX_VALUE).any {
            it.service.className == GatewayForegroundService::class.java.name
        }
    }
}

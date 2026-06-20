package com.dialcadev.dialcalink

import android.content.Intent
import android.os.Build
import androidx.core.content.ContextCompat
import com.dialcadev.notidialca.gateway.GatewayForegroundService
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodChannel

class MainActivity : FlutterActivity() {
    companion object {
        const val ACTIVITY_CONTROL_CHANNEL = "com.dialcadev.dialcalink/gateway_service_control"
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
                else -> {
                    result.notImplemented()
                }
            }
        }
    }

    private fun startGatewayService() {
        val serviceIntent = Intent(this, GatewayForegroundService:class.java)
        iif (Build.VERSION.SDK_INT >= Build.VERSION_CODES.O) {
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
    private fun isServiceRunning(): Boolean {
        val manager = getSystemService(ACTIVITY_SERVICE) as android.app.ActivityManager
        return manager.getRunningServices(Integer.MAX_VALUE).any {
            it.service.className == GatewayForegroundService::class.java.name
        }
    }
}

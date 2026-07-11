package com.dialcadev.dialcalink.client

import android.content.BroadcastReceiver
import android.content.Context
import android.content.Intent
import android.os.Build
import android.util.Log
import androidx.core.content.ContextCompat

class ClientBootReceiver : BroadcastReceiver() {
    companion object {
        private const val TAG = "ClientBootReceiver"
        private const val PREFS_NAME = "FlutterSharedPreferences"
        private const val ROLE_KEY = "flutter.identity.device_role"
        private const val CLIENT_ROLE_VALUE = "client"
        private const val HAS_LINKED_GATEWAY_KEY = "flutter.client.has_linked_gateway"
    }
    override fun onReceive(context: Context?, intent: Intent?) {
        if (intent?.action != Intent.ACTION_BOOT_COMPLETED) return
        val ctx = context ?: return

        val prefs = ctx.getSharedPreferences(PREFS_NAME, Context.MODE_PRIVATE)
        val allKeys = prefs.all.keys
        Log.d(TAG, "Claves disponibles: $allKeys")

        val savedRole = prefs.getString(ROLE_KEY, null)
        Log.i(TAG, "Saved role: $savedRole")

        if (savedRole != CLIENT_ROLE_VALUE) {
            Log.i(TAG, "Rol no es client, no se inicia el servicio")
            return
        }

        val hasLinkedGateway = prefs.getBoolean(HAS_LINKED_GATEWAY_KEY, false)
        if (!hasLinkedGateway) {
            Log.i(TAG, "No hay gateway vinculado, no se inicia el servicio")
            return
        }

        Log.i(TAG, "Rol client y gateway vinculado, iniciando servicio")
        val serviceIntent = Intent(ctx, ClientForegroundService::class.java)
        if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.O) {
            ContextCompat.startForegroundService(ctx, serviceIntent)
        } else {
            ctx.startService(serviceIntent)
        }
    }
}
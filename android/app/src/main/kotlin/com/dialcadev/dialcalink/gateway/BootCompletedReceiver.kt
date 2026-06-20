package com.dialcadev.dialcalink.gateway

import android.content.BroadcastReceiver
import android.content.Context
import android.content.Intent
import android.os.Build
import android.util.Log
import androidx.core.content.ContextCompat
import androidx.security.crypto.EncryptedSharedPreferences
import androidx.security.crypto.MasterKey

class BootCompletedReceiver : BroadcastReceiver() {
    companion object {
        private const val TAG = "BootCompletedReceiver"
        private const val PREFS_NAME = "FlutterSharedPreferences"
        private const val ROLE_KEY = "flutter.identity.device_role"
        private const val GATEWAY_ROLE_VALUE = "gateway"
    }
    override fun onReceive(context: Context?, intent: Intent?) {
        if (intent?.action != Intent.ACTION_BOOT_COMPLETED) return
        val ctx = context ?: return

        Log.i(TAG, "BOOT_COMPLETED recibido, verificando rol guardado...")

        val prefs = ctx.getSharedPreferences(PREFS_NAME, Context.MODE_PRIVATE)
        val allKeys = prefs.all.keys

        Log.d(TAG, "Claves disponibles en $PREFS_NAME: $allKeys")

        if (!allKeys.contains(ROLE_KEY)) {
            Log.w(
                TAG,
                "La clave '$ROLE_KEY' NO existe en $PREFS_NAME. " +
                "Esto probablemente significa que el nombre de archivo o " +
                "el prefijo asumidos no coinciden con la version real del " +
                "plugin shared_preferences. Ver instrucciones de " +
                "validacion en el comentario de esta clase. Service NO " +
                "se reiniciara."
            )
            return
        }

        val savedRole = prefs.getString(ROLE_KEY, null)
        Log.i(TAG, "Rol leido: $savedRole")

        if (savedRole != GATEWAY_ROLE_VALUE) {
            Log.i(TAG, "Rol no es '$GATEWAY_ROLE_VALUE', no se reinicia el Service")
            return
        }

        Log.i(TAG, "Rol gateway confirmado, reiniciando GatewayForegroundService")
        val serviceIntent = Intent(ctx, GatewayForegroundService::class.java)
        if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.O) {
            ContextCompat.startForegroundService(ctx, serviceIntent)
        } else {
            ctx.startService(serviceIntent)
        }
    }
}
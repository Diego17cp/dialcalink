package com.dialcadev.dialcalink.gateway

import io.flutter.plugin.common.EventChannel
import io.flutter.plugin.common.MethodChannel
import io.flutter.embedding.engine.FlutterEngine

object GatewayUiBridgeChannel {
    const val METHOD_CHANNEL = "com.dialcadev.dialcalink/gateway_ui_bridge_method"
    const val EVENT_CHANNEL = "com.dialcadev.dialcalink/gateway_ui_bridge_events"
}
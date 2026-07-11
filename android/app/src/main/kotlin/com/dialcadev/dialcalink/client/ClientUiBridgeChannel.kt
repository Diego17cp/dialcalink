package com.dialcadev.dialcalink.client

import io.flutter.plugin.common.EventChannel
import io.flutter.plugin.common.MethodChannel

object ClientUiBridgeChannel {
    const val METHOD_CHANNEL = "com.dialcadev.dialcalink/client_ui_bridge_method"
    const val EVENT_CHANNEL = "com.dialcadev.dialcalink/client_ui_bridge_events"

    var uiEventSink: EventChannel.EventSink? = null
}
import 'package:dialcalink/core/platform/gateway/native/gateway_control_bridge.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'gateway_control_bridge_provider.g.dart';

@riverpod
GatewayControlBridge gatewayControlBridge(Ref ref) => GatewayControlBridge();
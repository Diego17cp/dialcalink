import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:dialcalink/core/platform/gateway/native/gateway_native_bridge.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'gateway_native_bridge_provider.g.dart';

@riverpod
GatewayNativeBridge gatewayNativeBridge(Ref ref) {
  final bridge = GatewayNativeBridge();
  ref.onDispose(bridge.dispose);
  return bridge;
}
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:dialcalink/core/platform/gateway/native/gateway_ui_bridge.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'gateway_ui_bridge_provider.g.dart';

@riverpod
GatewayUiBridge gatewayUiBridge(Ref ref) {
  final bridge = GatewayUiBridge();
  ref.onDispose(bridge.dispose);
  return bridge;
}
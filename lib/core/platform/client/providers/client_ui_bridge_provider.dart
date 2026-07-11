import 'package:dialcalink/core/platform/client/native/client_ui_bridge.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'client_ui_bridge_provider.g.dart';

@riverpod
ClientUiBridge clientUiBridge(Ref ref) {
  final bridge = ClientUiBridge();
  ref.onDispose(bridge.dispose);
  return bridge;
}
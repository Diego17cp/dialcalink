import 'package:dialcalink/core/platform/client/native/client_native_bridge.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'client_native_bridge_provider.g.dart';

@riverpod
ClientNativeBridge clientNativeBridge(Ref ref) => ClientNativeBridge();
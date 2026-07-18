import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:dialcalink/core/network/discovery/local_network_info_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'gateway_ip_refresher_provider.g.dart';

@Riverpod(keepAlive: true)
void gatewayIpRefresher(Ref ref) {
  final connectivity = Connectivity();
  StreamSubscription<List<ConnectivityResult>>? sub;

  sub = connectivity.onConnectivityChanged.listen((_) async {
    await Future.delayed(const Duration(seconds: 2));
    ref.invalidate(gatewayIpProvider);
  });

  ref.onDispose(() => sub?.cancel());
}
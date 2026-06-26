import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:notidialca/core/network/discovery/network_info_result.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:notidialca/core/network/discovery/local_network_info_service.dart';

part 'local_network_info_provider.g.dart';

@riverpod
LocalNetworkInfoService localNetworkInfoService(Ref ref) {
  return LocalNetworkInfoService();
}
@riverpod
Future<NetworkInfoResult> gatewayIp(Ref ref) {
    final service = ref.watch(localNetworkInfoServiceProvider);
    return service.resolveOwnWifiIp();
}
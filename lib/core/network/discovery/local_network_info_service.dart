import 'package:network_info_plus/network_info_plus.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:dialcalink/core/network/discovery/network_info_result.dart';
import 'dart:io';

class LocalNetworkInfoService {
  LocalNetworkInfoService({NetworkInfo? networkInfo})
    : _networkInfo = networkInfo ?? NetworkInfo();
  
  final NetworkInfo _networkInfo;

  Future<bool> _ensureLocationPermission() async {
    final status = await Permission.location.status;
    if (status.isGranted) return true;
    final requested = await Permission.location.request();
    return requested.isGranted;
  }
  // Gateway
  Future<NetworkInfoResult> resolveOwnWifiIp() async {
    final hasPermission = await _ensureLocationPermission();
    if (!hasPermission) {
      return const NetworkInfoPermissionDenied();
    }
    try {
      String? ip = await _networkInfo.getWifiIP();
      if (ip == null || ip.isEmpty || ip == '0.0.0.0' || ip.startsWith('10.')) {
        final interfaces = await NetworkInterface.list(
            type: InternetAddressType.IPv4,
            includeLinkLocal: false,
        );
        for (final interface in interfaces) {
            if (interface.name.contains('rmnet') || interface.name.contains('p2p')) continue;
            for (final addr in interface.addresses) {
                if (!addr.isLoopback) {
                    ip = addr.address;
                    break;
                }
            }
            if (ip != null) break;
        }
      }
      if (ip == null || ip.isEmpty) return const NetworkInfoNotConnected();
      return NetworkInfoResolved(ip);
    } catch (e) {
      return NetworkInfoUnavailable(cause: e);
    }
  }
  // Client
  Future<NetworkInfoResult> resolveWifiGatewayIp() async {
    final hasPermission = await _ensureLocationPermission();
    if (!hasPermission) {
      return const NetworkInfoPermissionDenied();
    }
    try {
      final ip = await _networkInfo.getWifiGatewayIP();
      if (ip == null || ip.isEmpty) {
        return const NetworkInfoNotConnected();
      }
      return NetworkInfoResolved(ip);
    } catch (e) {
      return NetworkInfoUnavailable(cause: e);
    }
  }
}

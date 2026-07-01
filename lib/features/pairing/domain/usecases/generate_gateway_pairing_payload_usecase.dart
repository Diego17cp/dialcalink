import 'package:notidialca/core/failures/pairing_failure.dart';
import 'package:notidialca/core/failures/result.dart';
import 'package:notidialca/core/network/discovery/local_network_info_service.dart';
import 'package:notidialca/core/network/discovery/network_info_result.dart';
import 'package:notidialca/features/pairing/domain/value_objects/pairing_payload.dart';
import 'package:uuid/uuid.dart';

const int kGatewayWebSocketPort = 8888;

// Gateway
class GenerateGatewayPairingPayloadUseCase {
  GenerateGatewayPairingPayloadUseCase(this._networkInfoService);

  final LocalNetworkInfoService _networkInfoService;
  final Uuid _uuid = const Uuid();

  Future<Result<PairingPayload>> call({
    required String gatewayDeviceId,
    required String gatewayDeviceName,
  }) async {
    final ipResult = await _networkInfoService.resolveOwnWifiIp();
    final String ip;
    switch (ipResult) {
      case NetworkInfoResolved(ip: final resolvedIp):
        ip = resolvedIp;
      case NetworkInfoPermissionDenied():
        return Result.failure(
          const PairingNetworkInfoFailure(
            'Location permission is required to obtain the device IP address.',
          ),
        );
      case NetworkInfoNotConnected():
        return Result.failure(
          const PairingNetworkInfoFailure('Device is not connected to a Wi-Fi network.'),
        );
      case NetworkInfoUnavailable(cause: final cause):
        return Result.failure(
          PairingNetworkInfoFailure('Unable to retrieve network information', cause: cause),
        );
    }
    final payload = PairingPayload(
      deviceId: gatewayDeviceId,
      deviceName: gatewayDeviceName,
      ip: ip,
      port: kGatewayWebSocketPort,
      pairingToken: _uuid.v4(),
      generatedAt: DateTime.now(),
    );
    return Result.ok(payload);
  }
  PairingPayload callWithManualIp({
    required String gatewayDeviceId,
    required String gatewayDeviceName,
    required String manualIp,
  }) {
    return PairingPayload(
      deviceId: gatewayDeviceId,
      deviceName: gatewayDeviceName,
      ip: manualIp,
      port: kGatewayWebSocketPort,
      pairingToken: _uuid.v4(),
      generatedAt: DateTime.now(),
    );
  }
}

import 'dart:async';

import 'package:notidialca/core/failures/pairing_failure.dart';
import 'package:notidialca/core/failures/result.dart';
import 'package:notidialca/core/network/websocket/client/gateway_ws_client.dart';
import 'package:notidialca/core/network/websocket/client/ws_connection_state.dart';
import 'package:notidialca/features/pairing/domain/services/pairing_connection_checker.dart';
import 'package:notidialca/features/pairing/domain/value_objects/pairing_payload.dart';
import 'package:uuid/uuid.dart';

class WebSocketPairingConnectionChecker implements PairingConnectionChecker {
  WebSocketPairingConnectionChecker({
    Duration verifyTimeout = const Duration(seconds: 8),
    String Function()? clientDeviceIdResolver,
  }) : _verifyTimeout = verifyTimeout,
       _clientDeviceIdResolver = clientDeviceIdResolver;
  final Duration _verifyTimeout;
  final String Function()? _clientDeviceIdResolver;

  @override
  Future<Result<bool>> verify(PairingPayload payload) async {
    final clientDeviceId = _clientDeviceIdResolver?.call() ?? const Uuid().v4();

    final client = GatewayWsClient.forPairing(
      ip: payload.ip,
      port: payload.port,
      pairingToken: payload.pairingToken,
      clientDeviceId: clientDeviceId,
    );

    final completer = Completer<Result<bool>>();
    StreamSubscription<WsConnectionState>? subscription;
    Timer? timeoutTimer;

    void finish(Result<bool> result) {
      if (completer.isCompleted) return;
      completer.complete(result);
      timeoutTimer?.cancel();
      subscription?.cancel();
      unawaited(client.disconnect());
    }

    subscription = client.connectionState.listen((state) {
      switch (state) {
        case WsReady():
          finish(Result.ok(true));
        case WsHandshakeRejected(reason: final reason):
          finish(Result.failure(PairingRejectedByGatewayFailure(reason)));
        case WsError(message: final message):
          finish(
            Result.failure(
              PairingConnectionFailure('Connection error: $message'),
            ),
          );
        case WsDisconnected():
        case WsConnecting():
        case WsConnected():
        case WsReconnecting():
          break;
      }
    });

    timeoutTimer = Timer(_verifyTimeout, () {
      finish(
        Result.failure(
          PairingConnectionFailure(
            'Verification timed out after $_verifyTimeout',
          ),
        ),
      );
    });

    client.connect();

    return completer.future;
  }
}

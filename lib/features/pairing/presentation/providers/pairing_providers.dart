import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:dialcalink/core/identity/providers/device_identity_provider.dart';
import 'package:dialcalink/core/network/discovery/local_network_info_provider.dart';
import 'package:dialcalink/features/devices/presentation/providers/device_providers.dart';
import 'package:dialcalink/features/pairing/data/repositories/pairing_repository_impl.dart';
import 'package:dialcalink/features/pairing/data/services/websocket_pairing_connection_checker.dart';
import 'package:dialcalink/features/pairing/domain/repositories/pairing_repository.dart';
import 'package:dialcalink/features/pairing/domain/services/pairing_connection_checker.dart';
import 'package:dialcalink/features/pairing/domain/usecases/confirm_pairing_usecase.dart';
import 'package:dialcalink/features/pairing/domain/usecases/decode_scanned_pairing_payload_usecase.dart';
import 'package:dialcalink/features/pairing/domain/usecases/generate_gateway_pairing_payload_usecase.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'pairing_providers.g.dart';

@riverpod
Future<PairingConnectionChecker> pairingConnectionChecker(Ref ref) async {
  final identity = await ref.watch(localDeviceIdentityProvider.future);
  if (identity == null) {
    throw StateError(
      'No se pudo resolver la identidad del dispositivo local para '
      'inicializar el PairingConnectionChecker. Asegúrate de que el '
      'localDeviceRoleProvider esté correctamente configurado y pueda resolver '
      'la identidad antes de usar este provider.',
    );
  }
  return WebSocketPairingConnectionChecker(
    clientDeviceIdResolver: () => identity.id,
  );
}

@riverpod
Future<PairingRepository> pairingRepository(Ref ref) async {
  final checker = await ref.watch(pairingConnectionCheckerProvider.future);
  return PairingRepositoryImpl(checker);
}

@riverpod
GenerateGatewayPairingPayloadUseCase generateGatewayPairingPayloadUseCase(
  Ref ref,
) {
  return GenerateGatewayPairingPayloadUseCase(
    ref.watch(localNetworkInfoServiceProvider),
  );
}

@riverpod
Future<DecodeScannedPairingPayloadUseCase> decodeScannedPairingPayloadUseCase(
  Ref ref,
) async {
  final repository = await ref.watch(pairingRepositoryProvider.future);
  return DecodeScannedPairingPayloadUseCase(repository);
}

@riverpod
Future<ConfirmPairingUseCase> confirmPairingUseCase(Ref ref) async {
  final repository = await ref.watch(pairingRepositoryProvider.future);
  return ConfirmPairingUseCase(
    repository,
    ref.watch(deviceRepositoryProvider),
  );
}

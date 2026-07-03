import 'dart:convert';

import 'package:dialcalink/features/pairing/domain/value_objects/pairing_payload.dart';

sealed class PairingPayloadDecodeResult {
  const PairingPayloadDecodeResult();
}

class PairingPayloadDecoded extends PairingPayloadDecodeResult {
  const PairingPayloadDecoded(this.payload);
  final PairingPayload payload;
}

class PairingPayloadInvalidFormat extends PairingPayloadDecodeResult {
  const PairingPayloadInvalidFormat();
}

class PairingPayloadMissingFields extends PairingPayloadDecodeResult {
  const PairingPayloadMissingFields(this.details);
  final String details;
}

class PairingPayloadCodec {
  const PairingPayloadCodec._();

  static String encode(PairingPayload payload) {
    return jsonEncode(payload.toJson());
  }

  static PairingPayloadDecodeResult decode(String raw) {
    Map<String, dynamic> json;
    try {
      final decoded = jsonDecode(raw);
      if (decoded is! Map<String, dynamic>) {
        return const PairingPayloadInvalidFormat();
      }
      json = decoded;
    } catch (_) {
      return const PairingPayloadInvalidFormat();
    }
    try {
      final payload = PairingPayload.fromJson(json);
      return PairingPayloadDecoded(payload);
    } catch (e) {
      return PairingPayloadMissingFields(e.toString());
    }
  }
}
sealed class GatewayNativeEvent {
  const GatewayNativeEvent();

  static GatewayNativeEvent fromMap(Map<dynamic, dynamic> raw) {
    final type = raw['type'] as String?;
    switch (type) {
      case 'sms_received':
        return GatewayNativeSmsReceived(
          phoneNumber: raw['phoneNumber'] as String,
          content: raw['content'] as String? ?? '',
          receivedAt: DateTime.fromMillisecondsSinceEpoch(
            raw['receivedAtMillis'] as int,
          ),
        );
      case 'call_incoming':
        return GatewayNativeCallIncoming(
          phoneNumber: raw['phoneNumber'] as String,
          startedAt: DateTime.fromMillisecondsSinceEpoch(
            raw['startedAtMillis'] as int,
          ),
        );
      case 'call_outgoing':
        return GatewayNativeCallOutgoing(
          phoneNumber: raw['phoneNumber'] as String,
          startedAt: DateTime.fromMillisecondsSinceEpoch(
            raw['startedAtMillis'] as int,
          ),
        );
      case 'call_ended':
        return GatewayNativeCallEnded(
          endedAt: DateTime.fromMillisecondsSinceEpoch(
            raw['endedAtMillis'] as int,
          ),
          callType: raw['callType'] as String ?? 'ended',
        );
      default:
        throw FormatException('Unknown event type: $type');
    }
  }
}

class GatewayNativeSmsReceived extends GatewayNativeEvent {
  const GatewayNativeSmsReceived({
    required this.phoneNumber,
    required this.content,
    required this.receivedAt,
  });

  final String phoneNumber;
  final String content;
  final DateTime receivedAt;
}

class GatewayNativeCallIncoming extends GatewayNativeEvent {
  const GatewayNativeCallIncoming({
    required this.phoneNumber,
    required this.startedAt,
  });

  final String phoneNumber;
  final DateTime startedAt;
}

class GatewayNativeCallOutgoing extends GatewayNativeEvent {
  const GatewayNativeCallOutgoing({
    required this.phoneNumber,
    required this.startedAt,
  });
  final String phoneNumber;
  final DateTime startedAt;
}

class GatewayNativeCallEnded extends GatewayNativeEvent {
  const GatewayNativeCallEnded({
    required this.endedAt,
    this.callType = 'ended',
  });
  final String callType;
  final DateTime endedAt;
}

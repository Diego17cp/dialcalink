import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:flutter/cupertino.dart';

const int kPairingDiscoveryUdpPort = 45454;
const String kDicoveryProbeMessage = 'DIALCALINK_DISCOVER_GATEWAY';

class DiscoveredGateway {
  final String ip;
  final int port;
  final String deviceName;
  final String deviceId;

  DiscoveredGateway({
    required this.ip,
    required this.port,
    required this.deviceName,
    required this.deviceId,
  });

  factory DiscoveredGateway.fromJson(
    Map<String, dynamic> json,
    String senderIp,
  ) {
    return DiscoveredGateway(
      ip: (json['ip'] as String?)?.isNotEmpty == true
          ? json['ip'] as String
          : senderIp,
      port: json['port'] as int? ?? 8080,
      deviceName: json['deviceName'] as String? ?? 'Dispositivo Gateway',
      deviceId: json['deviceId'] as String? ?? '',
    );
  }
}

class UdpDiscoveryService {
  RawDatagramSocket? _socket;

  Future<void> startGatewayResponder({
    required String deviceName,
    required String deviceId,
    required String ip,
    required int port,
  }) async {
    await stop();
    try {
      _socket = await RawDatagramSocket.bind(
        InternetAddress.anyIPv4,
        kPairingDiscoveryUdpPort,
        reuseAddress: true,
      );
      _socket?.broadcastEnabled = true;
      _socket?.listen((event) {
        if (event == RawSocketEvent.read) {
          final datagram = _socket?.receive();
          if (datagram == null) return;

          final message = utf8.decode(datagram.data).trim();
          if (message == kDicoveryProbeMessage) {
            final responsePayload = jsonEncode({
              'deviceId': deviceId,
              'deviceName': deviceName,
              'ip': ip,
              'port': port,
            });
            _socket?.send(
              utf8.encode(responsePayload),
              datagram.address,
              datagram.port,
            );
          }
        }
      });
    } catch (e) {
      debugPrint(
        '[UDP-GATEWAY] Error responding to UDP discovery requests: $e',
      );
    }
  }

  Future<List<DiscoveredGateway>> discoverGateways({
    Duration timeout = const Duration(seconds: 4),
  }) async {
    final discovered = <String, DiscoveredGateway>{};
    RawDatagramSocket? clientSocket;

    try {
      clientSocket = await RawDatagramSocket.bind(
        InternetAddress.anyIPv4,
        0,
        reuseAddress: true,
      );
      clientSocket.broadcastEnabled = true;
      final completer = Completer<List<DiscoveredGateway>>();

      clientSocket.listen((event) {
        if (event == RawSocketEvent.read) {
          final datagram = clientSocket?.receive();
          if (datagram == null) return;
          try {
            final text = utf8.decode(datagram.data);
            final json = jsonDecode(text) as Map<String, dynamic>;
            final gateway = DiscoveredGateway.fromJson(
              json,
              datagram.address.address,
            );
            discovered[gateway.ip] = gateway;
          } catch (e) {
            debugPrint('[UDP-CLIENT] Error decoding discovery response: $e');
          }
        }
      });
      final probeBytes = utf8.encode(kDicoveryProbeMessage);
      clientSocket.send(
        probeBytes,
        InternetAddress('255.255.255.255'),
        kPairingDiscoveryUdpPort,
      );
      clientSocket.send(
        probeBytes,
        InternetAddress('192.168.43.1'),
        kPairingDiscoveryUdpPort,
      );

      try {
        final interfaces = await NetworkInterface.list(
          type: InternetAddressType.IPv4,
        );
        for (final interface in interfaces) {
          for (final addr in interface.addresses) {
            if (!addr.isLoopback) {
              final segments = addr.address.split(".");
              if (segments.length == 4) {
                final subnet =
                    '${segments[0]}.${segments[1]}.${segments[2]}.255';
                clientSocket.send(
                  probeBytes,
                  InternetAddress(subnet),
                  kPairingDiscoveryUdpPort,
                );
              }
            }
          }
        }
      } catch (_) {}

      Timer(timeout, () {
        clientSocket?.close();
        if (!completer.isCompleted) {
          completer.complete(discovered.values.toList());
        }
      });
      return await completer.future;
    } catch (e) {
      debugPrint('[UDP-CLIENT] Error discovering gateways: $e');
      return [];
    } finally {
      clientSocket?.close();
    }
  }

  Future<void> stop() async {
    _socket?.close();
    _socket = null;
  }
}

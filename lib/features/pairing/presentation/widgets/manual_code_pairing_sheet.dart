import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:dialcalink/features/pairing/data/services/udp_discovery_service.dart';
import 'package:dialcalink/features/pairing/domain/value_objects/pairing_payload.dart';
import 'package:dialcalink/features/pairing/domain/value_objects/pairing_payload_codec.dart';
import 'package:dialcalink/features/pairing/presentation/providers/client_pairing_notifier.dart';

class ManualCodePairingSheet extends ConsumerStatefulWidget {
  const ManualCodePairingSheet({super.key});

  @override
  ConsumerState<ManualCodePairingSheet> createState() =>
      _ManualCodePairingSheetState();
}

class _ManualCodePairingSheetState
    extends ConsumerState<ManualCodePairingSheet> {
  final _pinController = TextEditingController();
  final _ipController = TextEditingController();
  bool _searching = false;
  List<DiscoveredGateway> _gateways = [];
  DiscoveredGateway? _selectedGateway;
  String? _errorMessage;

  @override
  void initState() {
    super.initState();
    _startSearch();
  }

  @override
  void dispose() {
    _pinController.dispose();
    _ipController.dispose();
    super.dispose();
  }

  Future<void> _startSearch() async {
    setState(() {
      _searching = true;
      _errorMessage = null;
    });
    final discovery = UdpDiscoveryService();
    final results = await discovery.discoverGateways();
    if (mounted) {
      setState(() {
        _gateways = results;
        _searching = false;
        if (results.isNotEmpty) {
          _selectedGateway = results.first;
          _ipController.text = _selectedGateway!.ip;
        }
      });
    }
  }

  void _onConnectPressed() {
    final ip = _selectedGateway?.ip ?? _ipController.text.trim();
    final pin = _pinController.text.trim();

    if (ip.isEmpty || pin.length < 6) {
      setState(() {
        _errorMessage = 'Ingresa la IP y el PIN de 6 dígitos.';
      });
      return;
    }

    final manualPayload = PairingPayload(
      deviceId: _selectedGateway?.deviceId ?? 'manual',
      deviceName: _selectedGateway?.deviceName ?? 'Gateway',
      ip: ip,
      port: _selectedGateway?.port ?? 8080,
      pairingToken: pin,
      generatedAt: DateTime.now(),
    );

    Navigator.of(context).pop();
    final rawJson = PairingPayloadCodec.encode(manualPayload);
    ref.read(clientPairingNotifierProvider.notifier).onCodeScanned(rawJson);
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final primary = theme.colorScheme.primary;

    return ClipRRect(
      borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 18, sigmaY: 18),
        child: Container(
          decoration: BoxDecoration(
            color: theme.colorScheme.surface.withValues(alpha: 0.82),
            borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
            border: Border.all(
              color: Colors.white.withValues(alpha: 0.12),
              width: 1,
            ),
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                primary.withValues(alpha: 0.15),
                theme.colorScheme.surface.withValues(alpha: 0.88),
              ],
            ),
          ),
          padding: EdgeInsets.only(
            bottom: MediaQuery.of(context).viewInsets.bottom + 24,
            left: 24,
            right: 24,
            top: 12,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Center(
                child: Container(
                  width: 42,
                  height: 4.5,
                  decoration: BoxDecoration(
                    color: Colors.white.withValues(alpha: 0.35),
                    borderRadius: BorderRadius.circular(3),
                  ),
                ),
              ),
              const SizedBox(height: 18),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Vincular con Código',
                    style: TextStyle(
                      fontSize: 19,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 0.2,
                    ),
                  ),
                  if (!_searching)
                    IconButton(
                      icon: const Icon(
                        CupertinoIcons.arrow_clockwise,
                        size: 18,
                      ),
                      tooltip: 'Reintentar búsqueda',
                      onPressed: _startSearch,
                    ),
                ],
              ),
              const SizedBox(height: 12),
              if (_searching)
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 14,
                    vertical: 10,
                  ),
                  decoration: BoxDecoration(
                    color: primary.withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: const Row(
                    children: [
                      SizedBox(
                        width: 16,
                        height: 16,
                        child: CircularProgressIndicator(strokeWidth: 2),
                      ),
                      SizedBox(width: 12),
                      Expanded(
                        child: Text(
                          'Buscando Gateway en la red...',
                          style: TextStyle(fontSize: 13, color: Colors.white70),
                        ),
                      ),
                    ],
                  ),
                )
              else if (_gateways.isNotEmpty)
                DropdownButtonFormField<DiscoveredGateway>(
                  initialValue: _selectedGateway,
                  isExpanded: true,
                  items: _gateways.map((gw) {
                    return DropdownMenuItem(
                      value: gw,
                      child: Text(
                        '${gw.deviceName} (${gw.ip})',
                        overflow: TextOverflow.ellipsis,
                        maxLines: 1,
                      ),
                    );
                  }).toList(),
                  onChanged: (val) {
                    setState(() {
                      _selectedGateway = val;
                      if (val != null) _ipController.text = val.ip;
                      _errorMessage = null;
                    });
                  },
                  decoration: InputDecoration(
                    labelText: 'Gateway detectado',
                    prefixIcon: const Icon(
                      CupertinoIcons.device_phone_portrait,
                    ),
                    filled: true,
                    fillColor: Colors.black.withValues(alpha: 0.15),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(14),
                    ),
                  ),
                )
              else
                TextField(
                  controller: _ipController,
                  keyboardType: TextInputType.text,
                  inputFormatters: [
                    FilteringTextInputFormatter.allow(RegExp(r'[0-9.]')),
                  ],
                  onChanged: (_) {
                    if (_errorMessage != null) {
                      setState(() => _errorMessage = null);
                    }
                  },
                  decoration: InputDecoration(
                    labelText: 'IP del Gateway',
                    hintText: '192.168.43.1 o 192.168.1.X',
                    prefixIcon: const Icon(CupertinoIcons.wifi),
                    filled: true,
                    fillColor: Colors.black.withValues(alpha: 0.15),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(14),
                    ),
                  ),
                ),
              const SizedBox(height: 14),
              TextField(
                controller: _pinController,
                keyboardType: TextInputType.number,
                maxLength: 6,
                inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                textAlign: TextAlign.center,
                onChanged: (_) {
                  if (_errorMessage != null) {
                    setState(() => _errorMessage = null);
                  }
                },
                style: const TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 8,
                ),
                decoration: InputDecoration(
                  labelText: 'PIN de 6 dígitos',
                  counterText: '',
                  prefixIcon: const Icon(CupertinoIcons.lock),
                  filled: true,
                  fillColor: Colors.black.withValues(alpha: 0.15),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(14),
                  ),
                ),
              ),
              const SizedBox(height: 14),
              if (_errorMessage != null) ...[
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 8,
                  ),
                  decoration: BoxDecoration(
                    color: theme.colorScheme.error.withValues(alpha: 0.15),
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(
                      color: theme.colorScheme.error.withValues(alpha: 0.4),
                    ),
                  ),
                  child: Row(
                    children: [
                      Icon(
                        CupertinoIcons.exclamationmark_triangle_fill,
                        color: theme.colorScheme.error,
                        size: 16,
                      ),
                      const SizedBox(width: 8),
                      Expanded(
                        child: Text(
                          _errorMessage!,
                          style: TextStyle(
                            color: theme.colorScheme.error,
                            fontSize: 13,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 14),
              ],
              FilledButton.icon(
                style: FilledButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 14),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(14),
                  ),
                ),
                onPressed: _onConnectPressed,
                icon: const Icon(CupertinoIcons.link),
                label: const Text(
                  'Vincular Dispositivo',
                  style: TextStyle(fontSize: 15),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

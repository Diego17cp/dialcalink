import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';

enum AppPermission {
  receiveSms(
    permission: Permission.sms,
    title: 'Mensajes SMS',
    description: 'Necesario para detectar SMS entrantes en el Gateway.',
    rolesRequired: {AppRole.gateway},
  ),
  readPhoneState(
    permission: Permission.phone,
    title: 'Estado del teléfono',
    description: 'Necesario para detectar llamadas entrantes en el Gateway.',
    rolesRequired: {AppRole.gateway},
  ),
  contacts(
    permission: Permission.contacts,
    title: 'Contactos',
    description: 'Permite mostrar nombres en vez de números en SMS y llamadas.',
    rolesRequired: {AppRole.gateway},
  ),
  location(
    permission: Permission.locationWhenInUse,
    title: 'Ubicación (red Wi-Fi)',
    description:
        'Android requiere este permiso para detectar la IP de la red Wi-Fi activa.',
    rolesRequired: {AppRole.gateway, AppRole.client},
  ),
  camera(
    permission: Permission.camera,
    title: 'Cámara',
    description: 'Necesario para escanear el código QR de vinculación.',
    rolesRequired: {AppRole.client},
  ),
  notifications(
    permission: Permission.notification,
    title: 'Notificaciones',
    description: 'Permite recibir alertas de SMS y llamadas entrantes.',
    rolesRequired: {AppRole.gateway, AppRole.client},
  ),
  readCallLog(
    permission: Permission.phone,
    title: 'Historial de llamadas',
    description: 'Necesario para detectar llamadas entrantes en el Gateway.',
    rolesRequired: {AppRole.gateway},
  );

  const AppPermission({
    required this.permission,
    required this.title,
    required this.description,
    required this.rolesRequired,
  });

  final Permission permission;
  final String title;
  final String description;
  final Set<AppRole> rolesRequired;

  IconData get icon {
    switch (this) {
      case AppPermission.receiveSms:
        return CupertinoIcons.chat_bubble_text_fill;
      case AppPermission.readPhoneState:
        return CupertinoIcons.phone_fill;
      case AppPermission.contacts:
        return Icons.contacts_sharp;
      case AppPermission.location:
        return CupertinoIcons.wifi;
      case AppPermission.camera:
        return CupertinoIcons.qrcode;
      case AppPermission.notifications:
        return CupertinoIcons.bell_fill;
      case AppPermission.readCallLog:
        return CupertinoIcons.clock_fill;
    }
  }
}

enum AppRole {
  gateway,
  client,
}
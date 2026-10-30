import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:dialcalink/core/extensions/l10n_extension.dart';

enum AppPermission {
  receiveSms(
    permission: Permission.sms,
    rolesRequired: {AppRole.gateway},
  ),
  readPhoneState(
    permission: Permission.phone,
    rolesRequired: {AppRole.gateway},
  ),
  contacts(
    permission: Permission.contacts,
    rolesRequired: {AppRole.gateway},
  ),
  location(
    permission: Permission.locationWhenInUse,
    rolesRequired: {AppRole.gateway, AppRole.client},
  ),
  camera(
    permission: Permission.camera,
    rolesRequired: {AppRole.client},
  ),
  notifications(
    permission: Permission.notification,
    rolesRequired: {AppRole.gateway, AppRole.client},
  ),
  readCallLog(
    permission: Permission.phone,
    rolesRequired: {AppRole.gateway},
  );

  const AppPermission({
    required this.permission,
    required this.rolesRequired,
  });

  final Permission permission;
  final Set<AppRole> rolesRequired;

  String getTitle(BuildContext context) {
    final l10n = context.l10n;
    return switch (this) {
      AppPermission.receiveSms => l10n.permissionSMSTitle,
      AppPermission.readPhoneState => l10n.permissionPhoneTitle,
      AppPermission.contacts => l10n.permissionContactsTitle,
      AppPermission.location => l10n.permissionLocationTitle,
      AppPermission.camera => l10n.permissionCameraTitle,
      AppPermission.notifications => l10n.permissionNotificationsTitle,
      AppPermission.readCallLog => l10n.permissionPhoneHistoryTitle,
    };
  }

  String getDescription(BuildContext context) {
    final l10n = context.l10n;
    return switch (this) {
      AppPermission.receiveSms => l10n.permissionSMSDescription,
      AppPermission.readPhoneState => l10n.permissionPhoneDescription,
      AppPermission.contacts => l10n.permissionContactsDescription,
      AppPermission.location => l10n.permissionLocationDescription,
      AppPermission.camera => l10n.permissionCameraDescription,
      AppPermission.notifications => l10n.permissionNotificationsDescription,
      AppPermission.readCallLog => l10n.permissionPhoneHistoryDescription,
    };
  }

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
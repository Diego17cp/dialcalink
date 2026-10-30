import 'package:flutter/cupertino.dart';
import 'package:dialcalink/core/extensions/l10n_extension.dart';

class TabConfig {
  final String path;
  final String Function(BuildContext context) titleBuilder;
  final String Function(BuildContext context) labelBuilder;
  final IconData icon;
  final IconData activeIcon;

  const TabConfig({
    required this.path,
    required this.titleBuilder,
    required this.labelBuilder,
    required this.icon,
    required this.activeIcon,
  });

  String getTitle(BuildContext context) => titleBuilder(context);
  String getLabel(BuildContext context) => labelBuilder(context);
}

final List<TabConfig> clientTabs = [
  TabConfig(
    path: '/client/sms',
    titleBuilder: (context) => context.l10n.gatewayStatMessagesTitle, // "Mensajes"
    labelBuilder: (context) => 'SMS',
    icon: CupertinoIcons.chat_bubble_2,
    activeIcon: CupertinoIcons.chat_bubble_2_fill,
  ),
  TabConfig(
    path: '/client/calls',
    titleBuilder: (context) => context.l10n.gatewayStatCallsTitle, // "Llamadas"
    labelBuilder: (context) => context.l10n.gatewayStatCallsTitle,
    icon: CupertinoIcons.phone,
    activeIcon: CupertinoIcons.phone_fill,
  ),
  TabConfig(
    path: '/client/status',
    titleBuilder: (context) => context.l10n.clientStatusAppbarTitle, // "Estado"
    labelBuilder: (context) => context.l10n.clientStatusAppbarTitle,
    icon: CupertinoIcons.info,
    activeIcon: CupertinoIcons.info_circle_fill,
  ),
];
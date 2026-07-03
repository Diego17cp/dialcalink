import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:dialcalink/core/notifications/notification_service.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'notification_service_provider.g.dart';

@Riverpod(keepAlive: true)
NotificationService notificationService(Ref ref) => NotificationService();

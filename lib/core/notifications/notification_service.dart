import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:logger/logger.dart';
import 'package:dialcalink/core/notifications/notification_id_generator.dart';

import 'notification_channels.dart';

class NotificationService {
  NotificationService({Logger? logger}) : _logger = logger ?? Logger();

  final Logger _logger;
  final FlutterLocalNotificationsPlugin _plugin =
      FlutterLocalNotificationsPlugin();

  final List<String> _smsGroupLines = [];
  final List<String> _callsGroupLines = [];

  bool _initialized = false;

  Future<void> initialize({
    required void Function(String? payload) onNotificationTapped,
  }) async {
    if (_initialized) return;

    const androidInit = AndroidInitializationSettings('@mipmap/ic_launcher');
    const initSettings = InitializationSettings(android: androidInit);

    await _plugin.initialize(
      initSettings,
      onDidReceiveNotificationResponse: (response) {
        final payload = response.payload;
        _logger.d('Notification tapped with payload: $payload');
        onNotificationTapped(payload);
      },
    );

    final androidPlugin = _plugin
        .resolvePlatformSpecificImplementation<
          AndroidFlutterLocalNotificationsPlugin
        >();

    await androidPlugin?.createNotificationChannel(
      const AndroidNotificationChannel(
        NotificationChannels.smsChannelId,
        NotificationChannels.smsChannelName,
        description: NotificationChannels.smsChannelDescription,
        importance: Importance.high,
      ),
    );

    await androidPlugin?.createNotificationChannel(
      const AndroidNotificationChannel(
        NotificationChannels.callsChannelId,
        NotificationChannels.callsChannelName,
        description: NotificationChannels.callsChannelDescription,
        importance: Importance.high,
      ),
    );

    _initialized = true;
    _logger.i('NotificationService initialized successfully');
  }

  Future<void> showSmsNotification({
    required String smsId,
    required String displayName,
    required String content,
    required String payload,
  }) async {
    if (!_initialized) {
      _logger.w('Attempted to show SMS notification before initialization');
      return;
    }
    final line = '$displayName: $content';
    _smsGroupLines.add(line);

    const individualDetails = AndroidNotificationDetails(
      NotificationChannels.smsChannelId,
      NotificationChannels.smsChannelName,
      channelDescription: NotificationChannels.smsChannelDescription,
      groupKey: NotificationChannels.smsGroupKey,
      importance: Importance.high,
      priority: Priority.high,
    );

    await _plugin.show(
      NotificationIdGenerator.fromEntityId(smsId),
      '📩 Nuevo mensaje',
      '$displayName\n$content',
      const NotificationDetails(android: individualDetails),
      payload: payload,
    );

    await _showSmsGroupSummary();
  }

  Future<void> _showSmsGroupSummary() async {
    final inboxStyle = InboxStyleInformation(
      _smsGroupLines,
      contentTitle: '${_smsGroupLines.length} mensajes nuevos',
      summaryText: 'Dialca Link',
    );

    final summaryDetails = AndroidNotificationDetails(
      NotificationChannels.smsChannelId,
      NotificationChannels.smsChannelName,
      channelDescription: NotificationChannels.smsChannelDescription,
      groupKey: NotificationChannels.smsGroupKey,
      styleInformation: inboxStyle,
      importance: Importance.high,
      priority: Priority.high,
    );

    await _plugin.show(
      NotificationChannels.smsSummaryNotificationId,
      '📩 Nuevo mensaje',
      '${_smsGroupLines.length} mensajes nuevos',
      NotificationDetails(android: summaryDetails),
    );
  }

  Future<void> showCallNotification({
    required String callId,
    required String displayName,
    required String phoneNumber,
  }) async {
    if (!_initialized) {
      _logger.w('Attempted to show call notification before initialization');
      return;
    }
    final line = '$displayName ($phoneNumber)';
    _callsGroupLines.add(line);

    const individualDetails = AndroidNotificationDetails(
      NotificationChannels.callsChannelId,
      NotificationChannels.callsChannelName,
      channelDescription: NotificationChannels.callsChannelDescription,
      groupKey: NotificationChannels.callsGroupKey,
      importance: Importance.high,
      priority: Priority.high,
    );

    await _plugin.show(
      NotificationIdGenerator.fromEntityId(callId),
      '📞 Llamada entrante',
      '$displayName\n$phoneNumber',
      const NotificationDetails(android: individualDetails),
    );

    await _showCallsGroupSummary();
  }
  Future<void> _showCallsGroupSummary() async {
    final inboxStyle = InboxStyleInformation(
      _callsGroupLines,
      contentTitle: '${_callsGroupLines.length} llamadas entrantes',
      summaryText: 'Dialca Link',
    );

    final summaryDetails = AndroidNotificationDetails(
      NotificationChannels.callsChannelId,
      NotificationChannels.callsChannelName,
      channelDescription: NotificationChannels.callsChannelDescription,
      groupKey: NotificationChannels.callsGroupKey,
      styleInformation: inboxStyle,
      importance: Importance.high,
      priority: Priority.high,
    );

    await _plugin.show(
      NotificationChannels.callsSummaryNotificationId,
      '📞 Llamada entrante',
      '${_callsGroupLines.length} llamadas entrantes',
      NotificationDetails(android: summaryDetails),
    );
  }

  void resetGroupedHistory({bool sms = true, bool calls = true}) {
    if (sms) _smsGroupLines.clear();
    if (calls) _callsGroupLines.clear();
  }
}

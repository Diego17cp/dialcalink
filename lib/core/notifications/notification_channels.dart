class NotificationChannels {
  const NotificationChannels._();

  static const String smsChannelId = 'dialca_link_sms_channel';
  static const String smsChannelName = 'Mensajes (SMS)';
  static const String smsChannelDescription = 'Notificaciones de mensajes SMS recibidos en el Gateway vinculado';

  static const String callsChannelId = 'dialca_link_calls_channel';
  static const String callsChannelName = 'Llamadas';
  static const String callsChannelDescription = 'Notificaciones de llamadas recibidas en el Gateway vinculado';

  static const String smsGroupKey = "com.dialcadev.dialcalink.sms_group";
  static const String callsGroupKey = "com.dialcadev.dialcalink.calls_group";

  static const int smsSummaryNotificationId = 9001;
  static const int callsSummaryNotificationId = 9002;
}
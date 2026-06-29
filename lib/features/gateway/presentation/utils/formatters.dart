import 'package:intl/intl.dart';

String formatDuration(Duration? duration) {
  if (duration == null) return 'No Iniciado';
  final h = duration.inHours.toString().padLeft(2, '0');
  final m = duration.inMinutes.remainder(60).toString().padLeft(2, '0');
  final s = duration.inSeconds.remainder(60).toString().padLeft(2, '0');

  return '$h:$m:$s';
}

String formatDateTime(DateTime? dateTime) {
  if (dateTime == null) return 'No Iniciado';
  return DateFormat('dd-MM-yyyy hh:mm a').format(dateTime);
}
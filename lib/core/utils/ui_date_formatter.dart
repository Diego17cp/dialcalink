import 'package:intl/intl.dart';

const _locale = 'es';

String formatRelativeTime(DateTime? dateTime) {
  if (dateTime == null) return '';
  final now = DateTime.now();
  final difference = now.difference(dateTime);

  if (difference.inMinutes < 1) {
    return 'Ahora';
  } else if (difference.inMinutes < 60) {
    return 'Hace ${difference.inMinutes} m';
  } else if (difference.inHours < 24) {
    final startOfToday = DateTime(now.year, now.month, now.day);
    if (dateTime.isAfter(startOfToday)) {
      return DateFormat('h:mm a', _locale).format(dateTime);
    }
    return 'Ayer';
  } else if (difference.inDays < 7) {
    return DateFormat('EEEE', _locale).format(dateTime);
  } else {
    return DateFormat('MMM d', _locale).format(dateTime);
  }
}
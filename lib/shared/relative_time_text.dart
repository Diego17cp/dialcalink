import 'package:dialcalink/core/utils/ui_date_formatter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:dialcalink/core/ui/providers/relative_time_ticker_provider.dart';

class RelativeTimeText extends ConsumerWidget {
  final DateTime? dateTime;
  final TextStyle? style;

  const RelativeTimeText({super.key, required this.dateTime, this.style});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.watch(relativeTimeTickerProvider);
    return Text(formatRelativeTime(dateTime), style: style);
  }
}

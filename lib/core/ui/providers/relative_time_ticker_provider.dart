import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'relative_time_ticker_provider.g.dart';

@Riverpod(keepAlive: true)
Stream<DateTime> relativeTimeTicker(Ref ref) async* {
  yield DateTime.now();
  yield* Stream.periodic(
    const Duration(minutes: 1),
    (_) => DateTime.now(),
  );
}
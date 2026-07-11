import 'package:dialcalink/core/platform/client/client_storage.dart';
import 'package:dialcalink/core/storage/providers/shared_preferences_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'client_storage_provider.g.dart';

@riverpod
Future<ClientStorage> clientStorage(Ref ref) async {
  final prefs = await ref.watch(sharedPreferencesProvider.future);
  return ClientStorage(prefs);
}
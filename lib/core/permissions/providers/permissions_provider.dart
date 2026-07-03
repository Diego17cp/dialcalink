import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:dialcalink/core/permissions/app_permission.dart';
import 'package:dialcalink/core/permissions/permissions_service.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'permissions_provider.g.dart';

@riverpod
PermissionsService permissionsService(Ref ref) => const PermissionsService();
@riverpod
Future<bool> allPermissionsGranted(Ref ref, AppRole role) {
  final service = ref.watch(permissionsServiceProvider);
  return service.allGrantedForRole(role);
}
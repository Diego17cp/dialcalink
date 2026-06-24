import 'package:notidialca/core/permissions/app_permission.dart';
import 'package:permission_handler/permission_handler.dart';

class PermissionsService {
  const PermissionsService();

  List<AppPermission> permissionsForRole(AppRole role) => AppPermission.values
      .where((p) => p.rolesRequired.contains(role))
      .toList();
  Future<Map<AppPermission, PermissionStatus>> statusForRole(
    AppRole role,
  ) async {
    final permissions = permissionsForRole(role);
    final result = <AppPermission, PermissionStatus>{};
    for (final p in permissions) {
      result[p] = await p.permission.status;
    }
    return result;
  }

  Future<bool> allGrantedForRole(AppRole role) async {
    final statuses = await statusForRole(role);
    return statuses.values.every((status) => status.isGranted);
  }

  Future<Map<AppPermission, PermissionStatus>> requestForRole(AppRole role) async {
    final permissions = permissionsForRole(role);
    final result = <AppPermission, PermissionStatus>{};
    for (final p in permissions) {
      final status = await p.permission.status;
      if (!status.isGranted) {
        result[p] = await p.permission.request();
      } else {
        result[p] = status;
      }
    }
    return result;
  }

  Future<void> openSettings() => openAppSettings();
}

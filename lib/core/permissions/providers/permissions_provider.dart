import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:notidialca/core/permissions/permissions_service.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'permissions_provider.g.dart';

@riverpod
PermissionsService permissionsService(Ref ref) => const PermissionsService();
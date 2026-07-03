import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:dialcalink/core/identity/permissions/contacts_permission_service.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'contacts_permission_provider.g.dart';

@riverpod
ContactsPermissionService contactsPermissionService(Ref ref) => ContactsPermissionService();
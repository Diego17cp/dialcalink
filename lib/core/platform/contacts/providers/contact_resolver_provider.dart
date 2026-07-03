import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:dialcalink/core/identity/permissions/providers/contacts_permission_provider.dart';
import 'package:dialcalink/core/platform/contacts/contact_resolver_service.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'contact_resolver_provider.g.dart';

@riverpod
ContactResolverService contactResolverService(Ref ref) =>
    ContactResolverService(
      permissionService: ref.watch(contactsPermissionServiceProvider),
    );

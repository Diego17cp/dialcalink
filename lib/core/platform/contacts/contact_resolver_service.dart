import 'package:flutter_contacts/flutter_contacts.dart';
import 'package:logger/logger.dart';
import 'package:notidialca/core/identity/permissions/contacts_permission_service.dart';
import 'package:notidialca/core/utils/phone_number_normalizer.dart';

class ContactResolverService {
  ContactResolverService({
    ContactsPermissionService? permissionService,
    Logger? logger,
  }) : _permissionsService = permissionService ?? ContactsPermissionService(),
       _logger = logger ?? Logger();

  final ContactsPermissionService _permissionsService;
  final Logger _logger;

  final Map<String, String?> _cache = {};

  Future<String?> resolveContactName(String phoneNumber) async {
    final cacheKey = PhoneNumberNormalizer.digitsOnly(phoneNumber);
    if (_cache.containsKey(cacheKey)) {
      return _cache[cacheKey];
    }
    final hasPermission = await _permissionsService.hasPermission();
    if (!hasPermission) {
      _logger.w('No permission to access contacts. Cannot resolve contact name for $phoneNumber.');
      return null;
    }
    try {
      final filterFragment = PhoneNumberNormalizer.suffixForNativeFilter(phoneNumber);
      final candidates = await FlutterContacts.getAll(
        properties: const {ContactProperty.name, ContactProperty.phone},
        filter: ContactFilter.phone(filterFragment)
      );
      String? resolvedName;

      for (final contact in candidates) {
        for (final phone in contact.phones) {
          if (PhoneNumberNormalizer.matches(phoneNumber, phone.number)) {
            resolvedName = contact.displayName;
            break;
          }
        }
        if (resolvedName != null) {
          break;
        }
      }
      _cache[cacheKey] = resolvedName;
      return resolvedName;
    } catch (e) {
      _logger.e('Error while resolving contact name for $phoneNumber: $e');
      return null;
    }
  }
  void clearCache() {
    _cache.clear();
  }
}

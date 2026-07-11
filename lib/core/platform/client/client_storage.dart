import 'package:shared_preferences/shared_preferences.dart';

const String _kHasLinkedGateway = 'client.has_linked_gateway';

class ClientStorage {
  ClientStorage(this._prefs);

  final SharedPreferences _prefs;

  bool get hasLinkedGateway => _prefs.getBool(_kHasLinkedGateway) ?? false;

  Future<void> setHasLinkedGateway(bool value) => _prefs.setBool(_kHasLinkedGateway, value);
}
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class SecurePreferenceManager {
  static const xToken = 'monobank-x-token';
  static const FlutterSecureStorage _storage = FlutterSecureStorage();

  Future<String?> getXToken() => _storage.read(key: xToken);

  Future<void> setXToken(String value) =>
      _storage.write(key: xToken, value: value);
}

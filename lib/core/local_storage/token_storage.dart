import 'package:flutter_secure_storage/flutter_secure_storage.dart';

abstract class ITokenStorage {
  Future<void> saveToken(String token);
  Future<String?> getToken();
  Future<void> deletToken();
  Future<String?> get token;
  Future<bool> get hasToken;
}

const String _kToken = 'token';

class TokenStorage extends ITokenStorage {
  @override
  Future<String?> get token async => getToken();
  @override
  Future<bool> get hasToken async => await token != null;

  final secureStorage = const FlutterSecureStorage();
  @override
  Future<void> deletToken() async => await secureStorage.delete(key: _kToken);

  @override
  Future<String?> getToken() async => await secureStorage.read(key: _kToken);

  @override
  Future<void> saveToken(String token) async =>
      await secureStorage.write(key: _kToken, value: token);
}

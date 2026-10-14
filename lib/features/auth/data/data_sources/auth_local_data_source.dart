import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class AuthLocalDataSource {
  static const String accessTokenKey = 'access_token';
  static const String refreshTokenKey = 'refresh_token';

  final FlutterSecureStorage storage;

  const AuthLocalDataSource({required this.storage});

  Future<void> saveTokens({
    required String accessToken,
    required String refreshToken,
  }) async {
    await Future.wait([
      storage.write(key: accessTokenKey, value: accessToken),
      storage.write(key: refreshTokenKey, value: refreshToken),
    ]);
  }

  Future<String?> getAccessToken() async =>
      await storage.read(key: accessTokenKey);

  Future<String?> getRefreshToken() async =>
      await storage.read(key: refreshTokenKey);

  Future<void> clearTokens() async {
    await Future.wait([
      storage.delete(key: accessTokenKey),
      storage.delete(key: refreshTokenKey),
    ]);
  }
}

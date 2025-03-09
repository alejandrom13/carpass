import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class TokenService implements ITokenService {
  final storage = const FlutterSecureStorage();

  @override
  Future<Token?> getToken() async {
    var accessToken = await storage.read(key: 'accessToken') ?? '';
    var refreshToken = await storage.read(key: 'refreshToken') ?? '';

    var tokens = Token(
      accessToken: accessToken,
      refreshToken: refreshToken,
    );
    return tokens;
  }

  @override
  Future<void> setToken(Token tokens) async {
    await storage.write(key: 'accessToken', value: tokens.accessToken);
    await storage.write(key: 'userId', value: tokens.userId.toString());
    await storage.write(key: 'refreshToken', value: tokens.refreshToken);
    // var expirationTime =
    //     DateTime.now().add(Duration(seconds: tokens.expireIn!));

    // await storage.write(
    //     key: 'expirationTime', value: expirationTime.toIso8601String());
  }

  @override
  Future<void> deleteToken() async {
    await storage.deleteAll();
  }
}

class Token {
  final String accessToken;
  final String? refreshToken;
  final DateTime? expirationTime;
  final int? expireIn;
  final String? userId;

  Token(
      {required this.accessToken,
      this.refreshToken,
      this.expirationTime,
      this.userId,
      this.expireIn});
}

abstract class ITokenService {
  Future<Token?> getToken();
  Future<void> setToken(Token tokens);
  Future<void> deleteToken();
}

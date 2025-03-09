import 'package:carpass/config/enviroment.dart';
import 'package:carpass/models/auth/auth.dart';
import 'package:carpass/models/auth/login.dart';
import 'package:carpass/models/auth/user.dart';
import 'package:carpass/models/custom_response.dart';
import 'package:carpass/services/api_service.dart';
import 'package:carpass/services/token_service.dart';
import 'package:carpass/services/user_service.dart';

class AuthRepository {
  final AuthIntegrationAPI _api = AuthIntegrationAPI();
  final _url = 'auth';

  final IUserService _userService = UserService();

  Future<CustomResponse<User>> login(AuthModel user) async {
    var currentUrl = _url;

    return await _api.post(currentUrl, user.toJson()).then((value) async {
      await _userService.setLoginUser(
        email: user.email ?? '',
      );
      if (value.statusCode! >= 200 && value.statusCode! < 300) {
        return CustomResponse(
            data: User.fromJson(user.toJson()),
            statusCode: value.statusCode,
            success: true);
      } else {
        return CustomResponse(
          success: false,
          statusCode: value.statusCode,
          message: value.data['message'],
        );
      }
    });
  }

  Future<CustomResponse<User>> verify(AuthModel user) async {
    var currentUrl = '$_url/verify';
    print(user.toJson());

    return await _api.post(currentUrl, user.toJson()).then((value) async {
      if (value.statusCode! >= 200 && value.statusCode! < 300) {
        // ITokenService tokenService = TokenService();
        Enviroment.accessToken = value.data['accessToken'];
        // await tokenService.setToken(tokens);
        return CustomResponse(
          success: true,
          data: User.fromJson(value.data),
          statusCode: value.statusCode,
        );
      } else {
        return CustomResponse(
          success: false,
          statusCode: value.statusCode,
          message: value.data['message'],
        );
      }
    });
  }

  Future<CustomResponse<User>> refreshToken() async {
    ITokenService tokenService = TokenService();
    Token? refreshToken = await tokenService.getToken();
    await tokenService.deleteToken();
    if (refreshToken == null) {
      return CustomResponse(
        success: false,
        statusCode: 401,
        message: 'Unauthorized',
      );
    }
    return await _api.post('$_url/refresh', {
      'refreshToken': refreshToken.refreshToken,
    }).then((value) async {
      if (value.statusCode! >= 200 && value.statusCode! < 300) {
        Token tokens = Token(
          accessToken: value.data['accessToken'],
          refreshToken: value.data['refreshToken'],
        );

        await tokenService.setToken(tokens);

        return CustomResponse(
          success: true,
          data: User.fromJson(value.data),
          statusCode: value.statusCode,
        );
      }

      return CustomResponse(
        success: false,
        statusCode: 401,
        message: 'Unauthorized',
      );
    });
  }
}

class UserRepository {
  final IntegrationAPI _api = IntegrationAPI();
  final _url = 'auth';

  Future<CustomResponse<UserModel>> getUser() async {
    return _api.get('$_url/me').then((value) {
      if (value.statusCode! >= 200 && value.statusCode! < 300) {
        return CustomResponse(
          data: UserModel.fromJson(value.data),
          success: true,
          statusCode: value.statusCode,
        );
      }
      return CustomResponse(
        success: false,
        statusCode: value.statusCode,
        message: value.data['message'],
      );
    });
  }
}

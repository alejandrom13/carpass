import 'package:carpass/config/enviroment.dart';
import 'package:carpass/data/auth_repository.dart';
import 'package:carpass/services/token_service.dart';
import 'package:dio/dio.dart';

class IntegrationAPI {
  ITokenService tokenService = TokenService();

  final dio = Dio(BaseOptions(
    baseUrl: Enviroment.baseApiUrl,
    receiveDataWhenStatusError: true,
    validateStatus: (status) => status != null,
  ));

  IntegrationAPI() {
    dio.interceptors.add(InterceptorsWrapper(
      onRequest: (options, handler) async {
        var token = await tokenService.getToken();
        if (token != null) {
          options.headers['Authorization'] = 'Bearer ${Enviroment.accessToken}';
        }
        return handler.next(options);
      },
      onResponse: (response, handler) async {
        if (response.statusCode == 401) {
          var token = await tokenService.getToken();
          if (token!.refreshToken == null) {
            return handler.next(response);
          }
          AuthRepository authRepository = AuthRepository();
          await authRepository.refreshToken();
          response = await dio.request(
            response.requestOptions.path,
            data: response.requestOptions.data,
            queryParameters: response.requestOptions.queryParameters,
            options: Options(
              headers: response.requestOptions.headers,
              method: response.requestOptions.method,
            ),
          );
        }

        return handler.next(response);
      },
    ));
  }

  Future<Response> get(String url) async {
    var response = await dio.get(url);
    return response;
  }

  Future<Response> post(String url, dynamic data) async {
    try {
      var response = await dio.post(url, data: data);

      return response;
    } catch (e) {
      print(e);
    }
    return Response(requestOptions: RequestOptions(path: ''));
  }

  Future<Response> delete(String url) async {
    try {
      var response = await dio.delete(url);
      return response;
    } catch (e) {
      print(e);
    }
    return Response(requestOptions: RequestOptions(path: ''));
  }

  Future<Response> post_(String url) async {
    try {
      var response = await dio.post(url);
      return response;
    } catch (e) {
      print(e);
    }
    return Response(requestOptions: RequestOptions(path: ''));
  }

  Future<Response> put(String url, dynamic data) async {
    var response = await dio.put(url, data: data);
    return response;
  }

  Future<Response> patch(String url, dynamic data) async {
    var response = await dio.patch(url, data: data);
    return response;
  }
}

class AuthIntegrationAPI {
  ITokenService tokenService = TokenService();

  final dio = Dio(BaseOptions(
    baseUrl: Enviroment.baseApiUrl,
    receiveDataWhenStatusError: true,
    validateStatus: (status) => status != null,
  ));

  Future<Response> post(String url, dynamic data) async {
    try {
      var response = await dio.post(url, data: data);

      return response;
    } catch (e) {
      print(e);
    }
    return Response(requestOptions: RequestOptions(path: ''));
  }
}

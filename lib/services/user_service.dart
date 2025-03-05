import 'package:carpass/models/auth/login.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract class IUserService {
  Future<LoginModel> getUser();
  setLoginUser({required String email});
  setUser(User model);
  Future<User> getUserInfo();
}

class UserService extends IUserService {
  final storage = const FlutterSecureStorage();

  @override
  setLoginUser({required String email}) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('email', email.toString());
  }

  @override
  Future<User> getUserInfo() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    var user = User(
      email: prefs.getString('email'),
    );

    return user;
  }

  deleteUser() async {
    await storage.deleteAll();
  }

  @override
  setUser(User model) async {
    await storage.write(key: 'email', value: model.email);
    await storage.write(key: 'name', value: model.name);
  }

  @override
  Future<LoginModel> getUser() async {
    var portId = await storage.read(key: 'portId');
    if (portId == null) {
      return LoginModel();
    }
    var data = LoginModel(
      email: await storage.read(key: 'email'),
      name: await storage.read(key: 'name'),
    );

    return data;
  }
}

import 'package:carpass/features/auth/providers/auth_provider.dart';
import 'package:carpass/models/auth/auth.dart';
import 'package:carpass/services/token_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final goRouternotifierProvider = Provider((ref) {
  final authNotifier = ref.read(authProvider.notifier);
  return GoRouterNotifier(authNotifier);
});

class GoRouterNotifier extends ChangeNotifier {
  final AuthNotifier authProvider;

  AuthStatus _authStatus = AuthStatus.unauthenticated;
  AuthStatus get authStatus => _authStatus;

  set authStatus(AuthStatus value) {
    _authStatus = value;
    notifyListeners();
  }

  GoRouterNotifier(this.authProvider) {
    authProvider.addListener((state) {
      authStatus = state.authStatus;
    });
    getoken();
  }

  getoken() async {
    TokenService service = TokenService();
    var token = await service.getToken();
    if (token!.accessToken.isNotEmpty) {
      authStatus = AuthStatus.authenticated;
    } else {
      authStatus = AuthStatus.checking;
    }
    notifyListeners();
  }

  goToLogin() {
    authStatus = AuthStatus.unauthenticated;
    notifyListeners();
  }
}

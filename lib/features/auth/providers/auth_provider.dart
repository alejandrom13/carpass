import 'package:carpass/data/auth_repository.dart';
import 'package:carpass/models/auth/auth.dart';
import 'package:carpass/models/custom_response.dart';
import 'package:carpass/services/token_service.dart';
import 'package:carpass/services/user_service.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:reactive_forms/reactive_forms.dart';

final authProvider = StateNotifierProvider<AuthNotifier, AuthState>((ref) {
  return AuthNotifier();
});

class AuthNotifier extends StateNotifier<AuthState> {
  AuthNotifier() : super(AuthState());
  final UserService _userService = UserService();
  login() {
    state =
        state.copyWith(authStatus: AuthStatus.authenticated, errorMessage: '');
  }

  restart() {
    state = state.copyWith(authStatus: AuthStatus.checking);
  }

  verified() {
    state = state.copyWith(authStatus: AuthStatus.verified);
  }

  logout() async {
    // Isar isar = await LocalStorageManager.openConnection();
    // if (await exportHasPendingSync(isar) || await importHasPendingSync(isar)) {
    //   if (mounted) {
    //     state = state.copyWith(
    //         authStatus: AuthStatus.authenticated,
    //         errorMessage: 'Please sync data before logging out');
    //   }
    // } else {
    TokenService tokenService = TokenService();
    await tokenService.deleteToken();
    await _userService.deleteUser();
    if (mounted) {
      state = state.copyWith(authStatus: AuthStatus.unauthenticated);
    }
    // }
  }

  getUser() async {
    var user = await _userService.getUserInfo();
    loginForm.control('email').value = user.email;
  }
}

final validateProvider = StateNotifierProvider<ValidateNotifier,
    AsyncValue<CustomResponse<AuthModel>>>((ref) {
  return ValidateNotifier(ref);
});

final _authRepository = AuthRepository();

class ValidateNotifier
    extends StateNotifier<AsyncValue<CustomResponse<AuthModel>>> {
  ValidateNotifier(this.ref)
      : super(AsyncValue.data(
            CustomResponse(data: AuthModel(type: AuthType.none))));

  Ref ref;

  void verify({required String code}) async {
    loginForm.markAllAsTouched();
    if (loginForm.invalid || code.isEmpty) {
      return;
    }
    state = const AsyncValue.loading();
    var model = AuthModel(
      email: loginForm.control('email').value,
      code: code,
      type: AuthType.passwordless,
    );
    var response = await _authRepository.verify(model);
    if (response.success!) {
      ref.read(authProvider.notifier).login();
      state = AsyncValue.data(CustomResponse());
    } else {
      var errorObject = {
        'message': response.message,
      };
      state = AsyncValue.error(errorObject, StackTrace.current);
    }
  }

  restart() {
    state = AsyncValue.data(CustomResponse(data: AuthModel()));
    ref.read(authProvider.notifier).restart();
  }

  void getUser() async {
    IUserService userService = UserService();
    await userService.getUserInfo();
  }

  void auth() async {
    loginForm.markAllAsTouched();
    if (loginForm.invalid) {
      return;
    }
    state = const AsyncValue.loading();
    var model = AuthModel(
      email: loginForm.control('email').value,
    );
    var result = await _authRepository.login(model);
    if (result.success!) {
      ref.read(authProvider.notifier).verified();
      state = AsyncValue.data(CustomResponse(data: model));
    } else {
      var errorObject = {
        'message': result.message,
      };
      state = AsyncValue.error(errorObject, StackTrace.current);
    }
  }
}

final loginForm = FormGroup({
  'email':
      FormControl<String>(validators: [Validators.required, Validators.email]),
});

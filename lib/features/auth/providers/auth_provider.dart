import 'dart:async';

import 'package:carpass/data/auth_repository.dart';
import 'package:carpass/models/auth/auth.dart';
import 'package:carpass/models/auth/login.dart';
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

  signUp() {
    state = state.copyWith(authStatus: AuthStatus.signingUp);
  }

  restart() {
    state = state.copyWith(authStatus: AuthStatus.checking);
  }

  verified() {
    state = state.copyWith(authStatus: AuthStatus.verified);
  }

  logout() async {
    TokenService tokenService = TokenService();
    await tokenService.deleteToken();
    await _userService.deleteUser();
    if (mounted) {
      state = state.copyWith(authStatus: AuthStatus.unauthenticated);
    }
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
  IUserService userService = UserService();

  void verify({
    required String code,
  }) async {
    loginForm.markAllAsTouched();
    if (loginForm.invalid || code.isEmpty) {
      var errorObject = {
        'message': 'Por favor, ingrese un código válido',
      };
      state = AsyncValue.error(errorObject, StackTrace.current);
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
    await userService.getUserInfo();
  }

  void resend() async {
    User user = await userService.getUserInfo();
    loginForm.control('email').value = user.email;
    await auth(authType: AuthType.passwordless);
  }

  void startCountdown() {
    ref.read(isResendEnabledProvider.notifier).state =
        false; // 🔒 Desactivar botón de reenvío
    ref.read(countdownProvider.notifier).state = Duration(minutes: 5);

    Timer.periodic(Duration(seconds: 1), (timer) {
      final timeLeft =
          ref.read(countdownProvider.notifier).state - Duration(seconds: 1);

      if (timeLeft.isNegative) {
        ref.read(countdownProvider.notifier).state = Duration.zero;
        ref.read(isResendEnabledProvider.notifier).state =
            true; // 🔓 Activar botón de reenvío
        timer.cancel();
      } else {
        ref.read(countdownProvider.notifier).state = timeLeft;
      }
    });
  }

  Future<void> auth({required AuthType authType}) async {
    FormGroup form = authType == AuthType.signUp ? signUpForm : loginForm;

    form.markAllAsTouched();
    if (form.invalid) {
      return;
    }
    state = const AsyncValue.loading();
    var model = AuthModel(
      email: form.control('email').value,
      name: authType == AuthType.signUp ? form.control('name').value : null,
      type: authType,
    );
    var result = await _authRepository.login(model);
    if (result.success!) {
      startCountdown();
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
  'email': FormControl<String>(
    validators: [Validators.required, Validators.email],
  ),
  'name': FormControl<String>(),
});

final signUpForm = FormGroup({
  'email': FormControl<String>(
    validators: [Validators.required, Validators.email],
  ),
  'name': FormControl<String>(validators: [Validators.required]),
});

final countdownProvider = StateProvider<Duration>((ref) => Duration.zero);
final isResendEnabledProvider = StateProvider<bool>((ref) => true);

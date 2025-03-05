import 'dart:async';

import 'package:carpass/features/auth/providers/auth_provider.dart';
import 'package:carpass/models/auth/auth.dart';
import 'package:carpass/models/custom_response.dart';
import 'package:carpass/theme/button.dart';
import 'package:carpass/theme/input.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:reactive_forms/reactive_forms.dart';

class LoginPage extends ConsumerStatefulWidget {
  const LoginPage({super.key});

  @override
  ConsumerState<LoginPage> createState() => _LoginState();
}

class _LoginState extends ConsumerState<LoginPage> {
  String currentText = "";

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var model = ref.watch(validateProvider);

    return Scaffold(
        resizeToAvoidBottomInset: true,
        body: Padding(
          padding: const EdgeInsets.all(20),
          child: ReactiveForm(
            formGroup: loginForm,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset('assets/logo.png', height: 25),
                  ],
                ),
                const SizedBox(height: 50),
                SwipInput(
                  context: context,
                  labeltext: 'Correo Electrónico',
                  type: InputType.email,
                  formControlName: 'email',
                ),
                const SizedBox(height: 10),
                model.when(
                    data: (CustomResponse<AuthModel>? data) {
                      return const SizedBox.shrink();
                    },
                    loading: () => const SizedBox.shrink(),
                    error: (error, _) {
                      var value = error as Map<String, String?>;
                      return Padding(
                        padding: const EdgeInsets.only(left: 12.0),
                        child: Text(
                            value["message"] ?? "Error al iniciar sesión",
                            style: const TextStyle(color: Colors.red)),
                      );
                    }),
                const SizedBox(height: 30),
                SwipButton(
                    labeltxt: 'Iniciar Sesión',
                    context: context,
                    isLoading: model.isLoading,
                    primary: true,
                    onPressed: () => setState(() {
                          ref.read(validateProvider.notifier).auth();
                        })),
                SizedBox(
                  height: 15,
                ),
                SwipButton(
                  labeltxt: 'Registrarse',
                  context: context,
                  isLoading: false,
                  primary: false,
                  onPressed: () => setState(
                    () {
                      // ref.read(validateProvider.notifier).login();
                    },
                  ),
                ),
              ],
            ),
          ),
        ));
  }
}

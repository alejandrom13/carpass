import 'package:carpass/features/auth/providers/auth_provider.dart';
import 'package:carpass/models/auth/auth.dart';
import 'package:carpass/models/custom_response.dart';
import 'package:carpass/theme/button.dart';
import 'package:carpass/theme/input.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:reactive_forms/reactive_forms.dart';

class SignUpPage extends ConsumerStatefulWidget {
  const SignUpPage({super.key});

  @override
  ConsumerState<SignUpPage> createState() => _SignUpState();
}

class _SignUpState extends ConsumerState<SignUpPage> {
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
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () {
              ref.read(validateProvider.notifier).restart();
            },
          ),
        ),
        resizeToAvoidBottomInset: true,
        body: Padding(
          padding: const EdgeInsets.all(20),
          child: ReactiveForm(
            formGroup: signUpForm,
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
                  labeltext: 'Nombre',
                  type: InputType.email,
                  formControlName: 'name',
                ),
                const SizedBox(height: 10),
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
                        child: Text(value["message"] ?? "Error al registrarse",
                            style: const TextStyle(color: Colors.red)),
                      );
                    }),
                const SizedBox(height: 30),
                SwipButton(
                    labeltxt: 'Registrarse',
                    context: context,
                    isLoading: model.isLoading,
                    primary: true,
                    onPressed: () => setState(() {
                          ref
                              .read(validateProvider.notifier)
                              .auth(authType: AuthType.signUp);
                        })),
              ],
            ),
          ),
        ));
  }
}

import 'dart:async';

import 'package:carpass/features/auth/providers/auth_provider.dart';
import 'package:carpass/theme/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

class CodeVerification extends ConsumerStatefulWidget {
  const CodeVerification({super.key});

  @override
  ConsumerState<CodeVerification> createState() => _CodeVerificationState();
}

class _CodeVerificationState extends ConsumerState<CodeVerification> {
  TextEditingController codeController = TextEditingController();

  StreamController<ErrorAnimationType>? errorController;
  @override
  void initState() {
    super.initState();
    errorController = StreamController<ErrorAnimationType>();
    ref.read(validateProvider.notifier).getUser();
  }

  @override
  Widget build(BuildContext context) {
    var validate = ref.watch(validateProvider);
    final timeLeft = ref.watch(countdownProvider);
    final isResendEnabled = ref.watch(isResendEnabledProvider);

    String formatDuration(Duration duration) {
      String twoDigits(int n) => n.toString().padLeft(2, "0");
      String minutes = twoDigits(duration.inMinutes.remainder(60));
      String seconds = twoDigits(duration.inSeconds.remainder(60));
      return "$minutes:$seconds";
    }

    codeController.text = '';

    return Scaffold(
      appBar: AppBar(
        title: const Text('Verificación de Código'),
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            ref.read(validateProvider.notifier).restart();
          },
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                'Te hemos enviado un código a ${loginForm.control('email').value}, colócalo debajo:',
                style: textTheme.titleMedium!.copyWith(
                    color: const Color.fromARGB(255, 0, 0, 0).withOpacity(0.8),
                    fontWeight: FontWeight.normal),
              ),
              const SizedBox(
                height: 30,
              ),

              PinCodeTextField(
                textStyle: const TextStyle(
                  color: Color.fromARGB(255, 0, 0, 0),
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                ),
                hintStyle: TextStyle(
                  color: const Color.fromARGB(255, 0, 0, 0).withOpacity(0.4),
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                ),
                useHapticFeedback: true,
                hintCharacter: '0',
                appContext: context,
                pastedTextStyle: const TextStyle(
                  color: Color.fromARGB(255, 0, 0, 0),
                  fontWeight: FontWeight.bold,
                ),
                length: 6,
                obscureText: false,
                blinkWhenObscuring: true,
                animationType: AnimationType.fade,
                validator: (v) {
                  return null;
                },
                pinTheme: PinTheme(
                  shape: PinCodeFieldShape.box,
                  borderRadius: BorderRadius.circular(10),
                  fieldHeight: 60,
                  fieldWidth: MediaQuery.of(context).size.height * 0.32 / 5,
                  activeFillColor: const Color.fromARGB(255, 218, 218, 218),
                  activeBorderWidth: 2,
                  activeColor: const Color.fromARGB(255, 218, 218, 218),
                  selectedColor: Colors.black,
                  selectedFillColor: const Color.fromARGB(255, 218, 218, 218),
                  inactiveColor: const Color.fromARGB(255, 218, 218, 218),
                  inactiveFillColor: const Color.fromARGB(255, 218, 218, 218),
                  errorBorderColor: Colors.red,
                ),
                cursorColor: const Color.fromARGB(255, 0, 0, 0),
                animationDuration: const Duration(milliseconds: 300),
                enableActiveFill: true,
                errorAnimationController: errorController,
                controller: codeController,
                keyboardType: TextInputType.number,
                // onCompleted: (v) {
                //   ref
                //       .read(validateProvider.notifier)
                //       .verify(code: codeController.text);
                // },
                onChanged: (value) {
                  if (value.length == 6) {
                    ref
                        .read(validateProvider.notifier)
                        .verify(code: codeController.text);
                  }
                },
                beforeTextPaste: (text) {
                  debugPrint("Allowing to paste $text");
                  return true;
                },
              ),

              const SizedBox(
                height: 10,
              ),
              Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: !isResendEnabled
                      ? [
                          Text(
                            timeLeft.inSeconds > 0
                                ? "Reenviar código en: ${formatDuration(timeLeft)}"
                                : "Código vencido",
                            style: textTheme.titleLarge!.copyWith(
                              color: const Color.fromARGB(255, 0, 0, 0)
                                  .withOpacity(0.8),
                              fontWeight: FontWeight.bold,
                            ),
                          )
                        ]
                      : [
                          Text('¿No recibiste el código? ',
                              style: textTheme.titleLarge!.copyWith(
                                color: const Color.fromARGB(255, 0, 0, 0)
                                    .withOpacity(0.8),
                                fontWeight: FontWeight.normal,
                              )),
                          InkWell(
                            onTap: isResendEnabled
                                ? () {
                                    ref
                                        .read(validateProvider.notifier)
                                        .resend();
                                  }
                                : null,
                            child: Text(
                              'Reenviar',
                              style: textTheme.titleLarge!.copyWith(
                                  color: const Color.fromARGB(255, 0, 0, 0)
                                      .withOpacity(0.8),
                                  fontWeight: FontWeight.bold,
                                  decoration: TextDecoration.underline),
                            ),
                          )
                        ]),

              const SizedBox(
                height: 30,
              ),
              validate.when(
                  data: (data) {
                    return SizedBox.shrink();
                  },
                  loading: () => const CircularProgressIndicator(),
                  error: (error, _) {
                    errorController!.add(ErrorAnimationType.shake);
                    return Text("El código que ingresaste es incorrecto");
                  }),
              // Text(
              //   message ?? '',
              //   style: textTheme.labelMedium,
              // )
            ],
          ),
        ),
      ),
    );
  }
}

import 'package:carpass/theme/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:reactive_forms/reactive_forms.dart';

enum InputType { number, email, defaultInput, password }

Widget SwipInput(
    {required String labeltext,
    required InputType type,
    required String formControlName,
    dynamic onChanged,
    dynamic onSubmitted,
    ontap,
    Widget? suffixIcon,
    bool? isReactive = true,
    bool readOnly = false,
    required context}) {
  var keyboard = switch (type) {
    InputType.number => TextInputType.number,
    InputType.email => TextInputType.emailAddress,
    InputType.defaultInput => TextInputType.text,
    InputType.password => TextInputType.text,
  };
  return ReactiveTextField(
    onSubmitted: onSubmitted,
    readOnly: readOnly,
    onChanged: onChanged,
    formControlName: formControlName,
    inputFormatters: type == InputType.number
        ? [FilteringTextInputFormatter.allow(RegExp(r'(^\d*\.?\d*)'))]
        : [],
    validationMessages: {
      ValidationMessage.number: (error) => "Este campo debe ser un número",
      ValidationMessage.required: (error) => "Este campo es requerido",
      ValidationMessage.min: (error) => "Este campo debe ser mayor a 0",
      ValidationMessage.email: (error) =>
          "Introduzca un correo electrónico válido",
    },
    onTapOutside: (event) => FocusScope.of(context).unfocus(),
    keyboardType: keyboard,
    obscureText: type == InputType.password,
    onTap: ontap,
    decoration: InputDecoration(
        filled: true,
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(color: theme.primaryColor, width: 1.5),
        ),
        floatingLabelStyle: textTheme.titleLarge!.copyWith(
          color: theme.primaryColor,
        ),
        suffixIcon: suffixIcon,
        label: Text(
          labeltext,
          style: textTheme.titleLarge!.copyWith(
            color: theme.colorScheme.secondary,
          ),
        ),
        fillColor: theme.colorScheme.surface,
        focusColor: theme.primaryColor,
        border: OutlineInputBorder(
          borderSide: BorderSide.none,
          borderRadius: BorderRadius.circular(10),
        )),
  );
}

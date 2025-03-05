import 'package:carpass/theme/theme.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

showSnackBar(String message, bool success, Function() onVisible, scaffoldKey) {
  var snackBar = SnackBar(
    backgroundColor: success ? theme.primaryColor : theme.colorScheme.error,
    content: Text(
      message,
      style: textTheme.titleMedium!.copyWith(
        color: Colors.white,
      ),
    ),
    onVisible: onVisible,
  );
  scaffoldKey.currentState?.showSnackBar(snackBar);
}

Visibility CustomValidationMessage({required bool visible, String? message}) {
  return Visibility(
    visible: visible,
    child: Padding(
      padding: const EdgeInsets.only(top: 5.0, left: 10.0),
      child: Text(
        message ?? 'Este campo es requerido',
        style: textTheme.titleSmall!.copyWith(color: theme.colorScheme.error),
      ),
    ),
  );
}

Visibility LoadingAlert({required bool value, required String text}) {
  return Visibility(
    visible: value,
    child: Container(
      height: 40,
      decoration: BoxDecoration(
        color: const Color.fromARGB(255, 134, 134, 134),
        borderRadius: const BorderRadius.all(Radius.circular(10)),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(text,
              style: const TextStyle(
                color: Color.fromARGB(255, 255, 255, 255),
              )),
          const SizedBox(width: 10),
          const CupertinoActivityIndicator(
            color: Color.fromARGB(255, 255, 255, 255),
          )
        ],
      ),
    ),
  );
}

Visibility CustomAlert({
  required bool value,
  required String text,
  required onPressed,
  required BuildContext context,
  required AlertType alertType,
}) {
  return Visibility(
    visible: value,
    child: Container(
      decoration: BoxDecoration(
        borderRadius: alertType == AlertType.offline
            ? const BorderRadius.all(Radius.zero)
            : const BorderRadius.all(Radius.circular(5)),
        color: alertType == AlertType.error
            ? theme.colorScheme.error
            : const Color.fromARGB(255, 193, 191, 191),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Row(
        mainAxisAlignment: alertType == AlertType.offline
            ? MainAxisAlignment.center
            : MainAxisAlignment.spaceBetween,
        children: [
          Container(
            padding: const EdgeInsets.symmetric(vertical: 10),
            constraints: BoxConstraints(
                maxWidth: MediaQuery.of(context).size.width * 0.8),
            child: Text(
              text,
              overflow: TextOverflow.ellipsis,
              maxLines: 3,
              style: const TextStyle(color: Colors.white),
            ),
          ),
          Container(
            constraints: BoxConstraints(
                maxWidth: MediaQuery.of(context).size.width * 0.2),
            padding: const EdgeInsets.symmetric(vertical: 10),
            child: alertType == AlertType.offline
                ? const Icon(Icons.signal_wifi_connected_no_internet_4,
                    color: Color.fromARGB(255, 255, 255, 255))
                : alertType == AlertType.info
                    ? const Icon(
                        Icons.info,
                        color: Color.fromARGB(255, 255, 255, 255),
                      )
                    : onPressed != null
                        ? IconButton(
                            icon: const Icon(Icons.close_rounded),
                            onPressed: onPressed,
                            color: alertType == AlertType.error
                                ? theme.colorScheme.error
                                : const Color.fromARGB(255, 193, 191, 191),
                          )
                        : const SizedBox(),
          ),
        ],
      ),
    ),
  );
}

AlertDialog CustomDialog({
  required title,
  required content,
  required onCancel,
  required onAccept,
  required String btntxt,
}) {
  return AlertDialog(
    actionsAlignment: MainAxisAlignment.spaceBetween,
    title: Text(title, style: textTheme.displayMedium),
    content: Text(content, style: textTheme.displaySmall),
    actions: [
      TextButton(onPressed: onCancel, child: const Text('Cancelar')),
      TextButton(onPressed: onAccept, child: Text(btntxt)),
    ],
  );
}

enum AlertType { success, error, warning, info, offline }

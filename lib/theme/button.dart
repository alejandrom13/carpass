import 'package:carpass/theme/theme.dart';
import 'package:flutter/material.dart';

Widget SwipButton({
  required BuildContext context,
  required bool isLoading,
  required Function() onPressed,
  required String labeltxt,
  required bool primary,
}) {
  return IgnorePointer(
    ignoring: isLoading,
    child: SizedBox(
      width: MediaQuery.of(context).size.width,
      height: 60,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          elevation: 0,
          side: BorderSide(
            color: theme.primaryColor,
            width: 2,
          ),
          backgroundColor: primary ? theme.primaryColor : Colors.transparent,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
        child: !isLoading
            ? Text(labeltxt,
                style: textTheme.labelLarge!.copyWith(
                  color: primary
                      ? theme.colorScheme.onPrimary
                      : theme.primaryColor,
                ))
            : SizedBox(
                height: 25,
                width: 25,
                child: Center(
                  widthFactor: 1,
                  child: CircularProgressIndicator(
                    strokeWidth: 3,
                    color: theme.colorScheme.onPrimary,
                  ),
                ),
              ),
      ),
    ),
  );
}

Widget SwipIconButton({
  required BuildContext context,
  required bool isLoading,
  required Function() onPressed,
  required String labeltxt,
  Widget? suffixIcon,
  Widget? prefixIcon,
}) {
  return IgnorePointer(
    ignoring: isLoading,
    child: SizedBox(
      width: MediaQuery.of(context).size.width,
      height: 60,
      child: ElevatedButton.icon(
          onPressed: onPressed,
          style: ElevatedButton.styleFrom(
            elevation: 0,
            backgroundColor: theme.primaryColor,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(50),
                side: BorderSide(
                  color: Color.fromRGBO(255, 255, 255, 0.42),
                  width: 3,
                )),
          ),
          label: Row(
            mainAxisAlignment: suffixIcon == null
                ? MainAxisAlignment.center
                : MainAxisAlignment.spaceBetween,
            children: [
              prefixIcon != null
                  ? Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        prefixIcon,
                        SizedBox(
                          width: 15,
                        ),
                        Text(
                          labeltxt,
                          style: textTheme.labelLarge!.copyWith(
                            color: theme.colorScheme.onPrimary,
                          ),
                        ),
                      ],
                    )
                  : Text(
                      labeltxt,
                      style: textTheme.labelLarge!.copyWith(
                        color: theme.colorScheme.onPrimary,
                      ),
                    ),
              !isLoading
                  ? suffixIcon ?? SizedBox.shrink()
                  : SizedBox(
                      height: 25,
                      width: 25,
                      child: Center(
                        widthFactor: 1,
                        child: CircularProgressIndicator(
                          strokeWidth: 3,
                          color: theme.colorScheme.onPrimary,
                        ),
                      ),
                    ),
            ],
          )),
    ),
  );
}

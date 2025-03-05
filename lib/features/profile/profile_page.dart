import 'package:carpass/features/report/providers/user_provider.dart';
import 'package:carpass/features/report/unlock-report/unlock_report.dart';
import 'package:carpass/models/option_model.dart';
import 'package:carpass/theme/button.dart';
import 'package:carpass/theme/theme.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ProfilePage extends ConsumerWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var user = ref.watch(userProvider);
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(15),
          child: Column(
            children: [
              Container(
                padding: EdgeInsets.all(15),
                // height: 96,
                width: MediaQuery.sizeOf(context).width,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(18),
                  border: Border.all(
                    width: 1,
                    color: Color.fromRGBO(232, 232, 232, 1),
                  ),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SizedBox(
                      width: MediaQuery.sizeOf(context).width * 0.1,
                      child: CircleAvatar(
                        radius: 25,
                      ),
                    ),
                    user.when(
                      data: (data) => SizedBox(
                        width: MediaQuery.sizeOf(context).width * 0.72,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              data.name ?? '',
                              style: textTheme.labelLarge!.copyWith(
                                  color: theme.colorScheme.onPrimaryContainer,
                                  fontWeight: FontWeight.w700),
                            ),
                            SizedBox(height: 2),
                            Text(
                              data.email ?? '',
                              style: textTheme.labelLarge!.copyWith(
                                  color: theme.colorScheme.onPrimaryContainer,
                                  fontWeight: FontWeight.w200),
                            ),
                            SizedBox(height: 2),
                            Text(
                              '${data.credits} Créditos',
                              style: textTheme.labelLarge!.copyWith(
                                  color: theme.colorScheme.tertiary,
                                  fontWeight: FontWeight.w700),
                            ),
                          ],
                        ),
                      ),
                      error: (error, stackTrace) => SizedBox.shrink(),
                      loading: () => SizedBox.shrink(),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 20),
              SwipIconButton(
                context: context,
                isLoading: false,
                onPressed: () {
                  showModalBottomSheet(
                    backgroundColor: Colors.white,
                    showDragHandle: true,
                    context: context,
                    isScrollControlled:
                        true, // Permite ocupar más espacio si es necesario
                    shape: RoundedRectangleBorder(
                      borderRadius:
                          BorderRadius.vertical(top: Radius.circular(16)),
                    ),
                    builder: (context) {
                      return SizedBox(
                        height: MediaQuery.sizeOf(context).height *
                            0.6, // Altura específica del modal
                        child: Padding(
                          padding: EdgeInsets.all(16.0),
                          child: UnlockReport(
                            buyCredits: true,
                          ),
                        ),
                      );
                    },
                  );
                },
                labeltxt: 'Comprar Créditos',
                prefixIcon: Icon(
                  CupertinoIcons.creditcard,
                  color: Colors.white,
                  size: 24,
                ),
                suffixIcon: Icon(
                  Icons.arrow_forward,
                  color: Colors.white,
                  size: 24,
                ),
              ),
              SizedBox(height: 30),
              Column(
                children: List.generate(options.length, (index) {
                  return Padding(
                    padding: EdgeInsets.symmetric(horizontal: 15, vertical: 15),
                    child: InkWell(
                      child: Row(
                        children: [
                          Icon(
                            options[index].icon,
                            color: options[index].iconColor ??
                                theme.colorScheme.onPrimaryContainer,
                          ),
                          SizedBox(width: 15),
                          Text(
                            options[index].title,
                            style: textTheme.labelLarge!.copyWith(
                                fontFamily: 'Inter',
                                color: options[index].iconColor ??
                                    Color.fromRGBO(40, 40, 40, 1),
                                fontWeight: FontWeight.w500),
                          ),
                        ],
                      ),
                    ),
                  );
                }),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

List<Option> options = [
  Option(
    icon: Icons.history,
    title: 'Historial de Créditos',
    value: 0,
  ),
  Option(
    icon: Icons.help_outline,
    title: 'Ayuda',
    value: 0,
  ),
  Option(
    icon: CupertinoIcons.globe,
    title: 'Términos y Condiciones',
    value: 0,
  ),
  Option(
    icon: Icons.privacy_tip_outlined,
    title: 'Política de Privacidad',
    value: 0,
  ),
  Option(
    icon: CupertinoIcons.power,
    title: 'Cerrar Sesión',
    iconColor: Color.fromRGBO(246, 91, 91, 1),
    value: 0,
  ),
];

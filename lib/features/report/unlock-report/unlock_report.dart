import 'package:carpass/features/report/providers/pricing_provider.dart';
import 'package:carpass/features/report/providers/user_provider.dart';
import 'package:carpass/features/report/providers/vehicle_provider.dart';
import 'package:carpass/theme/CustomIcons_icons.dart';
import 'package:carpass/theme/button.dart';
import 'package:carpass/theme/theme.dart';
import 'package:flutter/material.dart';
import 'dart:core';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class UnlockReport extends ConsumerStatefulWidget {
  UnlockReport({super.key, this.buyCredits = false});
  bool buyCredits;

  @override
  ConsumerState<UnlockReport> createState() => _UnlockReportState();
}

class _UnlockReportState extends ConsumerState<UnlockReport> {
  @override
  Widget build(BuildContext context) {
    var user = ref.watch(userProvider);

    return widget.buyCredits
        ? PricingPage()
        : ClipRRect(
            borderRadius: BorderRadius.circular(16),
            child: Scaffold(
              bottomNavigationBar: Padding(
                padding: const EdgeInsets.all(15.0),
                child: SwipIconButton(
                  context: context,
                  isLoading: false,
                  onPressed: () {
                    ref.read(vehicleProvider.notifier).unlockReport();
                    Navigator.pop(context);
                  },
                  labeltxt: "Generar Reporte",
                  prefixIcon: Icon(
                    CustomIcons.unlock,
                    color: Colors.white,
                    size: 24,
                  ),
                ),
              ),
              body: SafeArea(
                  child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15.0),
                child: Column(
                  children: [
                    Text('¿Estas seguro que deseas generar este reporte?',
                        style: TextStyle(fontSize: 20),
                        textAlign: TextAlign.center),
                    SizedBox(
                      height: 15,
                    ),
                    user.when(
                      data: (data) => Container(
                        decoration: BoxDecoration(
                            border: Border.all(
                                color: Color.fromRGBO(232, 232, 232, 1)),
                            borderRadius: BorderRadius.circular(50)),
                        padding: EdgeInsets.all(10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text('Balance Actual: ',
                                style: TextStyle(
                                    fontSize: 14,
                                    color: Color.fromRGBO(118, 118, 118, 1))),
                            Text('${data.credits} créditos',
                                style: TextStyle(
                                    fontSize: 14,
                                    color: Color.fromRGBO(63, 183, 125, 1))),
                          ],
                        ),
                      ),
                      error: (error, stackTrace) => SizedBox.shrink(),
                      loading: () => SizedBox.shrink(),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Container(
                      decoration: BoxDecoration(
                          color: Color.fromRGBO(249, 249, 249, 1),
                          border: Border.all(
                              color: Color.fromRGBO(232, 232, 232, 1)),
                          borderRadius: BorderRadius.circular(50)),
                      padding: EdgeInsets.all(10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('Costo de reporte:  ',
                              style: TextStyle(
                                  fontSize: 14,
                                  color: Color.fromRGBO(118, 118, 118, 1))),
                          Text(
                            '-1 crédito ',
                            style: TextStyle(fontSize: 14, color: Colors.black),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              )),
            ),
          );
  }
}
// rgba(249, 249, 249, 1)

class PricingPage extends ConsumerStatefulWidget {
  const PricingPage({super.key});

  @override
  ConsumerState<PricingPage> createState() => _PricingPageState();
}

class _PricingPageState extends ConsumerState<PricingPage> {
  @override
  Widget build(BuildContext context) {
    var pricing = ref.watch(pricingProvider);
    String? selectedOption = ref.watch(selectedOptionProvider);

    return ClipRRect(
      borderRadius: BorderRadius.circular(16),
      child: Scaffold(
        bottomNavigationBar: SwipIconButton(
          context: context,
          isLoading: false,
          onPressed: () {
            ref.read(creditsProvider.notifier).buy();
            Navigator.pop(context);
          },
          labeltxt: "Comprar",
          prefixIcon: Icon(
            CustomIcons.unlock,
            color: Colors.white,
            size: 24,
          ),
        ),
        body: SafeArea(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset('assets/logo.png', height: 25),
                    ],
                  ),
                  SizedBox(height: 15),
                  Text('Selecciona tu paquete de créditos',
                      style: TextStyle(fontSize: 20),
                      textAlign: TextAlign.center),
                  SizedBox(height: 30),
                  pricing.when(
                    data: (data) {
                      if (data.isEmpty) return SizedBox.shrink();

                      return Column(
                        children: List.generate(data.length, (index) {
                          return Padding(
                              padding: const EdgeInsets.only(bottom: 15.0),
                              child: Container(
                                  decoration: BoxDecoration(
                                    border: Border.all(
                                        color:
                                            Color.fromRGBO(232, 232, 232, 1)),
                                    borderRadius: BorderRadius.circular(16),
                                  ),
                                  child: RadioListTile<String>(
                                    title: Text(
                                      data[index].name ?? '',
                                      style: textTheme.titleSmall!.copyWith(
                                          color:
                                              Color.fromRGBO(126, 126, 126, 1)),
                                    ),
                                    subtitle: Text(
                                        '${data[index].credits} créditos',
                                        style: textTheme.titleLarge!.copyWith(
                                            color: theme.colorScheme.tertiary)),
                                    secondary: Text(
                                      'U\$${data[index].price!.toStringAsFixed(0)}',
                                      style: textTheme.displayMedium!
                                          .copyWith(color: Colors.black),
                                    ),
                                    fillColor:
                                        WidgetStateProperty.resolveWith<Color>(
                                            (states) {
                                      if (states
                                          .contains(WidgetState.selected)) {
                                        return Color.fromRGBO(63, 183, 125, 1);
                                      }
                                      return theme.colorScheme
                                          .outline; // Color cuando no está seleccionado
                                    }),
                                    selected: selectedOption ==
                                        data[index].id.toString(),
                                    value: data[index].id.toString(),
                                    groupValue: selectedOption,
                                    onChanged: (value) {
                                      // Update selected option using Riverpod
                                      ref
                                          .read(selectedOptionProvider.notifier)
                                          .state = value;
                                    },
                                  )));
                        }),
                      );
                    },
                    error: (error, stackTrace) => SizedBox.shrink(),
                    loading: () => CircularProgressIndicator(),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  // Container PricingCard(
  //     {required String title,
  //     required int id,
  //     required String subtitle,
  //     required double price,
  //     required bool selected,
  //     required onPressed}) {
  //   return
  // }
}

import 'dart:ui';
import 'package:carpass/features/report/providers/vehicle_provider.dart';
import 'package:carpass/features/report/unlock-report/unlock_report.dart';
import 'package:carpass/models/custom_response.dart';
import 'package:carpass/models/option_model.dart';
import 'package:carpass/theme/CustomIcons_icons.dart';
import 'package:carpass/theme/alerts.dart';
import 'package:carpass/theme/button.dart';
import 'package:carpass/theme/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';

class VehicleView extends ConsumerStatefulWidget {
  const VehicleView({super.key, required this.id});
  final String id;
  @override
  ConsumerState<VehicleView> createState() => _VehicleViewState();
}

class _VehicleViewState extends ConsumerState<VehicleView> {
  final GlobalKey<ScaffoldMessengerState> scaffoldKey =
      GlobalKey<ScaffoldMessengerState>();
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var vehicle = ref.watch(currentVehicleProvider);
    var update = ref.watch(updateProvider);
    var updateReportProvider = ref.watch(reportProvider);
    return ScaffoldMessenger(
      key: scaffoldKey,
      child: Scaffold(
          bottomNavigationBar: update.when(
              data: (data) {
                return vehicle.$1!.isUnlock
                    ? SizedBox.shrink()
                    : Padding(
                        padding: const EdgeInsets.all(15.0),
                        child: SwipIconButton(
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
                                borderRadius: BorderRadius.vertical(
                                    top: Radius.circular(16)),
                              ),
                              builder: (context) {
                                return SizedBox(
                                  height: MediaQuery.sizeOf(context).height *
                                      0.4, // Altura específica del modal
                                  child: Padding(
                                    padding: EdgeInsets.all(16.0),
                                    child: UnlockReport(),
                                  ),
                                );
                              },
                            );
                          },
                          labeltxt: "Generar Reporte",
                          prefixIcon: Icon(
                            CustomIcons.unlock,
                            color: Colors.white,
                            size: 24,
                          ),
                        ),
                      );
              },
              error: (_, __) => SizedBox.shrink(),
              loading: () => SizedBox.shrink()),
          appBar: AppBar(
            backgroundColor: Colors.white,
            title: Text(
              'Reporte',
              style: textTheme.displayMedium,
            ),
            leading: IconButton(
                onPressed: () {
                  context.go('/home');
                },
                icon: Icon(Icons.arrow_back)),
            actions: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: vehicle.$1 != null
                    ? Text(
                        DateFormat.yMMMMd('es_MX').format(
                            DateTime.parse(vehicle.$1!.createdAt.toString())),
                        style: textTheme.titleMedium!.copyWith(
                          color: theme.primaryColor,
                        ),
                      )
                    : Text(''),
              ),
            ],
          ),
          body: SafeArea(
              child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15.0),
              child: Column(
                children: [
                  updateReportProvider.when(
                      data: (value) {
                        if (value == CurrentState.success) {
                          showSnackBar(
                              'El reporte ha sido desbloqueado',
                              true,
                              () => ref.read(reportProvider.notifier).state =
                                  const AsyncData(CurrentState.initial),
                              scaffoldKey);
                        }
                        return const SizedBox();
                      },
                      loading: () => Padding(
                            padding: const EdgeInsets.only(bottom: 8.0),
                            child: LoadingAlert(
                                value: true, text: 'Desbloqueando Reporte....'),
                          ),
                      error: (error, stack) {
                        var value = error as Map<String, dynamic>;
                        return Padding(
                          padding: const EdgeInsets.only(bottom: 8.0),
                          child: CustomAlert(
                            value: true,
                            context: context,
                            text: value['message'] ??
                                'Error al desbloquear el reporte',
                            onPressed: () =>
                                ref.read(reportProvider.notifier).state =
                                    const AsyncValue.data(CurrentState.initial),
                            alertType: AlertType.error,
                          ),
                        );
                      }),
                  SizedBox(
                    height: 20,
                  ),
                  update.when(
                    data: (data) => vehicle.$1 != null
                        ? Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Column(
                                    children: [
                                      Container(
                                        width: 76,
                                        height: 76,
                                        decoration: BoxDecoration(
                                            border: Border.all(
                                              color: Color.fromRGBO(
                                                  237, 237, 237, 1),
                                            ),
                                            borderRadius:
                                                BorderRadius.circular(10)),
                                        child: vehicle.$1!.imageUrl != null
                                            ? Image.network(
                                                vehicle.$1!.imageUrl ?? '')
                                            : Image.asset(
                                                'assets/carpass.png',
                                              ),
                                      ),
                                      const SizedBox(height: 16),
                                      Text(
                                        '${vehicle.$1!.brand} ${vehicle.$1!.model} ${vehicle.$1!.year}'
                                            .toUpperCase(),
                                        style: textTheme.displaySmall,
                                      ),
                                      Container(
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 10, vertical: 5),
                                        decoration: BoxDecoration(
                                          border: Border.all(
                                              color: Color.fromRGBO(
                                                  243, 243, 243, 1)),
                                          borderRadius:
                                              BorderRadius.circular(37),
                                        ),
                                        child: Row(
                                          children: [
                                            Text(
                                              vehicle.$1!.vin ?? '',
                                              style: textTheme.bodyMedium
                                                  ?.copyWith(
                                                color: Theme.of(context)
                                                    .disabledColor,
                                              ),
                                            ),
                                            SizedBox(width: 5),
                                            Icon(
                                              CustomIcons.copy,
                                              color: Colors.black,
                                              size: 15,
                                            )
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: 15,
                              ),
                              Divider(
                                color: Color.fromRGBO(199, 199, 199, 0.42),
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              SwipIconButton(
                                context: context,
                                isLoading: false,
                                onPressed: () {},
                                labeltxt: "Resumir con IA",
                                prefixIcon: Icon(
                                  CustomIcons.ai,
                                  color: Colors.white,
                                  size: 24,
                                ),
                                suffixIcon: Icon(
                                  Icons.arrow_forward,
                                  color: Colors.white,
                                  size: 20,
                                ),
                              ),
                              SizedBox(
                                height: 20,
                              ),
                              SizedBox(
                                  height: 250,
                                  child: GridView.builder(
                                    physics: NeverScrollableScrollPhysics(),
                                    gridDelegate:
                                        SliverGridDelegateWithFixedCrossAxisCount(
                                      crossAxisCount: 2,
                                      crossAxisSpacing: 10,
                                      mainAxisSpacing: 10,
                                      childAspectRatio: 2.8,
                                    ),
                                    itemBuilder: (context, index) {
                                      return InformationCard(
                                          option: vehicle.$2[index]);
                                    },
                                    itemCount: 6,
                                  )),
                              SizedBox(
                                height: 20,
                              ),
                              vehicle.$1!.isUnlock
                                  ? ExtraCard()
                                  : Stack(
                                      children: [
                                        Column(
                                          children: [
                                            ExtraCard(),
                                            ExtraCard(),
                                          ],
                                        ),
                                        ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(20),
                                          child: BackdropFilter(
                                            filter: ImageFilter.blur(
                                                sigmaX: 5, sigmaY: 5),
                                            child: Container(
                                                width: double.infinity,
                                                height: 200,
                                                color:
                                                    Colors.white.withAlpha(25),
                                                alignment: Alignment.center,
                                                child: SizedBox.shrink()),
                                          ),
                                        )
                                      ],
                                    ),
                            ],
                          )
                        : Center(child: Text('No se encontró el vehículo')),
                    error: (error, stack) => Text(error.toString()),
                    loading: () => Center(child: CircularProgressIndicator()),
                  ),
                ],
              ),
            ),
          ))),
    );
  }

  Container ExtraCard() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(
          color: Color.fromRGBO(232, 232, 232, 1),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            'Chatarra/Recuperación/Pérdida',
            style: textTheme.titleSmall!.copyWith(
              color: theme.primaryColor,
            ),
          ),
          Chip(
            side: BorderSide.none,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(40),
            ),
            label: Text(
              '3 of 3 Records',
              style: textTheme.titleMedium!.copyWith(color: Colors.white),
            ),
            backgroundColor: Color.fromRGBO(222, 17, 53, 1),
          ),
        ],
      ),
    );
  }

  Container InformationCard({required Option option}) {
    return Container(
      constraints: BoxConstraints(maxWidth: 50),
      padding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(
          color: Color.fromRGBO(232, 232, 232, 1),
        ),
      ),
      child: Row(
        children: [
          Icon(
            option.icon,
            color: theme.primaryColor,
            size: 24,
          ),
          SizedBox(
            width: 10,
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                option.title,
                style: textTheme.titleMedium!.copyWith(
                  color: Color.fromRGBO(109, 109, 109, 1),
                ),
              ),
              Container(
                constraints: BoxConstraints(
                    maxWidth: MediaQuery.of(context).size.width * 0.27),
                child: Text(
                  option.value.toString(),
                  style: textTheme.titleSmall,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

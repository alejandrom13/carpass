import 'package:carpass/data/report_repository.dart';
import 'package:carpass/data/vehicle_repository.dart';
import 'package:carpass/models/custom_response.dart';
import 'package:carpass/models/option_model.dart';
import 'package:carpass/models/vehicle_model.dart';
import 'package:carpass/theme/CustomIcons_icons.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';

final vehicleProvider =
    StateNotifierProvider<VehicleNotifier, AsyncValue<List<VehicleModel>>>(
        (ref) {
  return VehicleNotifier(ref: ref);
});

final currentVehicleProvider =
    StateProvider<(VehicleModel?, List<Option>)>((ref) => (null, []));

final updateProvider = StateProvider<AsyncValue<dynamic>>((ref) {
  return const AsyncValue.data(CurrentState.initial);
});

final reportProvider = StateProvider<AsyncValue<dynamic>>((ref) {
  return const AsyncValue.data(CurrentState.initial);
});

class VehicleNotifier extends StateNotifier<AsyncValue<List<VehicleModel>>> {
  VehicleNotifier({required this.ref}) : super(AsyncValue.data([])) {
    getAll();
  }
  final ref;
  final VehicleRepository _vehicleRepository = VehicleRepository();
  final ReportRepository _reportRepository = ReportRepository();

  void getAll() async {
    if (mounted) state = AsyncValue.loading();
    var response = await _vehicleRepository.getAll();
    if (response.success!) {
      if (mounted) state = AsyncValue.data(response.data!);
    } else {
      if (mounted) {
        state = AsyncValue.error(response.message!, StackTrace.current);
      }
    }
  }

  Future getById(String id) async {
    ref.read(updateProvider.notifier).state = const AsyncValue.loading();
    var response = await _vehicleRepository.getById(id);
    if (response.success!) {
      List<Option> options = [];
      options.add(Option(
        title: 'Marca',
        value: response.data!.brand,
        icon: CustomIcons.vehicle,
      ));
      options.add(Option(
        title: 'Modelo',
        value: response.data!.model,
        icon: CustomIcons.vehicle,
      ));
      options.add(Option(
        title: 'Año',
        icon: CustomIcons.calendar,
        value: response.data!.year,
      ));
      options.add(Option(
        title: 'Motor',
        value: response.data!.type,
        icon: CustomIcons.engine,
      ));
      options.add(Option(
        title: 'Hecho En',
        value: response.data!.plantCity,
        icon: CustomIcons.world,
      ));
      options.add(Option(
        title: 'Combustible',
        value: 'Gasolina',
        icon: CustomIcons.fuel,
      ));

      if (mounted) {
        ref.read(updateProvider.notifier).state = const AsyncValue.data(true);
      }
      if (mounted) {
        ref.read(currentVehicleProvider.notifier).state =
            (response.data, options);
      }
    } else {
      if (mounted) {
        ref.read(updateProvider.notifier).state =
            AsyncValue.error(response.message!, StackTrace.current);
      }
    }
  }

  void unlockReport() async {
    var vehicle = ref.watch(currentVehicleProvider);
    if (mounted) {
      ref.read(reportProvider.notifier).state = const AsyncValue.loading();
    }
    var response = await _reportRepository.unlock(
        vin: vehicle.$1.vin, vehicleId: vehicle.$1.id);
    if (response.success!) {
      if (mounted) {
        ref.read(reportProvider.notifier).state =
            const AsyncValue.data(CurrentState.success);
      }
      await getById(vehicle.$1.id);
    } else {
      if (mounted) {
        ref.read(reportProvider.notifier).state =
            AsyncValue.error(response.message!, StackTrace.current);
      }
    }
  }
}

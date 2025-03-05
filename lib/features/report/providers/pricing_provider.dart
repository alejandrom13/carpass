import 'package:carpass/data/report_repository.dart';
import 'package:carpass/features/report/providers/user_provider.dart';
import 'package:carpass/models/checkout_model.dart';
import 'package:carpass/models/custom_response.dart';
import 'package:carpass/models/pricing_model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final pricingProvider =
    StateNotifierProvider<PricingNotifier, AsyncValue<List<PricingModel>>>(
        (ref) {
  return PricingNotifier(ref: ref);
});

class PricingNotifier extends StateNotifier<AsyncValue<List<PricingModel>>> {
  PricingNotifier({required this.ref}) : super(AsyncValue.loading()) {
    getAll();
  }
  var ref;

  final ReportRepository _reportRepository = ReportRepository();

  void getAll() async {
    if (mounted) state = AsyncValue.loading();
    await _reportRepository.getPricing().then((response) {
      if (response!.success!) {
        response.data!.sort((a, b) => a.price!.compareTo(b.price!));
        ref.read(selectedOptionProvider.notifier).state =
            response.data!.firstWhere((x) => x.recommended!).id.toString();

        if (mounted) state = AsyncValue.data(response.data!);
      } else {
        if (mounted) {
          state = AsyncValue.error(response.message!, StackTrace.current);
        }
      }
    });
  }
}

final creditsProvider = StateNotifierProvider.autoDispose<CreditsNotifier,
    AsyncValue<CurrentState>>((ref) {
  return CreditsNotifier(ref: ref);
});

class CreditsNotifier extends StateNotifier<AsyncValue<CurrentState>> {
  CreditsNotifier({required this.ref})
      : super(AsyncValue.data(CurrentState.initial));
  var ref;

  final ReportRepository _reportRepository = ReportRepository();

  void buy() async {
    var id = ref.watch(selectedOptionProvider);
    if (mounted) state = AsyncValue.loading();
    await _reportRepository
        .checkout(checkout: CheckoutModel(pricingId: int.parse(id)))
        .then((response) {
      if (response.success!) {
        ref.read(userProvider.notifier).getUser();

        if (mounted) state = AsyncValue.data(CurrentState.success);
      } else {
        if (mounted)
          state = AsyncValue.error(response.message!, StackTrace.current);
      }
    });
  }
}

final selectedOptionProvider = StateProvider<String?>((ref) => null);

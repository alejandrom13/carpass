import 'package:carpass/data/auth_repository.dart';
import 'package:carpass/models/auth/user.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

var userProvider =
    StateNotifierProvider.autoDispose<UserNotifier, AsyncValue<UserModel>>(
        (ref) {
  return UserNotifier(ref: ref);
});

class UserNotifier extends StateNotifier<AsyncValue<UserModel>> {
  UserNotifier({required this.ref}) : super(AsyncValue.data(UserModel())) {
    getUser();
  }
  final ref;
  final UserRepository _userRepository = UserRepository();

  void getUser() async {
    if (mounted) state = AsyncValue.loading();
    var response = await _userRepository.getUser();
    if (response.success!) {
      if (mounted) state = AsyncValue.data(response.data!);
    } else {
      if (mounted) {
        state = AsyncValue.error(response.message!, StackTrace.current);
      }
    }
  }
}

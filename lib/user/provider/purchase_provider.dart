import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:papar_plane/common/model/state_model.dart';
import 'package:papar_plane/user/repository/user_repository.dart';

final myPurchaseProvider = StateNotifierProvider<MyPurchaseNotifier, BaseState>((ref) {
  final repo = ref.watch(userRepositoryProvider);

  return MyPurchaseNotifier(repo: repo);
});

class MyPurchaseNotifier extends StateNotifier<BaseState> {
  final UserRepository repo;
  
  MyPurchaseNotifier({
    required this.repo,
  }):super(LoadingState());

  // 모든 데이터 가져오기
  Future<void> getData(int userId) async {
    final resp = await repo.getPurchases(userId: userId);
    state = resp;
  }
}

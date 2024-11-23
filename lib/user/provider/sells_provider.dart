import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:papar_plane/common/model/state_model.dart';
import 'package:papar_plane/user/repository/user_repository.dart';

final mySellProvider = StateNotifierProvider<MySellNotifier, BaseState>((ref) {
  final repo = ref.watch(userRepositoryProvider);

  return MySellNotifier(repo: repo);
});

class MySellNotifier extends StateNotifier<BaseState> {
  final UserRepository repo;
  
  MySellNotifier({
    required this.repo,
  }):super(LoadingState());

  // 모든 데이터 가져오기
  Future<void> getData(int userId) async {
    final resp = await repo.getSells(userId: userId);
    state = resp;
  }
}

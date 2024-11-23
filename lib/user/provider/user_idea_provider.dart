import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:papar_plane/common/model/state_model.dart';
import 'package:papar_plane/user/repository/user_repository.dart';

final userIdeaProvider = StateNotifierProvider<UserIdeaNotifier, BaseState>((ref) {
  final repo = ref.watch(userRepositoryProvider);

  return UserIdeaNotifier(repo: repo);
});

class UserIdeaNotifier extends StateNotifier<BaseState> {
  final UserRepository repo;
  
  UserIdeaNotifier({
    required this.repo,
  }):super(LoadingState());

  // 모든 데이터 가져오기
  Future<void> getData(String username) async {
    final resp = await repo.getIdeas(username: username);
    state = resp;
  }
}
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:papar_plane/common/model/state_model.dart';
import 'package:papar_plane/idea/repository/idea_repository.dart';

final ideaDetailProvider = StateNotifierProvider<IdeaDetailNotifier, BaseState>((ref) {
  final repo = ref.watch(ideaRepositoryProvider);

  return IdeaDetailNotifier(repo: repo);
});

class IdeaDetailNotifier extends StateNotifier<BaseState> {
  final IdeaRepository repo;
  
  IdeaDetailNotifier({
    required this.repo,
  }):super(LoadingState());

  // 데이터 가져오기
  Future<void> getDetail({
    required int id,
    required int userId,
  }) async {
    final resp = await repo.getDetail(id: id, userId: userId);
    if(resp == null){
      state = ErrorState(msg: "에러가 발생하였습니다.");
      return;
    }
    state = resp;
  }
}

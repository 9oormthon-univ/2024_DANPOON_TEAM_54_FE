import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:papar_plane/common/model/state_model.dart';
import 'package:papar_plane/home/model/idea_model.dart';
import 'package:papar_plane/home/repository/idea_repository.dart';

final ideaCategoryProvider = Provider.family<BaseState, String>((ref, category){
  final state = ref.watch(ideaProvider);

  if(!(state is IdeaModelList)){
    return state;
  }
  if(category == "전체"){
    return state;
  }
  final newData = (state as IdeaModelList).copyWith(data: (state as IdeaModelList).data.where((e) => e.category == category).toList());
  return newData;
});

final ideaProvider = StateNotifierProvider<IdeaNotifier, BaseState>((ref) {
  final repo = ref.watch(ideaRepositoryProvider);

  return IdeaNotifier(repo: repo);
});

class IdeaNotifier extends StateNotifier<BaseState> {
  final IdeaRepository repo;
  
  IdeaNotifier({
    required this.repo,
  }):super(LoadingState());

  // 모든 데이터 가져오기
  Future<void> getAllData() async {
    final resp = await repo.getAllData();
    state = resp;
  }
}

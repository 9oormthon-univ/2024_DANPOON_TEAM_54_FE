import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:papar_plane/common/model/state_model.dart';
import 'package:papar_plane/post/model/comment_model.dart';
import 'package:papar_plane/post/repository/idea_repository.dart';

final commentProvider = StateNotifierProvider<CommentNotifier, BaseState>((ref) {
  final repo = ref.watch(ideaRepositoryProvider);

  return CommentNotifier(repo: repo);
});

class CommentNotifier extends StateNotifier<BaseState> {
  final IdeaRepository repo;
  
  CommentNotifier({
    required this.repo,
  }):super(LoadingState());

  // 데이터 가져오기
  Future<void> getComment({
    required int id,
  }) async {
    final resp = await repo.getComment(id: id);
    state = resp;
  }

  // 댓글 달기
  Future<void> comment({
    required MakeComment comment,
    required RequestComment request,
  }) async {
    state = LoadingState();
    final resp = await repo.comment(comment: comment, request: request);
    if(resp == null){
      state = ErrorState(msg: "에러가 발생하였습니다.");
      return;
    }
    await getComment(id: comment.ideaId);
  }
}

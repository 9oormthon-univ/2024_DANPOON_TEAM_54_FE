import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:papar_plane/common/model/state_model.dart';
import 'package:papar_plane/post/model/review_model.dart';
import 'package:papar_plane/post/repository/review_repository.dart';

final reviewProvider = StateNotifierProvider<ReviewNotifier, BaseState>((ref) {
  final repo = ref.watch(reviewRepository);

  return ReviewNotifier(repo: repo);
});

class ReviewNotifier extends StateNotifier<BaseState> {
  final ReviewRepository repo;
  
  ReviewNotifier({
    required this.repo,
  }):super(LoadingState());

  // 데이터 가져오기
  Future<void> getReview({
    required int id,
  }) async {
    final resp = await repo.getReview(id: id);
    state = resp;
  }

  Future<void> review({
    required MakeReview review
  }) async {
    final resp = await repo.review(review: review);
    if(resp == null){
      state = ErrorState(msg: "에러가 발생하였습니다.");
      return;
    }
    final pState = (state as ReviewList);
    final nState = pState.copyWith(data: [...pState.data, resp]);
    state = nState;
  }
}

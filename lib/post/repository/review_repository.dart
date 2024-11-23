import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:papar_plane/common/model/state_model.dart';
import 'package:papar_plane/common/provider/dio_provider.dart';
import 'package:papar_plane/common/variable/variable.dart';
import 'package:papar_plane/post/model/review_model.dart';

final reviewRepository = Provider((ref) {
  final baseUrl = BASE_URL + '/reviews';
  final dio = ref.watch(dioProvider);

  return ReviewRepository(dio, baseUrl: baseUrl);
});

class ReviewRepository {
  final Dio dio;
  final String baseUrl; // 기본 서버 URL

  ReviewRepository(this.dio, {required this.baseUrl});

  // 리뷰 조회
  Future<BaseState> getReview({
    required int id,
  }) async {
    try{
      final resp = await dio.get(
      baseUrl + '/$id',
    );
    print(resp.statusCode);
    print(resp.data);
    final data = {"data" : resp.data};
    return ReviewList.fromJson(data);
    }on DioException catch(e){
      return ErrorState(msg: "에러가 발생했습니다.");
    }
  }

  // 리뷰
  Future<Review?> review({
    required MakeReview review,
  }) async {
    try{
      final resp = await dio.post(
      baseUrl,
      queryParameters: review.toJson(),
    );
    print(resp.statusCode);
    print(resp.data);
    return Review.fromJson(resp.data);
    }on DioException catch(e){
      print(e.message);
      print(e.requestOptions);
      print(e.response);
      return null;
    }
  }
}

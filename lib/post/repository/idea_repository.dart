import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:papar_plane/common/model/state_model.dart';
import 'package:papar_plane/common/provider/dio_provider.dart';
import 'package:papar_plane/common/variable/variable.dart';
import 'package:papar_plane/post/model/comment_model.dart';
import 'package:papar_plane/post/model/idea_model.dart';
import 'package:papar_plane/post/model/write_model.dart';

final ideaRepositoryProvider = Provider((ref) {
  final baseUrl = BASE_URL + '/ideas';
  final dio = ref.watch(dioProvider);

  return IdeaRepository(dio, baseUrl: baseUrl);
});

class IdeaRepository {
  final Dio dio;
  final String baseUrl; // 기본 서버 URL

  IdeaRepository(this.dio, {required this.baseUrl});

  // 아이디어 전체 조회
  Future<BaseState> getAllData() async {
    try{
      final resp = await dio.get(
      baseUrl + '/all',
    );
    final data = {"data" : resp.data};
    print("전체 데이터 조회");
    print("전체 데이터 조회");
    return IdeaModelList.fromJson(data);
    }on DioException catch(e){
      print(e);
      return ErrorState(msg: "에러가 발생하였습니다. ${e}");
    }
  }

  // 아이디어 전체 조회
  Future<BaseState> getCategoryData(String category) async {
    try{
      final resp = await dio.get(
      baseUrl + '/category',
      queryParameters: {"category" : category}
    );
    final data = {"data" : resp.data};
    return IdeaModelList.fromJson(data);
    }on DioException catch(e){
      return ErrorState(msg: "에러가 발생하였습니다.");
    }
  }

  // 아이디어 상세 조회
  Future<IdeaDetail?> getDetail({
    required int id,
    required int userId,
  }) async {
    try{
      final resp = await dio.get(
      baseUrl + '/$id',
      queryParameters: {"userId" : userId}
    );
    print("상세 데이터 : ${resp.data}");
    return IdeaDetail.fromJson(resp.data);
    }on DioException catch(e){
      return null;
    }
  }

  // 글 작성
  Future<IdeaDetail?> write({
    required FormData formData,
    required int userId,
  }) async {
    try{
      final resp = await dio.post(
      baseUrl + '/create',
      queryParameters: {"userId" : userId},
      data: formData,
      options: Options(
        headers: {
          "Content-Type": "multipart/form-data",
        },
      ),
    );
    print("글 작성하기");
    print("resp.statusCode : ${resp.statusCode}");
    print("resp.data : ${resp.data}");
    return IdeaDetail.fromJson(resp.data);
    }on DioException catch(e){
      print(e.message);
      print(e.response);
      print(e);
      return null;
    }
  }

  // 댓글 조회
  Future<BaseState> getComment({
    required int id,
  }) async {
    try{
      final resp = await dio.get(
      baseUrl + '/$id/comments',
    );
    print(resp.statusCode);
    print(resp.data);
    final data = {"data" : resp.data};
    return CommentList.fromJson(data);
    }on DioException catch(e){
      return ErrorState(msg: "에러가 발생했습니다.");
    }
  }

  // 댓글 달기
  Future<CommentModel?> comment({
    required MakeComment comment,
    required RequestComment request,
  }) async {
    try{
      final resp = await dio.get(
      baseUrl,
      queryParameters: comment.toJson(),
      data: request.toJson(),
    );
    print(resp.statusCode);
    print(resp.data);
    return CommentModel.fromJson(resp.data);
    }on DioException catch(e){
      return null;
    }
  }
}

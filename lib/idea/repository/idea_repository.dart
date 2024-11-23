import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:papar_plane/common/model/state_model.dart';
import 'package:papar_plane/common/provider/dio_provider.dart';
import 'package:papar_plane/common/variable/variable.dart';
import 'package:papar_plane/idea/model/comment_model.dart';
import 'package:papar_plane/idea/model/idea_model.dart';

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
    print(resp.data);
    return IdeaDetail.fromJson(resp.data);
    }on DioException catch(e){
      return null;
    }
  }

  // 글 작성
  Future<IdeaDetail?> write({
    required FormData formData,
    File? file,
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
    return IdeaDetail.fromJson(resp.data);
    } on DioException catch(e){
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
      final resp = await dio.post(
      baseUrl + '/${comment.ideaId}/comments',
      queryParameters: comment.toJson(),
      data: request.toJson(),
    );
    return CommentModel.fromJson(resp.data);
    }on DioException catch(e){
      print(e);
      return null;
    }
  }

    // 댓글 조회
  Future<void> delete({
    required int id,
    required int userId,
  }) async {
    try{
      final resp = await dio.delete(
      baseUrl + '/$id',
      queryParameters: {"userId" : userId},
    );
    }on DioException catch(e){
      print(e);
    }
  }

    // 아이디어 상세 조회
  Future<String?> getFile({
    required int id,
    required int userId,
  }) async {
    try{
      final resp = await dio.get(
      baseUrl + '/$id/download',
      queryParameters: {"userId" : userId}
    );
    print(resp.statusCode);
    print(resp.data);
    return resp.data;
    }on DioException catch(e){
      return null;
    }
  }
}

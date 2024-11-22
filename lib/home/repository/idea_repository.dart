import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:papar_plane/common/model/state_model.dart';
import 'package:papar_plane/common/provider/dio_provider.dart';
import 'package:papar_plane/common/variable/variable.dart';
import 'package:papar_plane/home/model/idea_model.dart';

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
    print("아이디어 데이터 가져오기");
    print("resp.statusCode : ${resp.statusCode}");
    print("resp.data : ${resp.data}");
    final data = {"data" : resp.data};
    return IdeaModelList.fromJson(data);
    }on DioException catch(e){
      print(e.error);
      print(e.message);
      print(e.requestOptions);
      print(e.response);
      return ErrorState(msg: "에러가 발생하였습니다.");
    }
  }

  // 아이디어 전체 조회
  Future<BaseState> getCategoryData(String category) async {
    try{
      final resp = await dio.get(
      baseUrl + '/category',
      queryParameters: {"category" : category}
    );
    print("카테고리별 아이디어 데이터 가져오기");
    print("resp.statusCode : ${resp.statusCode}");
    print("resp.data : ${resp.data}");
    final data = {"data" : resp.data};
    return IdeaModelList.fromJson(data);
    }on DioException catch(e){
      print(e.error);
      print(e.message);
      print(e.requestOptions);
      print(e.response);
      return ErrorState(msg: "에러가 발생하였습니다.");
    }
  }
}

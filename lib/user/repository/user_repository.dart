import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:papar_plane/common/model/state_model.dart';
import 'package:papar_plane/common/provider/dio_provider.dart';
import 'package:papar_plane/common/variable/variable.dart';
import 'package:papar_plane/user/model/auth_model.dart';
import 'package:papar_plane/user/model/user_model.dart';

final userRepositoryProvider = Provider((ref) {
  final baseUrl = BASE_URL;
  final dio = ref.watch(dioProvider);

  return UserRepository(dio, baseUrl: baseUrl);
});

class UserRepository {
  final Dio dio;
  final String baseUrl; // 기본 서버 URL

  UserRepository(this.dio, {required this.baseUrl});

  // 서버 통신을 이용한 로그인
  Future<LoginModel?> login(kakaoData data) async {
    try{
      final resp = await dio.get(
      baseUrl + '/user/kakao',
      data: data.toJson(),
    );
    print("서버 로그인 통신");
    print("resp.statusCode : ${resp.statusCode}");
    print("resp.data : ${resp.data}");
    return LoginModel.fromJson(resp.data);
    }on DioException catch(e){
      print(e.error);
      print(e.message);
      print(e.requestOptions);
      print(e.response);
      return null;
    }
  }

  // 닉네임 중복 검사
  Future<bool?> nicknameDuplicate({
    required int id,
    required String nickname,
  }) async {
    try{
      final resp = await dio.patch(
      baseUrl + '/users/$id/username',
      queryParameters: {"newUsername": nickname},
    );

    return resp.data is String;
    }catch(e){
      print(e);
      return null;
    }
  }

  // 유저 프로필 가져오기
  Future<BaseState> getProfile({
    required int id,
  }) async {
    try{
      final resp = await dio.get(
      baseUrl + '/users/$id/profile',
    );

    return PPUser.fromJson(resp.data);
    }catch(e){
      print(e);
      return ErrorState(msg: "에러 발생");
    }
  }
}

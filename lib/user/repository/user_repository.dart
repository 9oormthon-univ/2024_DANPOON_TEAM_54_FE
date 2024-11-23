import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:papar_plane/common/model/state_model.dart';
import 'package:papar_plane/common/provider/dio_provider.dart';
import 'package:papar_plane/common/variable/variable.dart';
import 'package:papar_plane/post/model/idea_model.dart';
import 'package:papar_plane/user/model/auth_model.dart';
import 'package:papar_plane/user/model/purchase_model.dart';
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
      final resp = await dio.post(
      baseUrl + '/users/kakao',
      data: data.toJson(),
    );

    return LoginModel.fromJson(resp.data);
    }on DioException catch(e){
      return null;
    }
  }

  // 닉네임 중복 검사
  Future<bool> nicknameDuplicate({
    required int id,
    required String nickname,
  }) async {
    try{
      final resp = await dio.patch(
      baseUrl + '/users/$id/username',
      queryParameters: {"newUsername": nickname},
    );
    print("resp.statusCode : ${resp.statusCode}");
    print("resp.data : ${resp.data}");

    return resp.data is String;
    }catch(e){
      return false;
    }
  }

  // 유저 프로필 가져오기
  Future<ProFileData?> getProfile({
    required int id,
  }) async {
    try{
      final resp = await dio.get(
      baseUrl + '/users/$id/profile',
    );
    print("resp.data : ${resp.data}");

    return ProFileData.fromJson(resp.data);
    }catch(e){
      return null;
    }
  }

  // 유저 idea 가져오기
  Future<BaseState> getIdeas({
    required String username,
  }) async {
    try{
      final resp = await dio.get(
      baseUrl + '/ideas/user/$username',
    );
    print("특정 유저의 idea");
    print("resp.data : ${resp.data}");
    final data = {"data" : resp.data};
    return IdeaModelList.fromJson(data);
    }catch(e){
      return ErrorState(msg: "에러가 발생했습니다.");
    }
  }

  // 구매 내역
  Future<BaseState> getPurchases({
    required int userId,
  }) async {
    try{
      final resp = await dio.get(
      baseUrl + '/purchases/purchases',
      queryParameters: {"userId" : userId},
    );
    print("구매");
    print("resp.data : ${resp.data}");
    final data = {"data" : resp.data};
    return ItemList.fromJson(data);
    }catch(e){
      return ErrorState(msg: "에러가 발생했습니다.");
    }
  }

  // 판매 내역
  Future<BaseState> getSells({
    required int userId,
  }) async {
    try{
      final resp = await dio.get(
      baseUrl + '/purchases/sales',
      queryParameters: {"userId" : userId},
    );
    print("판매내역");
    print("resp.data : ${resp.data}");
    final data = {"data" : resp.data};
    return ItemList.fromJson(data);
    }catch(e){
      return ErrorState(msg: "에러가 발생했습니다.");
    }
  }

  // 구매하기
  Future<bool> purchase({
    required int buyerId,
    required int ideaId,
  }) async {
    try{
      final resp = await dio.post(
      baseUrl + '/purchases/${buyerId}/${ideaId}',
    );
    print("구매하기");
    print("resp.data : ${resp.data}");
    return true;
    }catch(e){
      print(e);
      return false;
    }
  }
}

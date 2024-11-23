import 'package:dio/dio.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kakao_flutter_sdk/kakao_flutter_sdk.dart';
import 'package:papar_plane/common/provider/dio_provider.dart';
import 'package:papar_plane/common/variable/variable.dart';
import 'package:papar_plane/user/model/auth_model.dart';

final authRepositoryProvider = Provider((ref) {
  final baseUrl = BASE_URL;
  final dio = ref.watch(dioProvider);

  return AuthRepository(dio, baseUrl: baseUrl);
});

class AuthRepository {
  final Dio dio;
  final String baseUrl; // 기본 서버 URL

  AuthRepository(this.dio, {required this.baseUrl});

  // 카카오톡 로그인
  Future<KakaoData?> kakaoLogin() async {
    // 카카오톡 실행 가능 여부 확인
    // 카카오톡 실행이 가능하면 카카오톡으로 로그인, 아니면 카카오계정으로 로그인
    if (await isKakaoTalkInstalled()) {
      try {
        final resp = await UserApi.instance.loginWithKakaoTalk();
        print('카카오톡으로 로그인 성공');
        User user = await UserApi.instance.me();
        final data = KakaoData(
            kakaoId: user.id,
            profileImage: user.kakaoAccount?.profile?.profileImageUrl);
        return data;
      } catch (error) {
        print('카카오톡으로 로그인 실패 $error');

        // 사용자가 카카오톡 설치 후 디바이스 권한 요청 화면에서 로그인을 취소한 경우,
        // 의도적인 로그인 취소로 보고 카카오계정으로 로그인 시도 없이 로그인 취소로 처리 (예: 뒤로 가기)
        if (error is PlatformException && error.code == 'CANCELED') {
          return null;
        }
        // 카카오톡에 연결된 카카오계정이 없는 경우, 카카오계정으로 로그인
        try {
          User user = await UserApi.instance.me();
          final resp = await UserApi.instance.loginWithKakaoAccount();
          print('카카오계정으로 로그인 성공');
          print("user : ${resp.toJson()}");

          final data = KakaoData(
              kakaoId: user.id,
              profileImage: user.kakaoAccount?.profile?.profileImageUrl);
          return data;
        } catch (error) {
          print('카카오계정으로 로그인 실패 $error');
        }
      }
    } else {
      try {
        final resp = await UserApi.instance.loginWithKakaoAccount();
        print("카카오 로그인 계정 : ${resp.toJson()}");

        User user = await UserApi.instance.me();
        print('카카오계정으로 로그인 성공');
        print(user.toJson());
        final data = KakaoData(
            kakaoId: user.id,
            profileImage: user.kakaoAccount?.profile?.profileImageUrl);
        print("kakao Data : ${data.toJson()}");
        return data;
      } catch (error) {
        print(await KakaoSdk.origin);
        print("실패해버림 ${error}");
        print('카카오계정으로 로그인 실패 $error');
        return null;
      }
    }
  }

  Future<KakaoData> getKakaoData() async {
    User user = await UserApi.instance.me();
    final kakaoData = KakaoData(kakaoId: user.id, profileImage: user.kakaoAccount?.profile?.profileImageUrl);
    return kakaoData;
  }

  // 카카오 로그아웃 함수
  Future<void> socialLogout() async {
    try {
      await UserApi.instance.unlink();
      print("카카오 로그아웃 / 연결 끊기 성공 / 토큰 삭제");
    } catch (e) {
      print(e);
    }
  }
}

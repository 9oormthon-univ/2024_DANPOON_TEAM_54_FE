import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:papar_plane/common/model/state_model.dart';
import 'package:papar_plane/common/secure_storage/secure_storage.dart';
import 'package:papar_plane/user/model/user_model.dart';
import 'package:papar_plane/user/repository/auth_repository.dart';
import 'package:papar_plane/user/repository/user_repository.dart';

final userProvider = StateNotifierProvider<UserNotifier, BaseState?>((ref) {
  final authRepo = ref.watch(authRepositoryProvider);
  final userRepo = ref.watch(userRepositoryProvider);
  final storage = ref.watch(secureStorageProvider);

  return UserNotifier(authRepo: authRepo, userRepo: userRepo, storage: storage);
});

class UserNotifier extends StateNotifier<BaseState?> {
  final AuthRepository authRepo;
  final UserRepository userRepo;
  final FlutterSecureStorage storage;
  
  UserNotifier({
    required this.userRepo,
    required this.authRepo,
    required this.storage,
  }):super(null);

  // 닉네임 중복 검사
  Future<bool?> nicknameDuplicate({
    required int id,
    required String nickname,
  }) async {
    final resp = userRepo.nicknameDuplicate(id: id, nickname: nickname,);
    return resp;
  }

  // 로그인
  // 카카오 로그인 후 
  // 유저 상태 변경
  // 로그인 여부에따라 상태 변경
  // 토큰 저장
  Future<void> login() async {
    // kakao login
    final kakaoData = await authRepo.kakaoLogin();
    if(kakaoData == null){
      state = null;
      return;
    }
    state = LoadingState();
    // paper_plane login
    final loginData = await userRepo.login(kakaoData);
    if(loginData == null){
      state = null;
      return;
    }
    final id = loginData.userId;
    if(loginData.isFirstLogin){
      state = SignupUser(id: id);
      return;
    }
    final profile = await userRepo.getProfile(id: id);
    if(profile == null){
      state = null;
      return;
    }
    final user = PPUser(id: id, profile: profile);
    state = user;
    //state = SignupUser(id: 3797922970);
  }

  // 로그아웃
  // 카카오 로그아웃 후 추가 로그아웃
  void logout() async {
    authRepo.kakaoLogout();
    state = null;
  }

  PPUser getUser(){
    return (state as PPUser);
  }

  void reset(){
    state = null;
  }

  void setPoint(int minusPoint){
    final nState = (state as PPUser);
    state = nState.copyWith(profile: nState.profile.copyWith(points: nState.profile.points - minusPoint));
  }

  Future<bool> purchase({
    required int buyerId,
    required int ideaId,
  }) async {
    final resp = await userRepo.purchase(buyerId: buyerId, ideaId: ideaId);
    return resp;
  }
  
  // -------------------------------state 관련 함수-------------------------------

  // id값 반환
  int getUserId(){
    if(state is SignupUser){
      return (state as SignupUser).id;
    }
    return (state as PPUser).id;
  }

  // -------------------------------회원가입 관련 함수-------------------------------

  // SignupUser의 닉네임을 업데이트
  void setNickname({
    String? nickname,
  }) {
    if (state is SignupUser) {
      // 현재 state가 SignupUser임을 명시
      // 단, 현재 state가 SignupUser가 아닐 때는
      // 사용하면 안됨.
      final nowState = state as SignupUser;
      state = (state as SignupUser).copyWith(
        nickname: nickname ?? nowState.nickname,
      );
    }
  }

  // 회원가입 상태에서
  // 서버로 요청 보냈다는 가정하에,
  // 유저로 변환
  void signup() async {
    // 회원가입 중인 유저를
    // 실 유저 객체로 변환
    if (state is SignupUser) {
      final pState = state as SignupUser;
      state = LoadingState();
      final id = pState.id;
      final profile = await userRepo.getProfile(id: id);
      if(profile == null){
        state = ErrorState(msg: "에러가 발생하였습니다.");
        return;
      }
      final user = PPUser(
        id: id,
        profile: profile,
        
      );
      state = user;
    }
    return;
  }
}

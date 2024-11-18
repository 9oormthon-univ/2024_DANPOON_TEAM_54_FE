import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:papar_plane/user/model/user_model.dart';
import 'package:papar_plane/user/repository/auth_repository.dart';

final userProvider = StateNotifierProvider((ref) {
  final authRepo = ref.watch(authRepositoryProvider);

  return UserNotifier(authRepo: authRepo);
});

class UserNotifier extends StateNotifier<UserBase?> {
  final AuthRepository authRepo;
  
  UserNotifier({
    required this.authRepo,
  }):super(UserLoading());

  // 로그인
  // 카카오 로그인 후 
  // 유저 상태 변경
  Future<void> login() async {
    await authRepo.kakaoLogin();
    // 로그인 후 회원가입하는 유저로 변환(임시)
    // 추후 서버와 연동하여 회원가입된 유저면,
    // 기본 유저 객체로,
    // 회원가입이 필요한 유저라면
    // 회원가입 화면으로 이동하도록 설정
    
    //signup();
  }

  // 로그아웃
  // 카카오 로그아웃 후
  // 유저의 상태를 null로 변환
  void logout() async {
    authRepo.kakaoLogout();
    state = null;
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
  void signup() {
    // 회원가입 중인 유저를
    // 실 유저 객체로 변환
    if (state is SignupUser) {
      final pState = state as SignupUser;
      final user = UserModel(
        nickname: pState.nickname!,
      );
      state = user;
    }
    return;
  }
}

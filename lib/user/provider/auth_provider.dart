import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:kakao_flutter_sdk/kakao_flutter_sdk.dart';
import 'package:papar_plane/common/model/state_model.dart';
import 'package:papar_plane/user/model/user_model.dart';
import 'package:papar_plane/user/provider/user_provider.dart';
import 'package:papar_plane/user/repository/auth_repository.dart';

final authProvider = ChangeNotifierProvider<AuthNotifier>((ref) {
  return AuthNotifier(ref: ref);
});

class AuthNotifier extends ChangeNotifier {
  final Ref ref;

  AuthNotifier({
    required this.ref,
  }) : super() {
    ref.listen<BaseState?>(userProvider, (previous, next) {
      if (previous != next) {
        notifyListeners();
      }
    });
  }

  // 앱을 처음 시작했을 때
  // 유저 정보가 존재하는지 확인하고
  // 로그인 스크린으로 보내줄지
  // 홈 스크린으로 보내줄지 확인하는 과정
  Future<String?> redirectLogic(GoRouterState gState) async {
    print('redirect 실행');
    print(gState.fullPath);
    final user = ref.read(userProvider);
    // 현재 넘어가는 화면에 따른 변수 설정
    // 로그인 / 회원가입 / 개인 정보 동의
    final isLoggin = gState.fullPath == '/login';
    final isSignup = gState.fullPath == '/terms/signup';
    final isLoading = gState.fullPath == '/loading';
    final isTerms = gState.fullPath == '/terms';

    // 유저 정보가 없고 로그인 중이라면
    // 로그인 화면로 이동
    if (user == null) {
      if (gState.fullPath == '/signup') {
        return '/signup';
      }
      // final isToken = await AuthApi.instance.hasToken();
      // if(isToken){
      //   final kakaoData = await ref.read(authRepositoryProvider).getKakaoData();
      //   ref.read(userProvider.notifier).serverLogin(kakaoData);
      // }
      return isLoggin ? null : '/login';
    }

    // 로딩 상태에는 스플래쉬 화면 출력
    if (user is LoadingState) {
      return '/loading';
    }

    // 만약 유저가 앱내에서 회원가입이 진행되지 않은 회원이라면
    // 회원가입 화면으로 이동
    if (user is SignupUser) {
      return (isSignup || isTerms) ? null : '/terms';
      // return isPolicy || isSignup ? null : '/policy';
    }

    // 유저 정보가 존재한 상태에서
    // 로그인/회원가입/스플래쉬 화면이라면, 홈화면으로 이동
    // 그 외는 기존에 이동하려던 경로로 정상 이동
    if (user is PPUser) {
      if ((isLoggin || isSignup || isLoading)) {
        return '/home';
      }
      return null;
    }

    // 유저 정보에 에러가 존재하고 로그인 상태가 아니라면
    // 로그인 화면으로 이동
    if (user is ErrorState) {
      return '/login';
    }

    // 그 이외의 상황시에는 전부 null => 기존 경로로 이동
    return null;
  }
}

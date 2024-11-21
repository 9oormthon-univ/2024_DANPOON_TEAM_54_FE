// import 'dart:convert';
// import 'package:auction_shop/admin/QandA/model/admin_QandA_model.dart';
// import 'package:auction_shop/chat/provider/sse_provider.dart';
// import 'package:auction_shop/product/model/product_model.dart';
// import 'package:auction_shop/user/model/Q&A_model.dart';
// import 'package:auction_shop/user/model/address_model.dart';
// import 'package:auction_shop/user/model/user_model.dart';
// import 'package:auction_shop/user/view/mypage_inner/mybid_screen.dart';
// import 'package:auction_shop/user/view/policy/policy_info_screen.dart';
// import 'package:auction_shop/user/view/policy/policy_screen.dart';
// import 'package:flutter/widgets.dart';
// import 'package:auction_shop/common/export/route_export.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';

// final authProvider = ChangeNotifierProvider<AuthNotifier>((ref) {
//   return AuthNotifier(ref: ref);
// });

// class AuthNotifier extends ChangeNotifier {
//   final Ref ref;

//   AuthNotifier({
//     required this.ref,
//   }) : super() {
//     ref.listen<UserModelBase?>(userProvider, (previous, next) {
//       if (previous != next) {
//         notifyListeners();
//       }
//     });
//   }

//   // 앱을 처음 시작했을 때
//   // 유저 정보가 존재하는지 확인하고
//   // 로그인 스크린으로 보내줄지
//   // 홈 스크린으로 보내줄지 확인하는 과정
//   String? redirectLogic(GoRouterState gState) {
//     print('redirect 실행');
//     final UserModelBase? user = ref.read(userProvider);
//     // 현재 넘어가는 화면에 따른 변수 설정
//     // 로그인 / 회원가입 / 스플래쉬 / 카테고리 / 개인 정보 동의
//     final isLoggin = gState.fullPath == '/login';
//     final isSignup = gState.fullPath == '/signup';
//     final isSplash = gState.fullPath == '/splash';
//     final isCategory = gState.fullPath == '/category';
//     final isPolicy = gState.fullPath == '/policy/policy_info/:index';

//     // 유저 정보가 없고 로그인 중이라면
//     // 로그인 화면로 이동
//     if (user == null) {
//       print('유저 정보가 없음');
//       if (gState.fullPath == '/signup') {
//         return '/signup';
//       }
//       return isLoggin ? null : '/login';
//     }

//     // 로딩 상태에는 스플래쉬 화면 출력
//     if (user is UserModelLoading) {
//       return '/splash';
//     }

//     // 만약 유저가 앱내에서 회원가입이 진행되지 않은 회원이라면
//     // 회원가입 화면으로 이동
//     if (user is UserModelSignup) {
//       print("회원가입유저");
//       print(gState.fullPath);
//       return isCategory || isPolicy || isSignup ? null : '/policy';
//     }

//     // 괸라지가 로그인했을 경우,
//     // Admin 홈 화면으로 보내고
//     // 그 외의 상황은 그대로 이동하도록 설정
//     if (user is AdminUser){
//       return isSplash ? '/admin_home' : null;
//     }

//     // 유저 정보가 존재한 상태에서
//     // 로그인/회원가입/스플래쉬 화면이라면, 홈화면으로 이동
//     // 그 외는 기존에 이동하려던 경로로 정상 이동
//     if (user is UserModel) {
//       print('로그인 상태');
//       // 첫 로그인 / 회원가입일 경우,
//       // 혹은 스플래쉬 화면에서 홈 화면으로 넘어가는 경우
//       // SSE 연결 시도
//       if ((isLoggin || isSignup || isSplash)) {
//         final memberId = ref.read(userProvider.notifier).getMemberId();
//         // 로그인시 추천 경매 물품 데이터 받아오기
//         ref.read(mainProductProvider.notifier).getNewData();
//         ref.read(mainProductProvider.notifier).getHotData();
//         ref.read(mainProductProvider.notifier).recommendProducts();

//         if(user is AdminUser){
//           print("Admin입니다.");
//           return '/admin_home';
//         }
//         // 로그인시 SSE 연결
//         ref.read(SSEProvider.notifier).connect(memberId);
//         return '/';
//       }
//       return null;
//       //return (isLoggin || isSignup || isSplash) ? '/' : null;
//     }

//     // 유저 정보에 에러가 존재하고 로그인 상태가 아니라면
//     // 로그인 화면으로 이동
//     if (user is UserModelError) {
//       print('에러');
//       return '/error';
//     }

//     // 그 이외의 상황시에는 전부 null => 기존 경로로 이동
//     print('그 외 상황');
//     return null;
//   }
// }

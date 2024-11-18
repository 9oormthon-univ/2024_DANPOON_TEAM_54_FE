import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:papar_plane/common/view/root_tab.dart';
import 'package:papar_plane/user/view/login_screen.dart';
import 'package:papar_plane/user/view/signup_screen.dart';

// GoRouter Provider
// 해당 provider로 routing 진행
final goRouterProvider = Provider<GoRouter>(
  (ref) {
    // 라우팅 리스트
    List<GoRoute> routes = [
      GoRoute(
        path: '/home',
        name: RootTab.routeName,
        builder: (_, __) => RootTab(),
      ),
      GoRoute(
        path: '/signup',
        name: SignupScreen.routeName,
        builder: (_, __) => SignupScreen(),
      ),
      GoRoute(
        path: '/login',
        name: LoginScreen.routeName,
        builder: (_, __) => LoginScreen(),
      ),
    ];

    return GoRouter(
      routes: routes,
      // 처음으로 제공되는 화면 route
      initialLocation: '/login',
    );
  },
);

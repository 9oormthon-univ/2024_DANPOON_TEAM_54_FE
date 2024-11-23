import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:papar_plane/common/view/loading_screen.dart';
import 'package:papar_plane/common/view/root_tab.dart';
import 'package:papar_plane/idea/view/idea_detail_screen.dart';
import 'package:papar_plane/idea/view/write_screen.dart';
import 'package:papar_plane/user/provider/auth_provider.dart';
import 'package:papar_plane/user/view/login_screen.dart';
import 'package:papar_plane/user/view/profile_screen.dart';
import 'package:papar_plane/user/view/signup_screen.dart';

// GoRouter Provider
// 해당 provider로 routing 진행
final goRouterProvider = Provider<GoRouter>(
  (ref) {

    final provider = ref.read(authProvider);

    // 라우팅 리스트
    List<GoRoute> routes = [
      GoRoute(
        path: '/home',
        name: RootTab.routeName,
        builder: (_, __) => RootTab(),
        routes: [
          GoRoute(
            path: 'idea_detail/:id',
            name: IdeaDetailScreen.routeName,
            builder: (_, __) {
              final id = int.parse(__.pathParameters["id"]!);
              final showProfile = __.uri.queryParameters["showProfile"] == null ? true : false;
              return IdeaDetailScreen(id: id, showProfile: showProfile,);
            },
          ),
        ]
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
      GoRoute(
        path: '/write',
        name: WriteScreen.routeName,
        builder: (_, __) => WriteScreen(),
      ),
      GoRoute(
        path: '/loading',
        name: LoadingScreen.routeName,
        builder: (_, __) => LoadingScreen(),
      ),
      GoRoute(
        path: '/profile',
        name: ProfileScreen.routeName,
        builder: (_, __) {
          final username = __.uri.queryParameters["username"]!;
          return ProfileScreen(username: username);
        },
      ),
    ];

    return GoRouter(
      routes: routes,
      // 처음으로 제공되는 화면 route
      refreshListenable: provider,
      initialLocation: '/login',
      redirect: (_, state){
        return provider.redirectLogic(state);
      }
    );
  },
);

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:papar_plane/common/view/root_tab.dart';

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
    ];

    return GoRouter(
      routes: routes,
      // 처음으로 제공되는 화면 route
      initialLocation: '/home',
    );
  },
);

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:papar_plane/common/provider/go_router_provider.dart';

late Size ratio;

void main() {
  // ProviderScope -> Riverpod을 이용하기 위한 필수 설정해줘야하는 요소
  runApp(ProviderScope(child: const MyApp()));
}

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // 반응형 웹을 위한 변수
    // 현재 사이즈는 제가 사용하고 있는 애뮬레이터 기준입니다.
    ratio = Size( 
      MediaQuery.of(context).size.width / 412, // 너비
      MediaQuery.of(context).size.height / 892, // 높이
    );

    final router = ref.watch(goRouterProvider);

    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        fontFamily: "SUIT", // 전체 Font 설정
      ),
      routerConfig: router,
    );
  }
}

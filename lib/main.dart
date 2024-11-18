import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:papar_plane/common/provider/go_router_provider.dart';
import 'package:kakao_flutter_sdk_common/kakao_flutter_sdk_common.dart';

late Size ratio;

void main() {
  // 웹 환경에서 카카오 로그인을 정상적으로 완료하려면 runApp() 호출 전 아래 메서드 호출 필요
  WidgetsFlutterBinding.ensureInitialized();

  // runApp() 호출 전 Flutter SDK 초기화
  KakaoSdk.init(
    nativeAppKey: '03e63b402420a932990ad7c17870cae1',
    javaScriptAppKey: '047f7f573bc89d58cd6c3536b6b0d28a',
  );

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

import 'package:flutter/material.dart';

// 기본 Scaffold를 담고있는 Layout Widget
// 웬만한 화면뷰들은 전부 해당 레이아웃을 기준으로 작성해주시면 좋을거같습니다.
class DefaultLayout extends StatelessWidget {
  final Widget child; // 내부에 들어갈 Widget
  final Color? bgColor; // 배경색상
  final Widget? bottomNavigationBar; // 바텀바
  final PreferredSizeWidget? appBar; // 앱바
  final bool resizeToAvoidBottomInset; // 키보드를 화면내에 포함할건지
  final FloatingActionButton? floatingActionButton; // 우하단 고정 버튼
  const DefaultLayout({
    required this.child,
    this.bgColor = Colors.white,
    this.bottomNavigationBar = null,
    this.resizeToAvoidBottomInset = false,
    this.appBar,
    this.floatingActionButton,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        resizeToAvoidBottomInset: resizeToAvoidBottomInset,
        appBar: appBar,
        backgroundColor: bgColor,
        body: child,
        bottomNavigationBar: bottomNavigationBar,
        floatingActionButton: floatingActionButton,
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:go_router/go_router.dart';
import 'package:papar_plane/common/layout/default_layout.dart';
import 'package:papar_plane/common/variable/colors.dart';
import 'package:papar_plane/common/variable/image_path.dart';
import 'package:papar_plane/post/view/home_screen.dart';
import 'package:papar_plane/post/view/write_screen.dart';
import 'package:papar_plane/user/view/mypage_screen.dart';

// BottomNavigationBar 존재하는 화면
class RootTab extends StatefulWidget {
  static String get routeName => 'home';
  const RootTab({super.key});

  @override
  State<RootTab> createState() => _RootTabState();
}

class _RootTabState extends State<RootTab> with SingleTickerProviderStateMixin {
  late TabController controller;
  int index = 0;

  @override
  void initState() {
    super.initState();

    //vsync => with SingleTickerProviderStateMixin
    controller = TabController(length: 3, vsync: this);
    controller.addListener(tabListener);
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  void tabListener() {
    setState(() {
      index = controller.index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return DefaultLayout(
      // 바텀 네비게이션 index에 따라 달라지는 화면 구성 요소
      // 순서대로 화면 출력이 됩니다.
      // 만드신 UI를 해당 TabBarView 내에 넣어주세요.
      child: TabBarView(
        physics: NeverScrollableScrollPhysics(),
        controller: controller,
        children: [
          HomeScreen(),
          Center(
            child: Text("2"),
          ),
          MyPageScreen(),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.white,
        selectedItemColor: PaperPlaneColor.mainColor,
        unselectedItemColor: PaperPlaneColor.greyColorA1,
        unselectedIconTheme: IconThemeData(
          color: PaperPlaneColor.greyColorA1,
        ),
        selectedFontSize: 12,
        unselectedFontSize: 12,
        type: BottomNavigationBarType.fixed,
        onTap: (int index) {
          if(index == 1){
            context.pushNamed(WriteScreen.routeName);
            return;
          }
          controller.animateTo(index);
        },
        currentIndex: index,
        // 바텀 네비게이션 하단바 아이콘들
        items: [
          BottomNavigationBarItem(
            icon: Image.asset(
              PaperPlaneImgPath.uncolored_home,
              width: 25,
            ),
            activeIcon: Image.asset(
              PaperPlaneImgPath.colored_home,
              width: 25,
            ),
            label: '홈',
          ),
          BottomNavigationBarItem(
            icon: Image.asset(
              PaperPlaneImgPath.uncolored_paper_plane,
              width: 25,
            ),
            activeIcon: Image.asset(
              PaperPlaneImgPath.colored_paper_plane,
              width: 25,
            ),
            label: '작성',
          ),
          BottomNavigationBarItem(
            icon: Image.asset(
              PaperPlaneImgPath.uncolored_user,
              width: 25,
            ),
            activeIcon: Image.asset(
              PaperPlaneImgPath.colored_user,
              width: 25,
            ),
            label: '내정보',
          ),
        ],
      ),
    );
  }
}

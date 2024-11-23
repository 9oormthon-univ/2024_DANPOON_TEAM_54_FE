import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:papar_plane/common/variable/colors.dart';

// CustomAppBar
// title에 AppBar에 넣고자하는 텍스트를 넣어주세요.
// 앱바의 종류는 3가지입니다.
class CustomAppBar{
  // 1. 양쪽에 아이콘이 다 필요한 경우
  // 왼쪽에 위치하는 아이콘은 기본적으로 뒤로가기 함수를 지원하는 아이콘을 넣었습니다.
  // 오른쪽에 위치하는 아이콘들은 actions 변수에 넣어서 활용해주세요.
  static AppBar fullAppBar(BuildContext context,{
    required List<Widget> actions,
    required String title,
    VoidCallback? func,
  }) {
    return AppBar(
      backgroundColor: Colors.white,
      centerTitle: true,
      shape: Border(
        bottom: BorderSide(
          color: PaperPlaneColor.greyColorD3,
          width: 0.5,
        ),
      ),
      leading: IconButton(
        onPressed: func ?? () {
          context.pop();
        },
        icon: Icon(
          Icons.arrow_back,
          color: PaperPlaneColor.mainColor,
        ),
      ),
      title: Text(
        title,
        style: TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.bold,
        ),
      ),
      actions: actions,
    );
  }

  // 2. 오른쪽 아이콘만 필요한 경우
  // 왼쪽에 위치하는 아이콘은 제거하였고
  // 오른쪽에 위치하는 아이콘들은 actions 변수에 넣어서 활용해주세요.
  static AppBar noLeadingAppBar(BuildContext context,{
    required List<Widget> actions,
    required String title,
  }) {
    return AppBar(
      backgroundColor: Colors.white,
      centerTitle: true,
      shape: Border(
        bottom: BorderSide(
          color: PaperPlaneColor.greyColorD3,
          width: 0.5,
        ),
      ),
      title: Text(
        title,
        style: TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.bold,
        ),
      ),
      actions: actions,
    );
  }

  // 3. 왼쪽 아이콘만 필요한 경우
  // 오른쪽에 위치하는 아이콘은 제거하였고
  // 왼쪽에 위치하는 아이콘은 기본적으로 뒤로가기 함수를 지원하는 아이콘을 넣었습니다.
  static AppBar noActionAppBar(BuildContext context,{
    required String title,
    VoidCallback? func,
  }) {
    return AppBar(
      backgroundColor: Colors.white,
      centerTitle: true,
      shape: Border(
        bottom: BorderSide(
          color: PaperPlaneColor.greyColorD3,
          width: 0.5,
        ),
      ),
      leading: IconButton(
        onPressed: func ?? () {
          context.pop();
        },
        icon: Icon(
          Icons.arrow_back,
          color: PaperPlaneColor.mainColor,
        ),
      ),
      title: Text(
        title,
        style: TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
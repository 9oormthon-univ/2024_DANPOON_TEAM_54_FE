import 'package:flutter/material.dart';
import 'package:papar_plane/common/variable/colors.dart';
import 'package:papar_plane/common/variable/textstyle.dart';

// 기본 버튼 Widget
// 기본적으로 배경색상은 mainColor,
// Text 색상은 흰색입니다.
// 대부분의 UI 값들은 변경이 가능하며
// 변수값을 불러내 변경해야합니다.
// 버튼에 들어갈(text) 와 버튼의 작동 함수(func)을 필수로 입력받습니다.
class CustomButton extends StatelessWidget {
  final Color? textColor; // 텍스트 색상
  final FontWeight fontWeight; // FontWeight
  final String text; // 버튼 가운데에 들어가는 텍스트
  final Color? bgColor; // 배경색상
  final Color? borderColor; // border 테두리 색상
  final VoidCallback? func; // 버튼 눌렀을 때 작동되는 함수
  final Size? size; // 버튼의 최소 크기
  final double horizontalMargin; // 좌우 margin 값

  final double? borderRadius; // BorderRadius

  final double verticalPadding; // 상하 padding 값

  final Color? disabledBackgroundColor; // 뒷배경 Color

  const CustomButton({
    this.textColor,
    required this.text,
    this.bgColor,
    this.horizontalMargin = 16,
    this.fontWeight = FontWeight.bold,
    this.borderColor,
    required this.func,
    this.verticalPadding = 15,
    super.key,
    this.disabledBackgroundColor,
    this.size,
    this.borderRadius,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: horizontalMargin),
      child: ElevatedButton(
        onPressed: func,
        style: ElevatedButton.styleFrom(
          disabledBackgroundColor: disabledBackgroundColor,
          backgroundColor: bgColor ?? PaperPlaneColor.mainColor,
          padding: EdgeInsets.symmetric(vertical: verticalPadding),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(borderRadius ?? 50),
            side: BorderSide(
              color: borderColor ?? PaperPlaneColor.mainColor,
              width: 1.0,
            ),
          ),
          minimumSize: size != null ? Size(100, 60) : null,
          // 사이즈 조절 추가했습니다.
        ),
        child: Center(
          child: Text(
            text,
            style: PaperPlaneTS.free(
              fontSize: 20,
              fontWeight: fontWeight,
              color: textColor ?? Colors.white,
            ),
          ),
        ),
      ),
    );
  }
}

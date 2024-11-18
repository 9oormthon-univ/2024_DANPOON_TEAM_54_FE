import 'package:flutter/material.dart';

// 사용 예시
// PaperPlaneColor.mainColor33
// 각 계열별로 변수명을 설정하였고,
// Color 값의 6개값들 중 맨 앞 2개만 따서 변수명에 추가하였습니다.
// 자유롭게 추가해주세요.
class PaperPlaneColor{
  
  // main / sub Color
  static Color get mainColor => Color(0xFF338AFF);
  static Color get subColor8A => Color(0xFF8AC2FF);
  static Color get subColorBD => Color(0xFFBDE0FF);
  static Color get subColorFF => Color(0xFFFFECA9);
  static Color get subColor4D => Color(0xFF4D7EFF);
  
  // black / white
  static Color get blackColor24 => Color(0xFF242B37);
  static Color get greyColor66 => Color(0xFF667080);
  static Color get greyColorA1 => Color(0xFFA1A9B2);
  static Color get greyColorD3 => Color(0xFFD3D6DA);
  static Color get greyColorEF => Color(0xFFEFF1F4);
  static Color get greyColor96 => Color(0xFF969692);
  static Color get greyColorF6 => Color(0xFFF6F7F9);
  static Color get whiteColorF6 => Color(0xFFF6F7F9);
  static Color get whiteColor => Color(0xFFFFFFFF);

  // others
  static Color get redColorEE => Color(0xFFEE324B); 
}
import 'package:flutter/material.dart';

// 사용 예시
// PagePlaneTS.free(fontsize: 16, fontWeight: FontWeight.w400)
class PaperPlaneTS{
  
  // 자유롭게 이용되는 TextStyle
  static TextStyle free({
    required double fontSize,
    required FontWeight fontWeight,
    Color? color,
  }){
    return TextStyle(fontSize:fontSize, fontWeight: fontWeight, color: color ?? Colors.black);
  }

  // ---- 자주 이용되는 fontweight들
  // 임의로 따로 추가하셔도 상관없습니다.

  // fontweight is bold
  static TextStyle bold({
    required double fontSize,
    Color? color,
  }){
    return TextStyle(fontSize:fontSize, fontWeight: FontWeight.bold, color: color ?? Colors.black);
  }

  // fontweight is regular(w400)
  static TextStyle regular({
    required double fontSize,
    Color? color,
    TextDecoration? decoration,
    Color? decorationColor,
  }){
    return TextStyle(fontSize:fontSize, fontWeight: FontWeight.w400, color: color ?? Colors.black, decoration: decoration, decorationColor: decorationColor);
  }

  // fontweight is medium(w500)
  static TextStyle medium({
    required double fontSize,
    Color? color,
  }){
    return TextStyle(fontSize:fontSize, fontWeight: FontWeight.w500, color: color ?? Colors.black);
  }
}
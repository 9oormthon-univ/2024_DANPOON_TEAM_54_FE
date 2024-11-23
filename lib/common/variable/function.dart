import 'package:dio/dio.dart';
import 'package:intl/intl.dart';
import 'package:http_parser/http_parser.dart';

// 숫자 변형을 위한 함수
// ex) 1000 => 1,000

String formatNumber(int number) {
  final formatter = NumberFormat('#,###');
  return formatter.format(number);
}

// 날짜 변형 함수
// DateTime의 데이터를 MM/DD로 변경해준다.
// ex) 2024-11-18 05:24:34.859093
//  => 11월 18일
String formatDate(DateTime date) {
  // DateFormat을 사용하여 'MM월 dd일' 형식으로 변환
  final formatter = DateFormat('MM월 dd일');
  return formatter.format(date);
}

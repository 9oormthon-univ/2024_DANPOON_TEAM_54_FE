import 'dart:io';
import 'package:json_annotation/json_annotation.dart';

class WriteModel {
  final String title;
  final String categoryDisplayName;
  final String description;
  final String tags;
  final int price;
  final File? file;

  WriteModel({
    required this.title,
    required this.categoryDisplayName,
    required this.description,
    required this.tags,
    required this.price,
    this.file,
  });

  // toJson 메서드
  Map<String, dynamic> toJson() {
    return {
      "title": title,
      "categoryDisplayName": categoryDisplayName,
      "description": description,
      "tags": tags,
      "price": price,
      // 파일은 JSON에 포함하지 않음 (파일 업로드는 별도로 처리)
    };
  }
}

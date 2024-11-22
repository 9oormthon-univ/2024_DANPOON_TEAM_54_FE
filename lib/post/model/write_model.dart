import 'package:json_annotation/json_annotation.dart';

part 'write_model.g.dart';

@JsonSerializable()
class WriteModel {
  final String title;
  final String categoryDisplayName;
  final String description;
  final String tags;
  final int price;
  final String fileUrl;

  WriteModel({
    required this.title,
    required this.categoryDisplayName,
    required this.description,
    required this.tags,
    required this.price,
    required this.fileUrl,
  });

  // JSON 데이터를 모델 객체로 변환하는 함수
  factory WriteModel.fromJson(Map<String, dynamic> json) =>
      _$WriteModelFromJson(json);

  // 모델 객체를 JSON 데이터로 변환하는 함수
  Map<String, dynamic> toJson() => _$WriteModelToJson(this);
}

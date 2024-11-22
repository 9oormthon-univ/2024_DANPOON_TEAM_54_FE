import 'package:json_annotation/json_annotation.dart';
import 'package:papar_plane/common/model/state_model.dart';

part 'idea_model.g.dart';

@JsonSerializable()
class IdeaModel{
  final int id;
  final String title;
  final String category;
  final DateTime createdAt;
  final String tags;
  final int price;

  IdeaModel({
    required this.id,
    required this.title,
    required this.category,
    required this.createdAt,
    required this.tags,
    required this.price,
  });

  factory IdeaModel.fromJson(Map<String, dynamic> json) => _$IdeaModelFromJson(json);
}

@JsonSerializable()
class IdeaModelList extends BaseState{
  final List<IdeaModel> data;

  IdeaModelList({
    required this.data,
  });

  IdeaModelList copyWith({
    List<IdeaModel>? data,
  }) {
    return IdeaModelList(
      data: data ?? this.data,
    );
  }

  factory IdeaModelList.fromJson(Map<String, dynamic> json) => _$IdeaModelListFromJson(json);
}

@JsonSerializable()
class IdeaDetail extends BaseState{
  final int ideaId;
  final String category;
  final String title;
  final String description;
  final int price;
  final String tags;
  final int views;
  final DateTime createdAt;
  final DateTime updatedAt;
  final String fileUrl;

  IdeaDetail({
    required this.ideaId,
    required this.category,
    required this.title,
    required this.description,
    required this.price,
    required this.tags,
    required this.views,
    required this.createdAt,
    required this.updatedAt,
    required this.fileUrl,
  });

  // JSON 데이터를 모델 객체로 변환하는 함수
  factory IdeaDetail.fromJson(Map<String, dynamic> json) => _$IdeaDetailFromJson(json);

  // 모델 객체를 JSON 데이터로 변환하는 함수
  Map<String, dynamic> toJson() => _$IdeaDetailToJson(this);
}
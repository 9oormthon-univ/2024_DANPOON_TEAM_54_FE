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

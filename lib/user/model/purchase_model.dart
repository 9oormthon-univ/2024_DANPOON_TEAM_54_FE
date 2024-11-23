
import 'package:json_annotation/json_annotation.dart';
import 'package:papar_plane/common/model/state_model.dart';

part 'purchase_model.g.dart';

@JsonSerializable()
class ItemModel {
  final int ideaId;
  final String title;
  final String category;
  final DateTime createdAt;
  final String tags;
  final int price;

  ItemModel({
    required this.ideaId,
    required this.title,
    required this.category,
    required this.createdAt,
    required this.tags,
    required this.price,
  });

  // JSON 데이터를 Dart 객체로 변환
  factory ItemModel.fromJson(Map<String, dynamic> json) => _$ItemModelFromJson(json);

  // Dart 객체를 JSON으로 변환
  Map<String, dynamic> toJson() => _$ItemModelToJson(this);
}

@JsonSerializable()
class ItemList extends BaseState{
  final List<ItemModel> data;

  ItemList({
    required this.data,
  });

  factory ItemList.fromJson(Map<String, dynamic> json) => _$ItemListFromJson(json);
}
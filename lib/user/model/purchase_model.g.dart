// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'purchase_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ItemModel _$ItemModelFromJson(Map<String, dynamic> json) => ItemModel(
      ideaId: (json['ideaId'] as num).toInt(),
      title: json['title'] as String,
      category: json['category'] as String,
      createdAt: DateTime.parse(json['createdAt'] as String),
      tags: json['tags'] as String,
      price: (json['price'] as num).toInt(),
    );

Map<String, dynamic> _$ItemModelToJson(ItemModel instance) => <String, dynamic>{
      'ideaId': instance.ideaId,
      'title': instance.title,
      'category': instance.category,
      'createdAt': instance.createdAt.toIso8601String(),
      'tags': instance.tags,
      'price': instance.price,
    };

ItemList _$ItemListFromJson(Map<String, dynamic> json) => ItemList(
      data: (json['data'] as List<dynamic>)
          .map((e) => ItemModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$ItemListToJson(ItemList instance) => <String, dynamic>{
      'data': instance.data,
    };

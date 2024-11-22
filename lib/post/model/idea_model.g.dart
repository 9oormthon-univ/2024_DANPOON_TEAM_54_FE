// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'idea_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

IdeaModel _$IdeaModelFromJson(Map<String, dynamic> json) => IdeaModel(
      id: (json['id'] as num).toInt(),
      title: json['title'] as String,
      category: json['category'] as String,
      createdAt: DateTime.parse(json['createdAt'] as String),
      tags: json['tags'] as String,
      price: (json['price'] as num).toInt(),
    );

Map<String, dynamic> _$IdeaModelToJson(IdeaModel instance) => <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'category': instance.category,
      'createdAt': instance.createdAt.toIso8601String(),
      'tags': instance.tags,
      'price': instance.price,
    };

IdeaModelList _$IdeaModelListFromJson(Map<String, dynamic> json) =>
    IdeaModelList(
      data: (json['data'] as List<dynamic>)
          .map((e) => IdeaModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$IdeaModelListToJson(IdeaModelList instance) =>
    <String, dynamic>{
      'data': instance.data,
    };

IdeaDetail _$IdeaDetailFromJson(Map<String, dynamic> json) => IdeaDetail(
      id: (json['id'] as num).toInt(),
      category: json['category'] as String,
      title: json['title'] as String,
      description: json['description'] as String,
      price: (json['price'] as num).toInt(),
      tags: json['tags'] as String,
      author: json['author'] as String,
      createdAt: DateTime.parse(json['createdAt'] as String),
      status: json['status'] as String,
    );

Map<String, dynamic> _$IdeaDetailToJson(IdeaDetail instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'category': instance.category,
      'description': instance.description,
      'tags': instance.tags,
      'price': instance.price,
      'author': instance.author,
      'createdAt': instance.createdAt.toIso8601String(),
      'status': instance.status,
    };

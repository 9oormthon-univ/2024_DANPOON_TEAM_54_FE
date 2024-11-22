// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'write_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

WriteModel _$WriteModelFromJson(Map<String, dynamic> json) => WriteModel(
      title: json['title'] as String,
      categoryDisplayName: json['categoryDisplayName'] as String,
      description: json['description'] as String,
      tags: json['tags'] as String,
      price: (json['price'] as num).toInt(),
      fileUrl: json['fileUrl'] as String,
    );

Map<String, dynamic> _$WriteModelToJson(WriteModel instance) =>
    <String, dynamic>{
      'title': instance.title,
      'categoryDisplayName': instance.categoryDisplayName,
      'description': instance.description,
      'tags': instance.tags,
      'price': instance.price,
      'fileUrl': instance.fileUrl,
    };

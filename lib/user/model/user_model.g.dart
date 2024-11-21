// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SignupUser _$SignupUserFromJson(Map<String, dynamic> json) => SignupUser(
      id: (json['id'] as num).toInt(),
      nickname: json['nickname'] as String?,
    );

Map<String, dynamic> _$SignupUserToJson(SignupUser instance) =>
    <String, dynamic>{
      'id': instance.id,
      'nickname': instance.nickname,
    };

PPUser _$PPUserFromJson(Map<String, dynamic> json) => PPUser(
      id: (json['id'] as num).toInt(),
      username: json['username'] as String,
      points: (json['points'] as num).toInt(),
      profileImage: json['profileImage'] as String?,
    );

Map<String, dynamic> _$PPUserToJson(PPUser instance) => <String, dynamic>{
      'id': instance.id,
      'username': instance.username,
      'profileImage': instance.profileImage,
      'points': instance.points,
    };

// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SignupUser _$SignupUserFromJson(Map<String, dynamic> json) => SignupUser(
      nickname: json['nickname'] as String?,
    );

Map<String, dynamic> _$SignupUserToJson(SignupUser instance) =>
    <String, dynamic>{
      'nickname': instance.nickname,
    };

UserModel _$UserModelFromJson(Map<String, dynamic> json) => UserModel(
      nickname: json['nickname'] as String,
    );

Map<String, dynamic> _$UserModelToJson(UserModel instance) => <String, dynamic>{
      'nickname': instance.nickname,
    };

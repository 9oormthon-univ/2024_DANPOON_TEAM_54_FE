// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'auth_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

LoginModel _$LoginModelFromJson(Map<String, dynamic> json) => LoginModel(
      id: (json['id'] as num).toInt(),
      isFirstLogin: json['isFirstLogin'] as bool,
      accessToken: json['accessToken'] as String,
    );

Map<String, dynamic> _$LoginModelToJson(LoginModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'isFirstLogin': instance.isFirstLogin,
      'accessToken': instance.accessToken,
    };

kakaoData _$kakaoDataFromJson(Map<String, dynamic> json) => kakaoData(
      kakaoId: (json['kakaoId'] as num).toInt(),
      profileImage: json['profileImage'] as String?,
    );

Map<String, dynamic> _$kakaoDataToJson(kakaoData instance) => <String, dynamic>{
      'kakaoId': instance.kakaoId,
      'profileImage': instance.profileImage,
    };

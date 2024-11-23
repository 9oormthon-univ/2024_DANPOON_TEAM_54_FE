// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'auth_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

LoginModel _$LoginModelFromJson(Map<String, dynamic> json) => LoginModel(
      userId: (json['userId'] as num).toInt(),
      isFirstLogin: json['isFirstLogin'] as bool,
    );

Map<String, dynamic> _$LoginModelToJson(LoginModel instance) =>
    <String, dynamic>{
      'userId': instance.userId,
      'isFirstLogin': instance.isFirstLogin,
    };

KakaoData _$KakaoDataFromJson(Map<String, dynamic> json) => KakaoData(
      kakaoId: (json['kakaoId'] as num).toInt(),
      profileImage: json['profileImage'] as String?,
    );

Map<String, dynamic> _$KakaoDataToJson(KakaoData instance) => <String, dynamic>{
      'kakaoId': instance.kakaoId,
      'profileImage': instance.profileImage,
    };

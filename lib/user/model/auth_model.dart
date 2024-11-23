import 'package:json_annotation/json_annotation.dart';
import 'package:papar_plane/common/model/state_model.dart';

part 'auth_model.g.dart';

@JsonSerializable()
class LoginModel extends BaseState {
  final int userId;
  final bool isFirstLogin;
  //final String accessToken;

  LoginModel({
    required this.userId,
    required this.isFirstLogin,
    //required this.accessToken,
  });

  factory LoginModel.fromJson(Map<String, dynamic> json) => _$LoginModelFromJson(json);

  Map<String, dynamic> toJson() => _$LoginModelToJson(this); 
}

@JsonSerializable()
class KakaoData extends BaseState {
  final int kakaoId;
  final String? profileImage;

  KakaoData({
    required this.kakaoId,
    this.profileImage,
  });

  factory KakaoData.fromJson(Map<String, dynamic> json) => _$KakaoDataFromJson(json);

  Map<String, dynamic> toJson() => _$KakaoDataToJson(this);
}
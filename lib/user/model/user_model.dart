import 'package:json_annotation/json_annotation.dart';
import 'package:papar_plane/common/model/state_model.dart';

part 'user_model.g.dart';
// 회원가입할 때 사용되는 class
// 각 단계별로 하나씩 데이터를 업데이트
@JsonSerializable()
class SignupUser extends BaseState{
  final int id;
  final String? nickname;

  SignupUser({
    required this.id,
    this.nickname,
  });

  SignupUser copyWith({
    String? nickname,
    int? id,
  }) {
    return SignupUser(
      id: id ?? this.id,
      nickname: nickname ?? this.nickname,
    );
  }

  Map<String, dynamic> toJson() => _$SignupUserToJson(this);
}

// 로그인시 부여받는 객체
@JsonSerializable()
class PPUser extends BaseState {
  final int id;
  final String username;
  final String? profileImage;
  final int points;
  // final Properties properties;
  // final String connectedAt;
  // final KakaoAccount kakaoAccount;
  // final bool isFirstLogin;
  // final String accessToken;

  PPUser({
    required this.id,
    required this.username,
    required this.points,
    this.profileImage,
    // required this.properties,
    // required this.connectedAt,
    // required this.kakaoAccount,
    // required this.isFirstLogin,
    // required this.accessToken,
  });

  factory PPUser.fromJson(Map<String, dynamic> json) => _$PPUserFromJson(json);

  Map<String, dynamic> toJson() => _$PPUserToJson(this);
}

// @JsonSerializable()
// class Properties {
//   final String profileImage;
//   final String thumbnailImage;

//   Properties({
//     required this.profileImage,
//     required this.thumbnailImage,
//   });

//   factory Properties.fromJson(Map<String, dynamic> json) => _$PropertiesFromJson(json);

//   Map<String, dynamic> toJson() => _$PropertiesToJson(this);
// }

// // 카카오 로그인으로부터 받아오는 데이터
// @JsonSerializable()
// class KakaoAccount {
//   final Profile profile;
//   final bool profileImageNeedsAgreement;

//   KakaoAccount({
//     required this.profile,
//     required this.profileImageNeedsAgreement,
//   });

//   factory KakaoAccount.fromJson(Map<String, dynamic> json) => _$KakaoAccountFromJson(json);

//   Map<String, dynamic> toJson() => _$KakaoAccountToJson(this);
// }

// // 카카오 로그인의 프로필 이미지 url들
// @JsonSerializable()
// class Profile {
//   final String thumbnailImageUrl;
//   final String profileImageUrl;
//   final bool isDefaultImage;

//   Profile({
//     required this.thumbnailImageUrl,
//     required this.profileImageUrl,
//     required this.isDefaultImage,
//   });

//   factory Profile.fromJson(Map<String, dynamic> json) => _$ProfileFromJson(json);

//   Map<String, dynamic> toJson() => _$ProfileToJson(this);
// }

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
  final ProFileData profile;

  PPUser({
    required this.id,
    required this.profile,
  });
  
  factory PPUser.fromJson(Map<String, dynamic> json) => _$PPUserFromJson(json);

  Map<String, dynamic> toJson() => _$PPUserToJson(this);
}

// 로그인시 부여받는 객체
@JsonSerializable()
class ProFileData {
  final String username;
  final String? profileImage;
  final int points;

  ProFileData({
    required this.username,
    required this.points,
    this.profileImage,
  });

  factory ProFileData.fromJson(Map<String, dynamic> json) => _$ProFileDataFromJson(json);

  Map<String, dynamic> toJson() => _$ProFileDataToJson(this);
}

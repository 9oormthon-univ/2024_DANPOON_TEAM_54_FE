import 'package:json_annotation/json_annotation.dart';

part 'user_model.g.dart';

abstract class UserBase{}

class UserLoading extends UserBase{}

class UserError extends UserBase{}

// 회원가입할 때 사용되는 class
// 각 단계별로 하나씩 데이터를 업데이트
@JsonSerializable()
class SignupUser extends UserBase{
  final String? nickname;

  SignupUser({
    this.nickname,
  });

  SignupUser copyWith({
    String? nickname,
  }) {
    return SignupUser(
      nickname: nickname ?? this.nickname,
    );
  }

  Map<String, dynamic> toJson() => _$SignupUserToJson(this);
}

// 회원가입된 유저
@JsonSerializable()
class UserModel extends UserBase{
  final String nickname;

  UserModel({
    required this.nickname,
  });

  UserModel copyWith({
    String? nickname,
  }) {
    return UserModel(
      nickname: nickname ?? this.nickname,
    );
  }

  Map<String, dynamic> toJson() => _$UserModelToJson(this);
}

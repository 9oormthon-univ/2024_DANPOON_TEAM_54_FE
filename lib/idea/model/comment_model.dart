import 'package:json_annotation/json_annotation.dart';
import 'package:papar_plane/common/model/state_model.dart';

part 'comment_model.g.dart';

@JsonSerializable()
class CommentModel {
  final int id;
  final String content;
  final bool isAuthor;
  final int userId;
  final String username;
  final DateTime createdAt;
  final List<SubCommentModel> children;

  CommentModel({
    required this.id,
    required this.content,
    required this.isAuthor,
    required this.userId,
    required this.username,
    required this.createdAt,
    this.children = const [],
  });

  factory CommentModel.fromJson(Map<String, dynamic> json) => _$CommentModelFromJson(json);
  Map<String, dynamic> toJson() => _$CommentModelToJson(this);
}

@JsonSerializable()
class CommentList extends BaseState{
  final List<CommentModel> data;

  CommentList({
    required this.data,
  });

  CommentList copyWith({
    List<CommentModel>? data,
  }) {
    return CommentList(
      data: data ?? this.data,
    );
  }

  factory CommentList.fromJson(Map<String, dynamic> json) => _$CommentListFromJson(json);
  Map<String, dynamic> toJson() => _$CommentListToJson(this);
}

@JsonSerializable()
class MakeComment {
  final int ideaId;
  final int userId;

  MakeComment({
    required this.ideaId,
    required this.userId,
  });

  factory MakeComment.fromJson(Map<String, dynamic> json) => _$MakeCommentFromJson(json);
  Map<String, dynamic> toJson() => _$MakeCommentToJson(this);
}

@JsonSerializable()
class RequestComment {
  final int? parentId;
  final String content;

  RequestComment({
    this.parentId,
    required this.content,
  });

  factory RequestComment.fromJson(Map<String, dynamic> json) => _$RequestCommentFromJson(json);
  Map<String, dynamic> toJson() => _$RequestCommentToJson(this);
}

@JsonSerializable()
class SubCommentModel {
  final int id;
  final String content;
  final bool isAuthor;
  final int userId;
  final String username;
  final DateTime createdAt;

  SubCommentModel({
    required this.id,
    required this.content,
    required this.isAuthor,
    required this.userId,
    required this.username,
    required this.createdAt,
  });

  factory SubCommentModel.fromJson(Map<String, dynamic> json) => _$SubCommentModelFromJson(json);
  Map<String, dynamic> toJson() => _$SubCommentModelToJson(this);
}

// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'comment_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CommentModel _$CommentModelFromJson(Map<String, dynamic> json) => CommentModel(
      id: (json['id'] as num).toInt(),
      content: json['content'] as String,
      isAuthor: json['isAuthor'] as bool,
      userId: (json['userId'] as num).toInt(),
      username: json['username'] as String,
      createdAt: DateTime.parse(json['createdAt'] as String),
      children:
          (json['children'] as List<dynamic>).map((e) => e as String).toList(),
    );

Map<String, dynamic> _$CommentModelToJson(CommentModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'content': instance.content,
      'isAuthor': instance.isAuthor,
      'userId': instance.userId,
      'username': instance.username,
      'createdAt': instance.createdAt.toIso8601String(),
      'children': instance.children,
    };

CommentList _$CommentListFromJson(Map<String, dynamic> json) => CommentList(
      data: (json['data'] as List<dynamic>)
          .map((e) => CommentModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$CommentListToJson(CommentList instance) =>
    <String, dynamic>{
      'data': instance.data,
    };

MakeComment _$MakeCommentFromJson(Map<String, dynamic> json) => MakeComment(
      ideaId: (json['ideaId'] as num).toInt(),
      userId: (json['userId'] as num).toInt(),
    );

Map<String, dynamic> _$MakeCommentToJson(MakeComment instance) =>
    <String, dynamic>{
      'ideaId': instance.ideaId,
      'userId': instance.userId,
    };

RequestComment _$RequestCommentFromJson(Map<String, dynamic> json) =>
    RequestComment(
      parentId: (json['parentId'] as num?)?.toInt(),
      content: json['content'] as String,
    );

Map<String, dynamic> _$RequestCommentToJson(RequestComment instance) =>
    <String, dynamic>{
      'parentId': instance.parentId,
      'content': instance.content,
    };

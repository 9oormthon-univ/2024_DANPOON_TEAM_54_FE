// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'review_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Review _$ReviewFromJson(Map<String, dynamic> json) => Review(
      reviewId: (json['reviewId'] as num).toInt(),
      content: json['content'] as String,
      username: json['username'] as String,
      createdAt: DateTime.parse(json['createdAt'] as String),
    );

Map<String, dynamic> _$ReviewToJson(Review instance) => <String, dynamic>{
      'reviewId': instance.reviewId,
      'content': instance.content,
      'username': instance.username,
      'createdAt': instance.createdAt.toIso8601String(),
    };

ReviewList _$ReviewListFromJson(Map<String, dynamic> json) => ReviewList(
      data: (json['data'] as List<dynamic>)
          .map((e) => Review.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$ReviewListToJson(ReviewList instance) =>
    <String, dynamic>{
      'data': instance.data,
    };

MakeReview _$MakeReviewFromJson(Map<String, dynamic> json) => MakeReview(
      ideaId: (json['ideaId'] as num).toInt(),
      userId: (json['userId'] as num).toInt(),
      content: json['content'] as String,
    );

Map<String, dynamic> _$MakeReviewToJson(MakeReview instance) =>
    <String, dynamic>{
      'ideaId': instance.ideaId,
      'userId': instance.userId,
      'content': instance.content,
    };

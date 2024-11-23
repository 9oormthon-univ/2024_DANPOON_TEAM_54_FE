import 'package:json_annotation/json_annotation.dart';
import 'package:papar_plane/common/model/state_model.dart';

part 'review_model.g.dart';

@JsonSerializable()
class Review {
  final int reviewId;
  final String content;
  final String username;
  final DateTime createdAt;

  Review({
    required this.reviewId,
    required this.content,
    required this.username,
    required this.createdAt,
  });

  factory Review.fromJson(Map<String, dynamic> json) => _$ReviewFromJson(json);
  Map<String, dynamic> toJson() => _$ReviewToJson(this);
}

@JsonSerializable()
class ReviewList extends BaseState{
  final List<Review> data;

  ReviewList({
    required this.data,
  });

  ReviewList copyWith({
    List<Review>? data,
  }) {
    return ReviewList(
      data: data ?? this.data,
    );
  }

  factory ReviewList.fromJson(Map<String, dynamic> json) => _$ReviewListFromJson(json);
  Map<String, dynamic> toJson() => _$ReviewListToJson(this);
}

@JsonSerializable()
class MakeReview {
  final int ideaId;
  final int userId;
  final String content;

  MakeReview({
    required this.ideaId,
    required this.userId,
    required this.content,
  });

  factory MakeReview.fromJson(Map<String, dynamic> json) => _$MakeReviewFromJson(json);
  Map<String, dynamic> toJson() => _$MakeReviewToJson(this);
}
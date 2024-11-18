import 'package:flutter/material.dart';
import 'package:papar_plane/common/variable/colors.dart';

// 유저 프로필에서
// 유저 프로필 이미지를 담는 원 위젯
class UserImage extends StatelessWidget {
  final double size; // 위젯의 크기 width/height
  final String? imgUrl; // 위젯에 들어갈 이미지 url(null 가능)
  const UserImage({
    required this.size,
    this.imgUrl,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        color: PaperPlaneColor.greyColorEF,
        shape: BoxShape.circle,
        image: imgUrl == null
            ? null
            : DecorationImage(
                image: NetworkImage(
                  imgUrl!,
                ),
                fit: BoxFit.cover,
              ),
      ),
    );
  }
}

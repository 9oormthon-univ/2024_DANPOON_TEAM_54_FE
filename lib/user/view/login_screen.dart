import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:papar_plane/common/component/button.dart';
import 'package:papar_plane/common/layout/default_layout.dart';
import 'package:papar_plane/common/variable/colors.dart';
import 'package:papar_plane/common/variable/image_path.dart';
import 'package:papar_plane/common/variable/textstyle.dart';
import 'dart:math';
import 'package:papar_plane/main.dart';
import 'package:papar_plane/user/provider/user_provider.dart';
import 'package:papar_plane/user/view/signup_screen.dart';

class LoginScreen extends ConsumerWidget {
  static String get routeName => "login";
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return DefaultLayout(
      child: SafeArea(
        child: Container(
          width: double.infinity,
          height: double.infinity,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                const Color(0xFFFFECA9).withOpacity(0.3),
                const Color(0xFF8AC2FF).withOpacity(0.3),
              ],
            ),
          ),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 10),
                child: Align(
                    alignment: Alignment.centerRight,
                    child: Image.asset(
                      PaperPlaneImgPath.cloud,
                      width: MediaQuery.of(context).size.width / 3,
                      fit: BoxFit.cover,
                    )),
              ),
              Text(
                "대학생들을 위한 아이디어 공유 서비스",
                style: PaperPlaneTS.medium(
                  fontSize: 18,
                  color: PaperPlaneColor.subColor8A,
                ),
              ),
              Image.asset(
                PaperPlaneImgPath.logo,
                width: MediaQuery.of(context).size.width / 5 * 3,
                fit: BoxFit.cover,
              ),
              Text(
                "PaperPlane",
                style: PaperPlaneTS.free(
                  fontSize: 24,
                  fontWeight: FontWeight.w900,
                  color: PaperPlaneColor.mainColor,
                ),
              ),
              const SizedBox(height: 25),
              CustomPaint(
                painter: TrianglePainter(),
              ),
              Container(
                padding:
                    const EdgeInsets.symmetric(vertical: 11, horizontal: 49),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(30),
                  color: Colors.white,
                ),
                child: Text(
                  "당신의 아이디어를 날려보세요",
                  style: PaperPlaneTS.medium(
                    fontSize: 18,
                    color: PaperPlaneColor.blackColor24,
                  ),
                ),
              ),
              const Spacer(),
              CustomButton(
                text: "카카오계정으로 시작하기",
                borderRadius: 10,
                horizontalMargin: 33,
                fontWeight: FontWeight.w500,
                borderColor: const Color(0xFFFDE500),
                bgColor: const Color(0xFFFDE500),
                textColor: Colors.black,
                func: () async {
                  await ref.read(userProvider.notifier).login();
                },
              ),
              SizedBox(height: ratio.height * 70),
            ],
          ),
        ),
      ),
    );
  }
}

// 정삼각형을 그리는 CustomPainter
class TrianglePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    // 정삼각형의 경로 정의
    final Paint paint = Paint()
      ..color = Colors.white
      ..style = PaintingStyle.fill;

    final Path path = Path();

    // 정삼각형의 세 꼭짓점 좌표 설정
    double centerX = size.width / 2;
    double centerY = size.height / 2;
    double sideLength = 30; // 삼각형 한 변의 길이

    // 정삼각형의 높이 계산
    double height = (sideLength / 2) * sqrt(3.0);

    path.moveTo(centerX, centerY - height / 2); // 위쪽 꼭짓점
    path.lineTo(centerX - sideLength / 2, centerY + height / 2); // 왼쪽 아래 꼭짓점
    path.lineTo(centerX + sideLength / 2, centerY + height / 2); // 오른쪽 아래 꼭짓점
    path.close();

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}

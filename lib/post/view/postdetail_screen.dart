import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:papar_plane/common/component/post_widget.dart';
import 'package:papar_plane/common/variable/colors.dart';
import 'package:papar_plane/common/variable/image_path.dart';
import 'package:papar_plane/common/variable/textstyle.dart';
import 'package:papar_plane/user/component/user_image.dart';

class PostDetailScreen extends StatefulWidget {
  PostDetailScreen({super.key});

  @override
  State<PostDetailScreen> createState() => _PostDetailScreenState();
}

class _PostDetailScreenState extends State<PostDetailScreen> {
  List<String> tabcategory = ["상세정보", "후기", "문의하기"];

  String tabValue = "상세정보";

  String descriptions = """
가톨릭대학교 김가대 교수님 마케팅 수업에서 과제로 제출했던 레포트입니다. 해당 과제는 주요 마케팅 전략 이론을 실제 기업 사례에 적용해 분석한 내용입니다. 참고 자료와 구체적인 예시를 포함하여 높은 평가를 받았습니다. 
목차는 다음과 같습니다.

서론 - 4P 마케팅 이론 개요 및 필요성
기업 사례 선정 및 분석 목적
제품(Product) 전략 분석
가격(Price) 전략 분석
유통(Place) 전략 분석
촉진(Promotion) 전략 분석
결론 및 제언

A+ 평가를 받았던 과목이므로, 과제할때 참고하시면 많은 도움이 되실 것입니다.

""";

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: 50,
        ),
        PostWidget(
          title: "123423142",
          tags: "!@34",
          point: 324,
          category: "?!@34",
          date: DateTime.now(),
          isBoder: false,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            SizedBox(
              height: 30,
              child: ListView.builder(
                  shrinkWrap: true,
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context, index) {
                    final tab = tabcategory[index];
                    return GestureDetector(
                        onTap: () {
                          setState(() {
                            tabValue = tab;
                          });
                        },
                        child: customtabbar(tab));
                  },
                  itemCount: tabcategory.length),
            )
          ],
        ),
        Expanded(
          child: getTabContent(),
        ),
      ],
    );
  }

  Widget getTabContent() {
    if (tabValue == "상세정보") {
      return SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Text(
          descriptions,
          style: PaperPlaneTS.regular(fontSize: 16),
        ),
      );
    } else if (tabValue == "후기") {
      return ListView.builder(
        padding: EdgeInsets.zero,
        shrinkWrap: true,
        itemCount: 30,
        itemBuilder: (BuildContext context, int index) {
          return commentBox("""내용 구성도 좋고, 자료도 많아서 과제할 때 정말 유용하게 잘 참고했습니다
              !12321213123123123213""",
              DateTime(2024, 11, 17, 20, 45),
              "https://cdn.imweb.me/upload/S20210807d1f68b7a970c2/7170113c6a983.jpg",
              "페이퍼플레인");
        },
      );

      // Center(
      //   child:
      //   Text(
      //     "후기 가 없을 때 나오는 Text",
      //     style: PaperPlaneTS.regular(fontSize: 14),
      //   ),
      // );
    } else if (tabValue == "문의하기") {
      return inquiry("몇장 분량인가요?");
    } else {
      return Center(
        child: Text("탭 콘텐츠를 준비하세요."),
      );
    }
  }

  Widget inquiry(String text) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    text,
                    style: PaperPlaneTS.regular(fontSize: 14),
                  )
                ],
              ),
              SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Image.asset(
                    PaperPlaneImgPath.reply,
                    width: 10,
                    fit: BoxFit.cover,
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Expanded(
                    child: Container(
                      padding: EdgeInsets.symmetric(horizontal: 10),
                      height: 30,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: PaperPlaneColor.greyColorEF),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text("대댓글을 입력하세요"),
                          Image.asset(
                            PaperPlaneImgPath.colored_paper_plane,
                            width: 15,
                            fit: BoxFit.cover,
                          ),
                        ],
                      ),
                    ),
                  )
                ],
              )
            ],
          ),
        ),
        customDivider()
      ],
    );
  }

  Widget commentBox(
      String comment, DateTime createAt, String? imgUrl, String userName) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      UserImage(
                        size: 20,
                        imgUrl: imgUrl,
                      ),
                      SizedBox(
                        width: 5,
                      ),
                      Text(
                        userName,
                        style: PaperPlaneTS.regular(
                            fontSize: 14, color: PaperPlaneColor.greyColorA1),
                      ),
                    ],
                  ),
                  Text("${createAt.year}.${createAt.month}.${createAt.day}",
                      style: PaperPlaneTS.regular(
                          fontSize: 14, color: PaperPlaneColor.greyColorA1))
                ],
              ),
              SizedBox(
                height: 5,
              ),
              Text(
                comment,
                style: PaperPlaneTS.regular(fontSize: 14),
              ),
            ],
          ),
        ),
        customDivider()
      ],
    );
  }

  Container customDivider() {
    return Container(
      height: 1,
      width: MediaQuery.of(context).size.width,
      color: PaperPlaneColor.greyColorA1,
    );
  }

  Widget customtabbar(
    String text,
  ) {
    if (tabValue == text) {
      return Column(
        children: [
          Text(
            text,
            style: PaperPlaneTS.medium(fontSize: 16),
          ),
          SizedBox(
            height: 5,
          ),
          Container(
            height: 2,
            width: MediaQuery.of(context).size.width / tabcategory.length,
            color: PaperPlaneColor.subColor8A,
          ),
        ],
      );
    } else {
      return Column(
        children: [
          Text(
            text,
            style: PaperPlaneTS.medium(
                fontSize: 16, color: PaperPlaneColor.greyColorA1),
          ),
          SizedBox(
            height: 5,
          ),
          Container(
            height: 2,
            width: MediaQuery.of(context).size.width / tabcategory.length,
            color: PaperPlaneColor.greyColorA1,
          ),
        ],
      );
    }
  }
}

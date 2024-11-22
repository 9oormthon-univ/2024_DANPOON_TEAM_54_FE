import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:papar_plane/common/component/appbar.dart';
import 'package:papar_plane/common/component/idea_widget.dart';
import 'package:papar_plane/common/component/textformfield.dart';
import 'package:papar_plane/common/layout/default_layout.dart';
import 'package:papar_plane/common/model/state_model.dart';
import 'package:papar_plane/common/variable/colors.dart';
import 'package:papar_plane/common/variable/image_path.dart';
import 'package:papar_plane/common/variable/textstyle.dart';
import 'package:papar_plane/post/model/comment_model.dart';
import 'package:papar_plane/post/model/idea_model.dart';
import 'package:papar_plane/post/model/review_model.dart';
import 'package:papar_plane/post/provider/comment_provider.dart';
import 'package:papar_plane/post/provider/idea_detail_provider.dart';
import 'package:papar_plane/post/provider/review_provider.dart';
import 'package:papar_plane/user/component/user_image.dart';
import 'package:papar_plane/user/provider/user_provider.dart';

class IdeaDetailScreen extends ConsumerStatefulWidget {
  static String get routeName => "detail";
  final int id;
  IdeaDetailScreen({
    required this.id,
    super.key,});

  @override
  ConsumerState<IdeaDetailScreen> createState() => _IdeaDetailScreenState();
}

class _IdeaDetailScreenState extends ConsumerState<IdeaDetailScreen> with SingleTickerProviderStateMixin {
  late TabController _controller;
  List<String> tabcategory = ["상세정보", "후기", "문의하기"];

  final _commentController = TextEditingController();
  final _reviewController = TextEditingController();
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
  void initState() {
    _controller = TabController(length: 3, vsync: this);
    final userId = ref.read(userProvider.notifier).getUser().id;
    ref.read(ideaDetailProvider.notifier).getDetail(id: widget.id, userId: userId);
    ref.read(commentProvider.notifier).getComment(id: widget.id);
    ref.read(reviewProvider.notifier).getReview(id: widget.id);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(ideaDetailProvider);
    if(state is LoadingState){
      return DefaultLayout(child: Center(child: CircularProgressIndicator(color: PaperPlaneColor.mainColor,),));
    }
    if(state is ErrorState){
      return DefaultLayout(child: Center(child: Text(state.msg)));
    }
    final data = (state as IdeaDetail);
    final reviewState = ref.watch(reviewProvider);
    final commentState = ref.watch(commentProvider);
    return DefaultLayout(
      appBar: CustomAppBar.fullAppBar(context, actions: [], title: "게시물 상세보기"),
      child: SafeArea(
        child: Column(
          children: [
            IdeaWidget(
              title: data.title,
              tags: data.tags,
              point: data.price,
              category: data.category,
              date: data.createdAt,
              isBoder: false,
            ),
            TabBar(
              labelStyle: PaperPlaneTS.free(fontSize: 16, fontWeight: FontWeight.w700),
              unselectedLabelStyle: PaperPlaneTS.free(fontSize: 16, fontWeight: FontWeight.w700, color: PaperPlaneColor.greyColorA1),
              dividerColor: PaperPlaneColor.greyColorA1,
              // indicator style
              indicatorSize: TabBarIndicatorSize.tab,
              indicatorWeight: 2,
              dividerHeight: 2,
              indicator: BoxDecoration(
                border: Border(
                  bottom: BorderSide(color: PaperPlaneColor.subColor8A, width: 2,),
                ),
                borderRadius: BorderRadius.circular(0),
              ),
              controller: _controller,
              tabs: [
              Tab(text: "상세정보"),
              Tab(text: "후기"),
              Tab(text: "문의하기"),
            ]),
            Expanded(
              child: TabBarView(
                controller: _controller,
                children: [
                  firstTabBarView(data.description),
                  secondTabBarView(commentState),
                  thirdTabBarView(reviewState),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget firstTabBarView(String text){
    return SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Padding(
          padding: const EdgeInsets.only(top: 15),
          child: Text(
            text,
            style: PaperPlaneTS.regular(fontSize: 16),
          ),
        ),
      );
  }

  Widget secondTabBarView(BaseState state){
    if(state is LoadingState){
      return DefaultLayout(child: Center(child: CircularProgressIndicator(color: PaperPlaneColor.mainColor,),));
    }
    if(state is ErrorState){
      return DefaultLayout(child: Center(child: Text(state.msg)));
    }
    final data = (state as CommentList).data;
    return Stack(
      children: [
        ListView.builder(
            padding: EdgeInsets.zero,
            shrinkWrap: true,
            itemCount: data.length,
            itemBuilder: (BuildContext context, int index) {
              final review = data[index];
              return commentBox(review.content,
                  review.createdAt,
                  "https://cdn.imweb.me/upload/S20210807d1f68b7a970c2/7170113c6a983.jpg",
                  review.username,);
            },
          ),
          Positioned(
            right: 20,
          bottom: 50,
            child: GestureDetector(
              onTap: (){
              _showDialog(controller: _commentController, hintText: "대댓글을 입력해주세요.",
              func: (){
                final userId = ref.read(userProvider.notifier).getUserId();
                final comment = MakeComment(ideaId: widget.id, userId: userId);
                final request = RequestComment(content: _commentController.text);
                ref.read(commentProvider.notifier).comment(comment: comment, request: request);
              });
            },
              child: Container(
                decoration: BoxDecoration(
                  color: PaperPlaneColor.mainColor,
                  shape: BoxShape.circle
                ),
                padding: const EdgeInsets.all(10),
                child: Image.asset(PaperPlaneImgPath.edit),
              ),
            ),
          )
      ],
    );
  }

  Widget thirdTabBarView(BaseState state){
    if(state is LoadingState){
      return DefaultLayout(child: Center(child: CircularProgressIndicator(color: PaperPlaneColor.mainColor,),));
    }
    if(state is ErrorState){
      return DefaultLayout(child: Center(child: Text(state.msg)));
    }
    final data = (state as ReviewList).data;
    return Stack(
      children: [
        inquiry("몇장 분량인가요?"),
        Positioned(
          right: 20,
          bottom: 50,
          child: GestureDetector(
            onTap: (){
              _showDialog(controller: _reviewController, hintText: "후기를 작성해주세요",
              func: (){
                final userId = ref.read(userProvider.notifier).getUserId();
                final review = MakeReview(ideaId: widget.id, userId: userId, content: _reviewController.text);
                ref.read(reviewProvider.notifier).review(review: review);
              });
            },
            child: Container(
                decoration: BoxDecoration(
                  color: PaperPlaneColor.mainColor,
                  shape: BoxShape.circle
                ),
                padding: const EdgeInsets.all(10),
                child: Image.asset(PaperPlaneImgPath.chat),
              ),
          ),
        )
      ],
    );
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

  void _showDialog({
    required TextEditingController controller,
    required String hintText,
    required VoidCallback func,
  }) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        backgroundColor: Colors.white, // 배경색 흰색
        contentPadding: EdgeInsets.zero, // Dialog 내부 여백 제거
        content: Container(
          width: MediaQuery.of(context).size.width * 0.9, // 화면 너비의 90%
          padding: EdgeInsets.all(20), // 내부 여백 추가
          child: Column(
            mainAxisSize: MainAxisSize.min, // 세로 크기 최소화
            children: [
              CustomTextFormField(controller: controller, hintText: hintText, maxLines: 6,),
            ],
          ),
        ),
        actions: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop(); // Dialog 닫기
                },
                child: Text('취소'),
              ),
              TextButton(
                onPressed: func,
                child: Text('완료'),
              ),
            ],
          ),
        ],
      );
    },
  );
}

}

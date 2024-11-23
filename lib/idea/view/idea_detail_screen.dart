import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:papar_plane/common/component/appbar.dart';
import 'package:papar_plane/common/component/button.dart';
import 'package:papar_plane/common/component/dialog.dart';
import 'package:papar_plane/common/component/idea_widget.dart';
import 'package:papar_plane/common/component/textformfield.dart';
import 'package:papar_plane/common/layout/default_layout.dart';
import 'package:papar_plane/common/model/state_model.dart';
import 'package:papar_plane/common/variable/colors.dart';
import 'package:papar_plane/common/variable/image_path.dart';
import 'package:papar_plane/common/variable/textstyle.dart';
import 'package:papar_plane/common/view/root_tab.dart';
import 'package:papar_plane/idea/model/comment_model.dart';
import 'package:papar_plane/idea/model/idea_model.dart';
import 'package:papar_plane/idea/model/review_model.dart';
import 'package:papar_plane/idea/provider/comment_provider.dart';
import 'package:papar_plane/idea/provider/idea_detail_provider.dart';
import 'package:papar_plane/idea/provider/idea_provider.dart';
import 'package:papar_plane/idea/provider/review_provider.dart';
import 'package:papar_plane/user/component/user_image.dart';
import 'package:papar_plane/user/provider/user_provider.dart';
import 'package:papar_plane/user/view/profile_screen.dart';
import 'package:url_launcher/url_launcher.dart';

class IdeaDetailScreen extends ConsumerStatefulWidget {
  static String get routeName => "detail";
  final int id;
  final bool showProfile;
  IdeaDetailScreen({
    required this.id,
    this.showProfile = true,
    super.key,
  });

  @override
  ConsumerState<IdeaDetailScreen> createState() => _IdeaDetailScreenState();
}

class _IdeaDetailScreenState extends ConsumerState<IdeaDetailScreen>
    with SingleTickerProviderStateMixin {
  late TabController _controller;
  List<String> tabcategory = ["상세정보", "후기", "문의하기"];

  final _commentController = TextEditingController();
  final _reviewController = TextEditingController();
  final _cocomentController = TextEditingController();
  String tabValue = "상세정보";

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
    if (state is LoadingState) {
      return DefaultLayout(
          child: Center(
        child: CircularProgressIndicator(
          color: PaperPlaneColor.mainColor,
        ),
      ));
    }
    if (state is ErrorState) {
      return DefaultLayout(child: Center(child: Text(state.msg)));
    }
    final data = (state as IdeaDetail);
    final reviewState = ref.watch(reviewProvider);
    final commentState = ref.watch(commentProvider);
    return DefaultLayout(
      appBar: CustomAppBar.fullAppBar(context,
          actions: [actionWidget(state.status)], title: "게시물 상세보기"),
      child: SafeArea(
        child: Column(
          children: [
            IdeaWidget(
              id: data.ideaId,
              title: data.title,
              tags: data.tags,
              point: data.price,
              category: data.category,
              date: data.createdAt,
              isBoder: false,
              isOnTapDetialScreen: false,
            ),
            if(widget.showProfile)
            profileBox(data.author),
            TabBar(
                labelStyle: PaperPlaneTS.free(
                    fontSize: 16, fontWeight: FontWeight.w700),
                unselectedLabelStyle: PaperPlaneTS.free(
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                    color: PaperPlaneColor.greyColorA1),
                dividerColor: PaperPlaneColor.greyColorA1,
                // indicator style
                indicatorSize: TabBarIndicatorSize.tab,
                indicatorWeight: 2,
                dividerHeight: 2,
                indicator: BoxDecoration(
                  border: Border(
                    bottom: BorderSide(
                      color: PaperPlaneColor.subColor8A,
                      width: 2,
                    ),
                  ),
                  borderRadius: BorderRadius.circular(0),
                ),
                controller: _controller,
                tabs: [
                  const Tab(text: "상세정보"),
                  const Tab(text: "후기"),
                  const Tab(text: "문의하기"),
                ]),
            Expanded(
              child: TabBarView(
                controller: _controller,
                children: [
                  firstTabBarView(
                      text: data.description,
                      point: data.price,
                      status: data.status),
                  secondTabBarView(reviewState),
                  thirdTabBarView(commentState),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Container profileBox(String author){
    return Container(
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 16),
              margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 20),
              decoration: BoxDecoration(
                color: PaperPlaneColor.greyColorF6,
                borderRadius: BorderRadius.circular(15),
              ),
              child: Row(
                children: [
                  const UserImage(size: 40),
                  const SizedBox(width: 5),
                  Expanded(
                      child: Text(
                    author,
                    style: PaperPlaneTS.medium(
                        fontSize: 16, color: PaperPlaneColor.greyColor66),
                  )),
                  GestureDetector(
                      onTap: () {
                        context.pushNamed(ProfileScreen.routeName,
                            queryParameters: {"username": author});
                      },
                      child: Icon(
                        Icons.arrow_forward_ios,
                        color: PaperPlaneColor.greyColorA1,
                      ))
                ],
              ),
            );
  }

  Widget actionWidget(String status) {
    if (status == "OWN") {
      return PopupMenuButton(
        color: Colors.white,
        itemBuilder: (context) {
          return [
            PopupMenuItem(
              onTap: () async {
                await ref.read(ideaProvider.notifier).delete(widget.id);
                context.goNamed(RootTab.routeName);
              },
              child: const Text("삭제하기"),
            ),
            // PopupMenuItem(
            //   onTap: () {},
            //   child: Text("수정하기"),
            // ),
          ];
        },
      );
    }
    return SizedBox();
  }

  Widget firstTabBarView({
    required String text,
    required int point,
    required String status,
  }) {
    String buttonText = "구매하기";
    if (status == "PURCHASED") {
      buttonText = "다운로드";
    }
    return Stack(
      children: [
        SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Padding(
            padding: const EdgeInsets.only(top: 15, bottom: 60),
            child: Text(
              text,
              style: PaperPlaneTS.regular(fontSize: 16),
            ),
          ),
        ),
        if (status != "OWN")
          Positioned(
            bottom: 20,
            right: 0,
            left: 0,
            child: CustomButton(
              text: buttonText,
              func: () {
                if(buttonText == "구매하기"){
                  CustomDialog(
                    context: context,
                    title: "구매하시겠습니까?",
                    OkText: "확인",
                    CancelText: "취소",
                    func: () {
                      final userId = ref.read(userProvider.notifier).getUserId();
                      ref.read(userProvider.notifier).purchase(buyerId: userId, ideaId: widget.id);
                      ref.read(userProvider.notifier).setPoint(point);
                      ref.read(ideaDetailProvider.notifier).getDetail(id: widget.id, userId: userId);
                      context.pop();
                    },
                  );
                  return;
                }
                CustomDialog(
                    context: context,
                    title: "다운로드하시겠습니까?",
                    OkText: "확인",
                    CancelText: "취소",
                    func: () async {
                      final userId = ref.read(userProvider.notifier).getUserId();
                      final fileUrl = await ref.read(ideaProvider.notifier).getFile(widget.id, userId);
                      if(fileUrl == null){
                        return;
                      }
                      _launchUrl(fileUrl);
                      context.pop();
                    },
                  );
              },
            ),
          )
      ],
    );
  }

  Future<void> _launchUrl(String url) async {
    if (!await launchUrl(Uri.parse(url))) {
      throw Exception('Could not launch $url');
    }
  }

  Widget secondTabBarView(BaseState state) {
    if (state is LoadingState) {
      return DefaultLayout(
          child: Center(
        child: CircularProgressIndicator(
          color: PaperPlaneColor.mainColor,
        ),
      ));
    }
    if (state is ErrorState) {
      return DefaultLayout(child: Center(child: Text(state.msg)));
    }
    final data = (state as ReviewList).data;
    return Stack(
      children: [
        ListView.builder(
          padding: EdgeInsets.zero,
          shrinkWrap: true,
          itemCount: data.length,
          itemBuilder: (BuildContext context, int index) {
            final review = data[index];
            return commentBox(
              review.content,
              review.createdAt,
              "https://cdn.imweb.me/upload/S20210807d1f68b7a970c2/7170113c6a983.jpg",
              review.username,
            );
          },
        ),
        Positioned(
          right: 20,
          bottom: 50,
          child: GestureDetector(
            onTap: () {
              _showDialog(
                  controller: _reviewController,
                  hintText: "후기을 입력해주세요.",
                  func: () async {
                    final userId = ref.read(userProvider.notifier).getUserId();
                    final review = MakeReview(
                      ideaId: widget.id,
                      userId: userId,
                      content: _reviewController.text,
                    );

                    await ref
                        .read(reviewProvider.notifier)
                        .review(review: review);
                    _reviewController.text = '';
                    context.pop();
                  });
            },
            child: Container(
              decoration: BoxDecoration(
                  color: PaperPlaneColor.mainColor, shape: BoxShape.circle),
              padding: const EdgeInsets.all(10),
              child: Image.asset(PaperPlaneImgPath.edit),
            ),
          ),
        )
      ],
    );
  }

  Widget thirdTabBarView(BaseState state) {
    if (state is LoadingState) {
      return DefaultLayout(
          child: Center(
        child: CircularProgressIndicator(
          color: PaperPlaneColor.mainColor,
        ),
      ));
    }
    if (state is ErrorState) {
      return DefaultLayout(child: Center(child: Text(state.msg)));
    }
    final data = (state as CommentList).data;
    return Stack(
      children: [
        inquiry(data),
        Positioned(
          right: 20,
          bottom: 50,
          child: GestureDetector(
            onTap: () {
              _showDialog(
                  controller: _commentController,
                  hintText: "댓글을 작성해주세요",
                  func: () async {
                    final userId = ref.read(userProvider.notifier).getUserId();
                    final comment = MakeComment(ideaId: widget.id, userId: userId);
                    final request = RequestComment(content: _commentController.text);
                    await ref.read(commentProvider.notifier).comment(comment: comment, request: request);
                    _commentController.text = '';
                    context.pop();
                  });
            },
            child: Container(
              decoration: BoxDecoration(
                  color: PaperPlaneColor.mainColor, shape: BoxShape.circle),
              padding: const EdgeInsets.all(10),
              child: Image.asset(PaperPlaneImgPath.chat),
            ),
          ),
        )
      ],
    );
  }

  Widget inquiry(List<CommentModel> list) {
    return ListView.builder(
        itemCount: list.length,
        itemBuilder: (context, index) {
          final data = list[index];
          return Column(
            children: [
              Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text(
                          data.content,
                          style: PaperPlaneTS.regular(fontSize: 14),
                        )
                      ],
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    ...List.generate(data.children.length, (index) {
                      final model = data.children[index];
                      return subCommentWidget(data.id, model: model);
                    }),
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
                          child: GestureDetector(
                            onTap: () {
                              _showDialog(
                                  controller: _cocomentController,
                                  hintText: "대댓글을 작성해주세요",
                                  func: () async {
                                    final userId = ref.read(userProvider.notifier).getUserId();
                                    final comment = MakeComment(ideaId: widget.id, userId: userId);
                                    final request = RequestComment(content: _cocomentController.text,parentId: data.id);
                                    await ref.read(commentProvider.notifier).comment(comment: comment, request: request);
                                    _cocomentController.text = '';
                                    context.pop();
                                  });
                            },
                            child: Container(
                              padding: EdgeInsets.symmetric(horizontal: 10),
                              height: 30,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20),
                                  color: PaperPlaneColor.greyColorEF),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  const Text("대댓글을 입력하세요"),
                                  Image.asset(
                                    PaperPlaneImgPath.colored_paper_plane,
                                    width: 15,
                                    fit: BoxFit.cover,
                                  ),
                                ],
                              ),
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
        });
  }

  Widget commentBox(
      String comment, DateTime createAt, String? imgUrl, String userName) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
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

  Widget subCommentWidget(
    int parentId, {
    SubCommentModel? model,
  }) {
    if (model != null) {
      final username = model.isAuthor ? "글쓴이" : model.username;
      return Padding(
        padding: const EdgeInsets.symmetric(vertical: 4),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Image.asset(
              PaperPlaneImgPath.reply,
              width: 10,
              fit: BoxFit.cover,
            ),
            const SizedBox(width: 10),
            Text(
              username,
              style: PaperPlaneTS.medium(
                fontSize: 14,
                color: PaperPlaneColor.mainColor,
              ),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: Text(
                model.content,
                style: PaperPlaneTS.regular(fontSize: 14),
              ),
            ),
          ],
        ),
      );
    }
    return Row(
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
          child: GestureDetector(
            onTap: () {
              _showDialog(
                  controller: _cocomentController,
                  hintText: "대댓글을 작성해주세요",
                  func: () async {
                    final userId = ref.read(userProvider.notifier).getUserId();
                    final comment =
                        MakeComment(ideaId: widget.id, userId: userId);
                    final request = RequestComment(
                        content: _cocomentController.text, parentId: parentId);
                    await ref
                        .read(commentProvider.notifier)
                        .comment(comment: comment, request: request);
                    _cocomentController.text = '';
                    context.pop();
                  });
            },
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 10),
              height: 30,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: PaperPlaneColor.greyColorEF),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text("대댓글을 입력하세요"),
                  Image.asset(
                    PaperPlaneImgPath.colored_paper_plane,
                    width: 15,
                    fit: BoxFit.cover,
                  ),
                ],
              ),
            ),
          ),
        )
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
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
                border: Border.all(width: 1, color: PaperPlaneColor.mainColor)),
            width: MediaQuery.of(context).size.width, // 화면 너비의 90%
            padding: EdgeInsets.all(20), // 내부 여백 추가
            child: Column(
              mainAxisSize: MainAxisSize.min, // 세로 크기 최소화
              children: [
                CustomTextFormField(
                  controller: controller,
                  style: PaperPlaneTS.regular(fontSize: 14),
                  hintText: hintText,
                  fillColor: Colors.white,
                  borderColor: Colors.white,
                  borderRadius: 10,
                  maxLines: 4,
                  contentPadding: EdgeInsets.all(10),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    GestureDetector(
                      onTap: () {
                        Navigator.of(context).pop(); // Dialog 닫기
                      },
                      child: dialogButtonBox("취소", PaperPlaneColor.greyColorD3),
                    ),
                    SizedBox(
                      width: 5,
                    ),
                    GestureDetector(
                      onTap: func,
                      child: dialogButtonBox("완료", PaperPlaneColor.mainColor),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget dialogButtonBox(String text, Color color) {
    return Container(
      decoration:
          BoxDecoration(borderRadius: BorderRadius.circular(50), color: color),
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 5, horizontal: 20),
        child: Text(
          text,
          style: PaperPlaneTS.medium(fontSize: 16, color: Colors.white),
        ),
      ),
    );
  }
}
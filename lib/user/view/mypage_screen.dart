import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:papar_plane/common/component/appbar.dart';
import 'package:papar_plane/common/component/idea_widget.dart';
import 'package:papar_plane/common/layout/default_layout.dart';
import 'package:papar_plane/common/model/state_model.dart';
import 'package:papar_plane/common/variable/colors.dart';
import 'package:papar_plane/common/variable/function.dart';
import 'package:papar_plane/common/variable/textstyle.dart';
import 'package:papar_plane/user/component/user_image.dart';
import 'package:papar_plane/user/model/purchase_model.dart';
import 'package:papar_plane/user/provider/purchase_provider.dart';
import 'package:papar_plane/user/provider/sells_provider.dart';
import 'package:papar_plane/user/provider/user_provider.dart';

class MyPageScreen extends ConsumerStatefulWidget {
  static String get routeName => "mypage";
  const MyPageScreen({super.key});

  @override
  ConsumerState<MyPageScreen> createState() => _MyPageScreenState();
}

class _MyPageScreenState extends ConsumerState<MyPageScreen>
    with SingleTickerProviderStateMixin {
  late TabController _controller;

  @override
  void initState() {
    final userId = ref.read(userProvider.notifier).getUser().id;
    _controller = TabController(length: 2, vsync: this);
    ref.read(mySellProvider.notifier).getData(userId);
    ref.read(myPurchaseProvider.notifier).getData(userId);
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  List<String> tags = ["마케팅", "가톨릭대", "레포트", "마케팅", "가톨릭대", "레포트"];

  @override
  Widget build(BuildContext context) {
    final profile = ref.read(userProvider.notifier).getUser();
    final sell = ref.watch(mySellProvider);
    final purchase = ref.watch(myPurchaseProvider);
    return DefaultLayout(
      appBar: CustomAppBar.noAppBar(context, title: "마이페이지"),
      child: Column(
        children: [
          userProfile(
            nickname: profile.profile.username,
            imgUrl: profile.profile.profileImage,
          ),
          pointBox(profile.profile.points),
          mypageTabBar(),
          Expanded(
            child: TabBarView(
              controller: _controller,
              children: [
                TabBarViewWidget(sell),
                TabBarViewWidget(purchase),
              ],
            ),
          )
        ],
      ),
    );
  }

  // TabBarView에 나타나는 위젯 함수
  // 추후 변수로 넣는 data에 따라 달라지도록 구현할 예정
  Widget TabBarViewWidget(BaseState state) {
    if (state is LoadingState) {
      return Center(
        child: CircularProgressIndicator(
          color: PaperPlaneColor.mainColor,
        ),
      );
    }
    if (state is ErrorState) {
      return Center(child: Text(state.msg));
    }
    final dataList = (state as ItemList).data;
    return ListView.builder(
      shrinkWrap: true,
      itemCount: dataList.length,
      itemBuilder: (context, index) {
        final data = dataList[index];
        // 첫 인덱스시, 간격 추가
        if (index == 0) {
          return Padding(
            padding: const EdgeInsets.only(top: 10),
            child: IdeaWidget(
              id: data.ideaId,
              title: data.title,
              tags: data.tags,
              point: data.price,
              category: data.category,
              date: data.createdAt,
              isOnTapDetialScreen: true,
            ),
          );
        }
        // 마지막 인덱스시, 간격 추가
        if (index == dataList.length - 1) {
          return Padding(
            padding: const EdgeInsets.only(bottom: 10),
            child: IdeaWidget(
              id: data.ideaId,
              title: data.title,
              tags: data.tags,
              point: data.price,
              category: data.category,
              date: data.createdAt,
              isOnTapDetialScreen: true,
            ),
          );
        }
        return IdeaWidget(
          id: data.ideaId,
          title: data.title,
          tags: data.tags,
          point: data.price,
          category: data.category,
          date: data.createdAt,
          isOnTapDetialScreen: true,
        );
      },
    );
  }

  // 내역리스트를 구성하는 하나의 위젯
  // 제목, 태그, 포인트, 카테고리, 날짜 데이터 받기
  Container historyListWidget({
    required String title,
    required List<String> tags,
    required int point,
    required String category,
    required DateTime date,
  }) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        border: Border.all(width: 0.5, color: PaperPlaneColor.greyColorD3),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: PaperPlaneTS.medium(fontSize: 16),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 2, bottom: 10),
            child: Text(
              "$category · ${formatDate(date)}",
              style: PaperPlaneTS.regular(
                fontSize: 14,
                color: PaperPlaneColor.greyColorA1,
              ),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Expanded(
                child: Wrap(
                  spacing: 5,
                  runSpacing: 5,
                  children: [
                    ...List.generate(
                      tags.length,
                      (index) => tagBox(
                        tags[index],
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                padding:
                    const EdgeInsets.symmetric(vertical: 8, horizontal: 20),
                decoration: BoxDecoration(
                  color: PaperPlaneColor.mainColor,
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Text(
                  "P ${formatNumber(point)}",
                  style: PaperPlaneTS.medium(
                    fontSize: 16,
                    color: Colors.white,
                  ),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }

  // 태그를 담는 Box
  Container tagBox(String text) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 2.5, horizontal: 5),
      decoration: BoxDecoration(
        color: PaperPlaneColor.mainColor.withOpacity(0.1),
        borderRadius: BorderRadius.circular(15),
      ),
      child: Text(
        text,
        style: PaperPlaneTS.regular(
          fontSize: 14,
          color: PaperPlaneColor.subColor4D,
        ),
      ),
    );
  }

  // 마이페이지에서 사용되는 TabBar
  TabBar mypageTabBar() {
    return TabBar(
      controller: _controller,
      labelStyle: PaperPlaneTS.medium(fontSize: 16),
      unselectedLabelStyle:
          PaperPlaneTS.medium(fontSize: 16, color: PaperPlaneColor.greyColorA1),
      dividerColor: PaperPlaneColor.greyColorA1,
      // indicator style
      indicatorSize: TabBarIndicatorSize.tab,
      indicatorWeight: 3,
      indicatorColor: PaperPlaneColor.subColor8A,
      indicator: BoxDecoration(
        border: Border(
          bottom: BorderSide(color: PaperPlaneColor.subColor8A, width: 2),
        ),
        borderRadius: BorderRadius.circular(0),
      ),
      tabs: [
        Tab(text: "판매 내역"),
        Tab(text: "구매 내역"),
      ],
    );
  }

  // 유저 프로필 이미지와 닉네임을 담은 Widget
  Padding userProfile({
    required String nickname,
    String? imgUrl,
  }) {
    return Padding(
      padding: const EdgeInsets.only(top: 30, bottom: 20, left: 20, right: 20),
      child: Row(
        children: [
          UserImage(
            size: 60,
            imgUrl: imgUrl,
          ),
          const SizedBox(width: 10),
          Text(
            nickname,
            style: PaperPlaneTS.bold(
              fontSize: 24,
            ),
          ),
        ],
      ),
    );
  }

  // 유저의 포인트 데이터가 담긴 box
  Container pointBox(int point) {
    return Container(
      padding: const EdgeInsets.all(16),
      margin: const EdgeInsets.only(bottom: 20, left: 20, right: 20),
      width: double.infinity,
      decoration: BoxDecoration(
        color: PaperPlaneColor.greyColorF6,
        borderRadius: BorderRadius.circular(15),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "나의 포인트",
            style: PaperPlaneTS.medium(
              fontSize: 16,
              color: PaperPlaneColor.greyColor66,
            ),
          ),
          Text(
            "$point",
            style: PaperPlaneTS.bold(
              fontSize: 20,
              color: PaperPlaneColor.mainColor,
            ),
          ),
        ],
      ),
    );
  }
}

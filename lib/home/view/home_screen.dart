import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:papar_plane/common/component/post_widget.dart';
import 'package:papar_plane/common/component/textformfield.dart';
import 'package:papar_plane/common/model/state_model.dart';
import 'package:papar_plane/common/variable/colors.dart';
import 'package:papar_plane/common/variable/image_path.dart';
import 'package:papar_plane/common/variable/textstyle.dart';
import 'package:papar_plane/home/model/idea_model.dart';
import 'package:papar_plane/home/provider/idea_provider.dart';

class HomeScreen extends ConsumerStatefulWidget {
  HomeScreen({super.key});

  @override
  ConsumerState<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
  TextEditingController _controller = TextEditingController();
  List<String> tabs = [
    "전체",
    "대외활동",
    "디자인",
    "IT/트렌드",
    "기타",
  ];

  @override
  void initState() {
    ref.read(ideaProvider.notifier).getAllData();
    super.initState();
  }

  String tabValue = "전체";

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(ideaCategoryProvider(getCategoryString(tabValue)));
    if(state is LoadingState){
      return Center(child: CircularProgressIndicator(color: PaperPlaneColor.mainColor,),);
    }
    if(state is ErrorState){
      return Center(child: Text(state.msg));
    }
    final dataList = (state as IdeaModelList).data;
    return SafeArea(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          serachBar(),
          const SizedBox(height: 10),
          customTabBar(),
          const Divider(),
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.only(top: 10),
              shrinkWrap: true,
              itemCount: dataList.length,
              itemBuilder: (context, index) {
                final data = dataList[index];
                return PostWidget(
                  title: data.title,
                  tags: data.tags,
                  point: data.price,
                  category: data.category,
                  date: data.createdAt,
                );
              },
            ),
          ),
        ],
      ),
    );
  }
  
  // Search bar
  Padding serachBar(){
    return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Row(
              children: [
                Image.asset(
                  PaperPlaneImgPath.logo,
                  width: 60,
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: CustomTextFormField(
                    isDense: true,
                    contentPadding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                    borderColor: PaperPlaneColor.mainColor,
                    fillColor: Colors.white,
                    controller: _controller,
                    hintText: "",
                  ),
                ),
                const SizedBox(width: 5),
                GestureDetector(
                  onTap: (){},
                  child: Icon(
                    Icons.search,
                    color: PaperPlaneColor.mainColor,
                    size: 30,
                  ),
                )
              ],
            ),
          );
  }

  // TabBar
  Widget customTabBar() {
    return SizedBox(
      height: 20,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        shrinkWrap: true,
        itemBuilder: (context, index) {
          final tab = tabs[index];
          if (index == 0) {
            return GestureDetector(
              onTap: () {
                setState(() {
                  tabValue = tab;
                });
              },
              child: Padding(
                padding: const EdgeInsets.only(left: 20),
                child: tabText(tab),
              ),
            );
          }
          if (index == tabs.length - 1) {
            return GestureDetector(
              onTap: () {
                setState(() {
                  tabValue = tab;
                });
              },
              child: Padding(
                padding: const EdgeInsets.only(right: 20),
                child: tabText(tab),
              ),
            );
          }
          return GestureDetector(
            onTap: () {
              setState(() {
                tabValue = tab;
              });
            },
            child: tabText(tab),
          );
        },
        separatorBuilder: (context, index) {
          return const SizedBox(width: 20);
        },
        itemCount: tabs.length,
      ),
    );
  }

  // Tab에 들어가는 텍스트
  // Value값에 따라서 Style이 달라집니다.
  Text tabText(String text) {
    if (text != tabValue) {
      return Text(
        text,
        style: PaperPlaneTS.medium(
          fontSize: 16,
          color: PaperPlaneColor.greyColor66,
        ),
      );
    }
    return Text(
      text,
      style: PaperPlaneTS.medium(fontSize: 16),
    );
  }

  // 서버로 보낼 카테고리 String 반환
  String getCategoryString(String category){
    switch(category){
      case "전체":
        return "전체";
      case "대외활동":
        return "JOB_ACTIVITY";
      case "IT/트렌드":
        return "IT_TREND";
      case "디자인":
        return "DESIGN_TEMPLATE";
      default:
        return "OTHERS";
    }
  }
}
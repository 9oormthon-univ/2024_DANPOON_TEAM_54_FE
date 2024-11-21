import 'package:flutter/material.dart';
import 'package:papar_plane/common/component/post_widget.dart';
import 'package:papar_plane/common/variable/colors.dart';
import 'package:papar_plane/common/variable/textstyle.dart';
import 'package:papar_plane/home/model/home_list_model.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<String> tabs = [
    "전체",
    "시험/과제",
    "대외활동",
    "디자인",
    "전체1234",
    "시험125/과2341제",
    "대외2135활동",
    "디자2314인"
  ];

  String tabValue = "전체";

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: 20,
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              shrinkWrap: true,
              itemBuilder: (context, index) {
                final tab = tabs[index];
                if(index == 0){
                  GestureDetector(
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
                if(index == tabs.length - 1){
                  GestureDetector(
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
                return const SizedBox(width: 10);
              },
              itemCount: tabs.length,
            ),
          ),
          Divider(),
          ListView.builder(
            shrinkWrap: true,
            itemCount: HomeListModel.dummyHomeList.length,
            itemBuilder: (context, index) {
              final data = HomeListModel.dummyHomeList[index];
              return PostWidget(
                title: data.title,
                tags: data.tags,
                point: data.price,
                category: data.category,
                date: data.createdAt,
              );
            },
          ),
        ],
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
}

class HomeList extends StatelessWidget {
  final HomeListModel homeListModel;

  const HomeList({
    super.key,
    required this.homeListModel,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.fromLTRB(15, 10, 15, 5),
      decoration: BoxDecoration(
          border: Border.all(width: 1, color: PaperPlaneColor.greyColorD3),
          borderRadius: BorderRadius.circular(10)),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(
                  homeListModel.title,
                  style: PaperPlaneTS.medium(fontSize: 16),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(
                  "${homeListModel.category} · ${homeListModel.createdAt.month}월 ${homeListModel.createdAt.day}일 ",
                  style: PaperPlaneTS.regular(
                      fontSize: 14, color: PaperPlaneColor.greyColorA1),
                ),
              ],
            ),
            SizedBox(
              height: 5.0,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: 30,
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        shrinkWrap: true,
                        itemCount: homeListModel.tags.length,
                        itemBuilder: (context, index) {
                          return Container(
                            margin: EdgeInsets.fromLTRB(0, 0, 10, 0),
                            padding: EdgeInsets.all(5),
                            decoration: BoxDecoration(
                                color: PaperPlaneColor.subColorBD,
                                borderRadius: BorderRadius.circular(15)),
                            child: Text(
                              homeListModel.tags[index],
                              style: PaperPlaneTS.regular(
                                  fontSize: 14,
                                  color: PaperPlaneColor.mainColor),
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                ),
                Container(
                  padding: EdgeInsets.fromLTRB(20, 5, 20, 5),
                  decoration: BoxDecoration(
                      color: PaperPlaneColor.mainColor,
                      borderRadius: BorderRadius.circular(50)),
                  child: Text(
                    "P ${homeListModel.price}",
                    style: PaperPlaneTS.medium(
                        fontSize: 16, color: PaperPlaneColor.whiteColor),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

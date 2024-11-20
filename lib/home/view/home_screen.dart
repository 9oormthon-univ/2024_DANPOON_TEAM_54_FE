import 'package:flutter/material.dart';
import 'package:papar_plane/common/variable/colors.dart';
import 'package:papar_plane/common/variable/textstyle.dart';
import 'package:papar_plane/home/model/home_list_model.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "전체",
                ),
                Text(
                  "시험/과제",
                ),
                Text(
                  "대외활동",
                ),
                Text(
                  "IT/트렌드",
                ),
                Text(
                  "디자인",
                ),
                Text("생활"),
              ],
            ),
          ),
          Divider(),
          ListView.builder(
            shrinkWrap: true,
            itemCount: HomeListModel.dummyHomeList.length,
            itemBuilder: (context, index) {
              return HomeList(
                  homeListModel: HomeListModel.dummyHomeList[index]);
            },
          ),
        ],
      ),
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

import 'package:flutter/material.dart';
import 'package:papar_plane/common/component/post_widget.dart';
import 'package:papar_plane/home/model/home_list_model.dart';
import 'package:papar_plane/home/view/home_screen.dart';

class PostDetailScreen extends StatelessWidget {
  List<String> tapcategory = ["상세정보", "후기", "문의하기"];

  PostDetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: 50,
        ),
        PostWidget(
          title: HomeListModel.dummyHomeList[1].title,
          tags: HomeListModel.dummyHomeList[1].tags,
          point: HomeListModel.dummyHomeList[1].price,
          category: HomeListModel.dummyHomeList[1].category,
          date: HomeListModel.dummyHomeList[1].createdAt,
          isBoder: false,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            SizedBox(
              height: 30,
              child: ListView.separated(
                  shrinkWrap: true,
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context, index) {
                    return Column(
                      children: [
                        Text(tapcategory[index]),
                      ],
                    );
                  },
                  separatorBuilder: (context, index) {
                    return const SizedBox(width: 100);
                  },
                  itemCount: tapcategory.length),
            )
          ],
        ),
        Divider(
          height: 2.0,
        )
      ],
    );
  }
}

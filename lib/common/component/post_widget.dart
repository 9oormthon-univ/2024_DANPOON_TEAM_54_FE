import 'package:flutter/material.dart';
import 'package:papar_plane/common/variable/colors.dart';
import 'package:papar_plane/common/variable/function.dart';
import 'package:papar_plane/common/variable/textstyle.dart';

class PostWidget extends StatelessWidget {
  final String title;
  final String tags;
  final int point;
  final String category;
  final DateTime date;

  const PostWidget({
    required this.title,
    required this.tags,
    required this.point,
    required this.category,
    required this.date,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final tagList = tags.split(',');
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
                      tagList.length,
                      (index) => tagBox(
                        tagList[index],
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
}

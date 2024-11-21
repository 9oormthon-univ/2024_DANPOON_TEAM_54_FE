import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:papar_plane/common/component/button.dart';
import 'package:papar_plane/common/component/textformfield.dart';
import 'package:papar_plane/common/variable/colors.dart';
import 'package:papar_plane/common/variable/image_path.dart';
import 'package:papar_plane/common/variable/textstyle.dart';

class PostScreen extends StatelessWidget {
  final _titleController = TextEditingController();
  final _pointController = TextEditingController();
  final _tagController = TextEditingController();
  final _descriptionController = TextEditingController();

  List<String> category = ["시험/과제", "IT/트렌드", "대외 활동", "디자인", "생활/경제", "기타"];
  PostScreen({super.key});
  double sizedboxValue = 30;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15.0),
      child: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: 50,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [titleText("제목")],
            ),
            CustomTextFormField(
              controller: _titleController,
              hintText: "제목을 입력해주세요",
              borderRadius: 20,
            ),
            SizedBox(
              height: sizedboxValue,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                titleText("카테고리"),
                SizedBox(
                  width: 10,
                ),
                subTitleText("하나를 선택해주세요."),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                SizedBox(
                  height: 80,
                  child: Wrap(
                    direction: Axis.vertical, // 나열 방향
                    alignment: WrapAlignment.start,
                    // runSpacing: 5,
                    // spacing: 5,
                    children: [
                      ...List.generate(category.length,
                          (index) => categoryText(category[index]))
                    ],
                  ),
                ),
              ],
            ),
            SizedBox(
              height: sizedboxValue,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                titleText("포인트"),
              ],
            ),
            CustomTextFormField(
              controller: _pointController,
              hintText: "",
              suffixIcon: Image.asset(
                PaperPlaneImgPath.P_icon,
              ),
              inputFormatters: [FilteringTextInputFormatter.digitsOnly],
              borderRadius: 20,
            ),
            SizedBox(
              height: sizedboxValue,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                titleText("태그"),
                SizedBox(
                  width: 10,
                ),
                subTitleText("최대 3개까지 가능, 콤마(,)로 구분")
              ],
            ),
            CustomTextFormField(
              controller: _tagController,
              hintText: "태그를 입력해주세요",
              borderRadius: 20,
            ),
            SizedBox(
              height: sizedboxValue,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                titleText("내용"),
              ],
            ),
            CustomTextFormField(
              controller: _descriptionController,
              hintText: "내용을 입력해주세요",
              borderRadius: 20,
              maxLines: 7,
            ),
            SizedBox(
              height: sizedboxValue,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                titleText("파일"),
                SizedBox(
                  width: 10,
                ),
                subTitleText("png, pdf 파일 업로드해주세요.")
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Container(
                  width: 120,
                  height: 120,
                  decoration: BoxDecoration(
                      color: PaperPlaneColor.whiteColorF6,
                      borderRadius: BorderRadius.circular(20)),
                ),
              ],
            ),
            SizedBox(
              height: sizedboxValue,
            ),
            CustomButton(
              text: "작성하기",
              func: () {},
              borderRadius: 20,
              horizontalMargin: 0,
            )
          ],
        ),
      ),
    );
  }
}

Text titleText(String text) {
  return Text(
    text,
    style: PaperPlaneTS.medium(fontSize: 18, color: PaperPlaneColor.subColor4D),
  );
}

Text subTitleText(String text) {
  return Text(
    text,
    style:
        PaperPlaneTS.regular(fontSize: 14, color: PaperPlaneColor.subColor8A),
  );
}

Container categoryText(String text) {
  return Container(
    margin: EdgeInsets.all(3),
    padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
    decoration: BoxDecoration(
      color: PaperPlaneColor.mainColor.withOpacity(0.1),
      borderRadius: BorderRadius.circular(30),
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

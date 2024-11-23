import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:papar_plane/common/component/appbar.dart';
import 'package:papar_plane/common/component/button.dart';
import 'package:papar_plane/common/component/dialog.dart';
import 'package:papar_plane/common/component/textformfield.dart';
import 'package:papar_plane/common/layout/default_layout.dart';
import 'package:papar_plane/common/variable/category.dart';
import 'package:papar_plane/common/variable/colors.dart';
import 'package:papar_plane/common/variable/textstyle.dart';
import 'package:papar_plane/idea/model/write_model.dart';
import 'package:papar_plane/idea/provider/idea_provider.dart';
import 'package:papar_plane/idea/view/idea_detail_screen.dart';
import 'package:papar_plane/user/provider/user_provider.dart';

class WriteScreen extends ConsumerStatefulWidget {
  static String get routeName => "write";
  WriteScreen({super.key});

  @override
  ConsumerState<WriteScreen> createState() => _WriteScreenState();
}

class _WriteScreenState extends ConsumerState<WriteScreen> {
  final _titleController = TextEditingController();

  final _pointController = TextEditingController();

  final _tagController = TextEditingController();

  final _descriptionController = TextEditingController();

  String categoryValues = '';

  double sizedboxValue = 30;

  File? selectedFile;

  Future<void> pickFile() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles();

    if (result != null) {
      setState(() {
        selectedFile = File(result.files.single.path!);
      });
    } else {
      // User canceled the picker
    }
  }

  @override
  Widget build(BuildContext context) {
    return DefaultLayout(
      appBar: CustomAppBar.noActionAppBar(context, title: "게시물 작성"),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 13),
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
                  const SizedBox(
                    width: 10,
                  ),
                  subTitleText("하나를 선택해주세요."),
                ],
              ),
              const SizedBox(height: 5),
              Wrap(
                direction: Axis.horizontal, // 나열 방향
                alignment: WrapAlignment.start,
                runSpacing: 10,
                spacing: 10,
                children: [
                  ...List.generate(
                    category.length,
                    (index) => categoryText(
                      category[index],
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
                hintText: '',
                inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                contentPadding: const EdgeInsets.symmetric(vertical: 13),
                textAlign: TextAlign.end,
                suffixIconConstraints: const BoxConstraints(
                  minWidth: 25, // 원하는 너비로 제한
                ),
                suffixIcon: Padding(
                  padding: const EdgeInsets.only(top: 3),
                  child: Text(
                    "P",
                    style: PaperPlaneTS.medium(
                      fontSize: 18,
                      color: PaperPlaneColor.mainColor,
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: sizedboxValue,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  titleText("태그"),
                  const SizedBox(
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
                  const SizedBox(
                    width: 10,
                  ),
                  subTitleText("png, pdf 파일 업로드해주세요.")
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  GestureDetector(
                    onTap: pickFile,
                    child: Container(
                      width: 120,
                      height: 120,
                      decoration: BoxDecoration(
                        color: PaperPlaneColor.whiteColorF6,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: selectedFile != null ? Center(
                        child: Icon(Icons.circle_outlined, color: PaperPlaneColor.mainColor, size: 60,),
                      ) : const SizedBox()
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: sizedboxValue,
              ),
              CustomButton(
                text: "작성하기",
                func: () async {
                  final userId = ref.read(userProvider.notifier).getUserId();
                  final model = WriteModel(
                    title: _titleController.text,
                    categoryDisplayName: "기타",
                    description: _descriptionController.text,
                    tags: _tagController.text,
                    price: int.parse(_pointController.text),
                  );
                  final id = await ref.read(ideaProvider.notifier).write(model: model, userId: userId, file: selectedFile);
                  if(id == null){
                    CustomDialog(context: context, title: "오류가 발생하였습니다.", OkText: "확인", func: (){context.pop();});
                    return;
                  }
                  context.goNamed(IdeaDetailScreen.routeName, pathParameters: {"id" : id.toString()});
                },
                borderRadius: 20,
                horizontalMargin: 0,
              ),
              const SizedBox(height: 40)
            ],
          ),
        ),
      ),
    );
  }

  Text titleText(String text) {
    return Text(
      text,
      style:
          PaperPlaneTS.medium(fontSize: 18, color: PaperPlaneColor.subColor4D),
    );
  }

  Text subTitleText(String text) {
    return Text(
      text,
      style:
          PaperPlaneTS.regular(fontSize: 14, color: PaperPlaneColor.subColor8A),
    );
  }

  GestureDetector categoryText(String text) {
    final isContain = categoryValues == text;
    return GestureDetector(
      onTap: () {
        setState(() {
          if (isContain) {
            categoryValues = '';
            return;
          }
          categoryValues = text;
        });
      },
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
        decoration: BoxDecoration(
          color: isContain
              ? PaperPlaneColor.mainColor.withOpacity(0.1)
              : PaperPlaneColor.greyColorF6,
          borderRadius: BorderRadius.circular(30),
        ),
        child: Text(
          text,
          style: PaperPlaneTS.regular(
            fontSize: 14,
            color: isContain
                ? PaperPlaneColor.subColor4D
                : PaperPlaneColor.greyColor66,
          ),
        ),
      ),
    );
  }
}

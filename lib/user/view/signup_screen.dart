import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:papar_plane/common/component/appbar.dart';
import 'package:papar_plane/common/component/button.dart';
import 'package:papar_plane/common/component/textformfield.dart';
import 'package:papar_plane/common/layout/default_layout.dart';
import 'package:papar_plane/common/variable/colors.dart';
import 'package:papar_plane/common/variable/textstyle.dart';
import 'package:papar_plane/common/view/root_tab.dart';
import 'package:papar_plane/main.dart';
import 'package:papar_plane/user/provider/user_provider.dart';
import 'package:papar_plane/user/repository/user_repository.dart';

class SignupScreen extends ConsumerStatefulWidget {
  static String get routeName => "signup";
  const SignupScreen({super.key});

  @override
  ConsumerState<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends ConsumerState<SignupScreen> {
  final _controller = TextEditingController(); // TextField
  bool? duplicateValue; // 중복검사
  
  
  @override
  Widget build(BuildContext context) {
    // textformfield의 배경색상 변수
    Color? fillColor = duplicateValue == true ? PaperPlaneColor.mainColor.withOpacity(0.1) : duplicateValue == false ? PaperPlaneColor.redColorEE.withOpacity(0.1) : null;
    return DefaultLayout(
      appBar: CustomAppBar.noActionAppBar(context, title: "회원가입"),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: ratio.height * 70),
            Text(
              "반가워요!\n닉네임을 정해주세요.",
              style: PaperPlaneTS.bold(
                fontSize: 24,
                color: PaperPlaneColor.subColor4D,
              ),
            ),
            nicknameRow(fillColor),
            Padding(
              padding: const EdgeInsets.only(left: 19),
              child: subText(),
            ),
            const Spacer(),
            CustomButton(
              horizontalMargin: 0,
              text: "다음으로",
              borderColor: (duplicateValue == null || !duplicateValue!) ? PaperPlaneColor.greyColorD3 : null,
              func: (duplicateValue == null || !duplicateValue!) ? null : buttonRouting,
              disabledBackgroundColor: PaperPlaneColor.greyColorD3,
              borderRadius: 20,
            ),
            SizedBox(height: ratio.height * 30),
          ],
        ),
      ),
    );
  }

  // 닉네임 입력 아래 subText
  Text subText(){
    String text = "이모지, 특수문자를 사용할 수 없습니다. (${_controller.text.length}/8)";
    if(duplicateValue == true){
      text = "사용 가능한 닉네임입니다.";
    }
    if(duplicateValue == false){
      text = "중복된 닉네임입니다.";
    }
    return Text(
      text,
      style: PaperPlaneTS.regular(
        fontSize: 14,
        color: PaperPlaneColor.greyColorA1,
      ),
    );
  }

  void buttonRouting() {
    //ref.read(userRepositoryProvider).login("qoN7dMvmxsvPPvU-g-Rlg_8Xg1x0DhRa8qui2tQJIfX1KqM_CwG8kwAAAAQKKiVSAAABk02jimAicpf3YNJZ6g");
    context.goNamed(RootTab.routeName);
  }

  // 닉네임 입력 및 중복 검사 버튼이 있는 Row
  Padding nicknameRow(Color? fillColor) {
    return Padding(
      padding: const EdgeInsets.only(top: 15, bottom: 5),
      child: Row(
        children: [
          Expanded(
            child: CustomTextFormField(
              maxLength: 8,
              fillColor: fillColor,
              controller: _controller,
              hintText: "닉네임을 입력해주세요",
              onChanged: (val) {
                setState(() {
                  duplicateValue = null;
                });
              },
              suffixIcon: suffixIcon(),
            ),
          ),
          const SizedBox(width: 5),
          GestureDetector(
            onTap: () {
              setState(() {
                if(_controller.text == "1234"){
                  duplicateValue = false;
                  return;
                }
                duplicateValue = true;
                //ref.read(userProvider.notifier).nicknameDuplicate(id: 0, nickname: _controller.text);
              });
            },
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 11),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: PaperPlaneColor.mainColor),
              ),
              child: Text(
                "중복확인",
                style: PaperPlaneTS.regular(
                  fontSize: 14,
                  color: PaperPlaneColor.mainColor,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // 회원가입 화면에서 사용되는 appbar
  AppBar signupAppBar() {
    return AppBar(
      backgroundColor: Colors.white,
      centerTitle: true,
      shape: Border(
        bottom: BorderSide(
          color: PaperPlaneColor.greyColorD3,
          width: 0.5,
        ),
      ),
      leading: IconButton(
        onPressed: () {
          context.pop();
        },
        icon: Icon(
          Icons.arrow_back,
          color: PaperPlaneColor.mainColor,
        ),
      ),
      title: Text(
        "회원가입",
        style: PaperPlaneTS.bold(
          fontSize: 20,
        ),
      ),
    );
  }

  // textformfield에 들어가는 Widget
  // 중복검사 여부에 따라 위젯이 달라짐
  Widget? suffixIcon(){
    if(duplicateValue == false){
      return Icon(Icons.cancel, color: PaperPlaneColor.redColorEE, size: 20,);
    }
    if(duplicateValue == true){
      return Icon(Icons.check_circle, color: PaperPlaneColor.mainColor, size: 20,);
    }
    return null;
  }
}

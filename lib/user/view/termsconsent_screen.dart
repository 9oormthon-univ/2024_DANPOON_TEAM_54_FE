import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:papar_plane/common/component/appbar.dart';
import 'package:papar_plane/common/component/button.dart';
import 'package:papar_plane/common/layout/default_layout.dart';
import 'package:papar_plane/common/variable/colors.dart';
import 'package:papar_plane/common/variable/textstyle.dart';
import 'package:papar_plane/main.dart';

class TermsConsentScreen extends StatefulWidget {
  TermsConsentScreen({super.key});

  @override
  State<TermsConsentScreen> createState() => _TermsConsentScreenState();
}

class _TermsConsentScreenState extends State<TermsConsentScreen> {
  bool isAllCheck = false;
  bool isTermsOfUse = false;
  bool isPersonalInformation = false;

  @override
  Widget build(BuildContext context) {
    return DefaultLayout(
      appBar: CustomAppBar.noActionAppBar(context, title: "회원가입"),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: ratio.height * 70,
            ),
            Text(
              "이용약관에 \n동의해주세요.",
              style: PaperPlaneTS.bold(
                  fontSize: 24, color: PaperPlaneColor.subColor4D),
            ),
            SizedBox(
              height: 15,
            ),
            Text(
              "정책 및 약관을 클릭해 모든 내용을 확인해주세요.",
              style: PaperPlaneTS.regular(fontSize: 14),
            ),
            SizedBox(
              height: 10,
            ),
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(30),
                color: PaperPlaneColor.greyColorF6,
              ),
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 15, horizontal: 25),
                child: Column(
                  children: [
                    GestureDetector(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Icon(
                            Icons.check_circle_rounded,
                            color: isAllCheck
                                ? PaperPlaneColor.mainColor
                                : PaperPlaneColor.greyColorA1,
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Text(
                            "전체동의",
                            style: PaperPlaneTS.bold(fontSize: 20),
                          ),
                        ],
                      ),
                      onTap: () {
                        setState(() {
                          isAllCheck = !isAllCheck;
                          isTermsOfUse = isAllCheck;
                          isPersonalInformation = isAllCheck;
                        });
                      },
                    ),
                    SizedBox(
                      height: 14,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        GestureDetector(
                          child: Icon(
                            Icons.check,
                            color: isTermsOfUse
                                ? PaperPlaneColor.mainColor
                                : PaperPlaneColor.greyColorA1,
                          ),
                          onTap: () {
                            setState(() {
                              isTermsOfUse = !isTermsOfUse;
                              if (isTermsOfUse == false) {
                                isAllCheck = false;
                              } else if (isPersonalInformation &&
                                  isTermsOfUse) {
                                isAllCheck = true;
                              }
                            });
                          },
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Text(
                          "이용약관 동의 (필수)",
                          style: PaperPlaneTS.regular(
                              fontSize: 16,
                              decoration: TextDecoration.underline),
                        )
                      ],
                    ),
                    SizedBox(
                      height: 14,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        GestureDetector(
                          child: Icon(
                            Icons.check,
                            color: isPersonalInformation
                                ? PaperPlaneColor.mainColor
                                : PaperPlaneColor.greyColorA1,
                          ),
                          onTap: () {
                            setState(() {
                              isPersonalInformation = !isPersonalInformation;
                              if (isPersonalInformation == false) {
                                isAllCheck = false;
                              } else if (isPersonalInformation &&
                                  isTermsOfUse) {
                                isAllCheck = true;
                              }
                            });
                          },
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Text(
                          "개인정보 수집 및 이용동의 (필수)",
                          style: PaperPlaneTS.regular(
                              fontSize: 16,
                              decoration: TextDecoration.underline),
                        )
                      ],
                    ),
                    SizedBox(
                      height: 14,
                    ),
                  ],
                ),
              ),
            ),
            Spacer(),
            CustomButton(
              horizontalMargin: 0,
              text: "시작하기",
              bgColor: PaperPlaneColor.mainColor,
              borderColor: isAllCheck ? null : PaperPlaneColor.greyColorD3,
              func: isAllCheck ? null : null,
              disabledBackgroundColor: isAllCheck
                  ? PaperPlaneColor.mainColor
                  : PaperPlaneColor.greyColorD3,
              borderRadius: 20,
            ),
            SizedBox(
              height: ratio.height * 30,
            ),
          ],
        ),
      ),
    );
  }
}

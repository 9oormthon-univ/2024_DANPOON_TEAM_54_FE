import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:papar_plane/common/variable/colors.dart';
import 'package:papar_plane/common/variable/textstyle.dart';

// TextField Widget
// 텍스트 입력을 받는 Widget
// 변수값이 많으며
// 입력받는 TextStyle -> fontsize : 16, fontWeight : w500, color : black
// hintText의 TextStyle -> fontsize : 16, fontWeight : w500, color: greyColor96
// 무조건 hintText와 controller를 변수로 넣어줘야합니다.
// 기본 배경색상 : whiteColorF6
class CustomTextFormField extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;
  final bool obsecure;
  final void Function(String)? onChanged;
  final String? Function(String?)? validator;
  final bool readOnly;
  final bool enabled;
  final Widget? suffixIcon;
  final Widget? prefixIcon;
  final int? maxLength;
  final List<TextInputFormatter>? inputFormatters;
  final bool expands;
  final int? maxLines;
  final double borderRadius;
  final TextStyle? style;
  final TextStyle? hintStyle;
  final Color? fillColor;
  final Color? borderColor;
  final EdgeInsets? contentPadding;
  final bool filled;
  final bool isDense;
  final TextAlign textAlign;
  final VoidCallback? onTap;
  const CustomTextFormField({
    required this.controller,
    required this.hintText,
    this.onTap,
    this.borderRadius = 50,
    this.onChanged,
    this.textAlign = TextAlign.start,
    this.enabled = true,
    this.readOnly = false,
    this.obsecure = false,
    this.expands = false,
    this.isDense = false,
    this.maxLines,
    this.validator,
    this.suffixIcon,
    this.prefixIcon,
    this.maxLength,
    this.inputFormatters,
    this.style,
    this.hintStyle,
    this.fillColor,
    this.borderColor,
    this.contentPadding,
    this.filled = true,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      onTap: onTap,
      maxLines: maxLines,
      expands: expands,
      inputFormatters: inputFormatters,
      maxLength: maxLength,
      readOnly: readOnly,
      enabled: enabled,
      obscureText: obsecure,
      textAlign: textAlign,
      validator: validator == null ? null : validator,
      textAlignVertical: TextAlignVertical.top,
      style: PaperPlaneTS.medium(fontSize: 16),
      onChanged: onChanged,
      controller: controller,
      decoration: InputDecoration(
        isDense: isDense,
        fillColor: fillColor ?? PaperPlaneColor.whiteColorF6,
        filled: filled,
        errorStyle: PaperPlaneTS.medium(fontSize: 12, color: Colors.red,),
        counterText: '',
        suffixIcon: suffixIcon,
        prefixIcon: prefixIcon,
        disabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(borderRadius),
          borderSide: BorderSide(
            color: borderColor ?? PaperPlaneColor.whiteColorF6,
          ),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(borderRadius),
          borderSide: BorderSide(
            color: Colors.red,
          ),
        ),
        errorBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.red)),
        contentPadding: contentPadding ?? const EdgeInsets.symmetric(vertical: 15, horizontal: 15),
        hintText: hintText,
        hintStyle: hintStyle ?? PaperPlaneTS.medium(
          fontSize: 16,
          color: PaperPlaneColor.greyColor96,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(borderRadius),
          borderSide: BorderSide(
            color: borderColor ?? PaperPlaneColor.whiteColorF6,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(borderRadius),
          borderSide: BorderSide(
            color: borderColor ?? PaperPlaneColor.whiteColorF6,
          ),
        ),
      ),
    );
  }
}

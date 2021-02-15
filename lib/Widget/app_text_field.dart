import 'dart:math';

import 'package:booktask/Constant/ColorConistant.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screen_scaler/flutter_screen_scaler.dart';

class AppTextField extends StatelessWidget {
  final String hintText;
  final TextEditingController controller;
  final FocusNode node;
  final FocusNode nextNode;
  final TextInputAction action;
  final TextInputType inputType;
  final bool password;
  final bool valid;

  AppTextField({
    @required this.hintText,
    @required this.controller,
    this.node,
    this.nextNode,
    this.password,
    this.action,
    this.valid,
    this.inputType,
  });

  @override
  Widget build(BuildContext context) {
    ScreenScaler _scaler = ScreenScaler()..init(context);

    var hint = hintText;
    hint = hint == null ? hintText : hint;

    return TextField(
      inputFormatters: inputType == TextInputType.name
          ? [
              new FilteringTextInputFormatter.allow(RegExp('[a-zA-Z ]')),
            ]
          :inputType == TextInputType.number?
      [
        new FilteringTextInputFormatter.allow(RegExp('[0-9]')),
      ]
          : null,
      controller: controller,

      focusNode: node == null ? null : node,
      onSubmitted: (data) {
        if (nextNode != null) FocusScope.of(context).requestFocus(nextNode);
      },
      obscureText: password != null && password,
      textInputAction: action == null ? TextInputAction.done : action,
      decoration: inputDecorationWithCurve(hint, _scaler),
      keyboardType: inputType == null ? TextInputType.text : inputType,
      textCapitalization: TextCapitalization.none,
      style: textFieldStyle(_scaler.getTextSize(11)),
    );
  }

  InputDecoration inputDecorationWithCurve(
      String fieldname, ScreenScaler scaler,
      {Widget suffix, Widget prefix}) {
    var name = fieldname;
    name = name == null ? fieldname : name;

    return InputDecoration(
      hintText: name,
      errorText: valid == null || valid ? null : "",
      errorMaxLines: 1,
      errorStyle: TextStyle(fontSize: 0, height: 0),
      isDense: false,
      suffixIcon: valid == null
          ? null
          : valid
              ? (Icon(
                  Icons.check_circle,
                  color: ColorConstants.green,
                ))
              : Transform.rotate(
                  angle: -pi / 4,
                  child: (Icon(
                    Icons.add_circle,
                    color: ColorConstants.red,
                  )),
                ),
      prefix: prefix == null ? null : prefix,
      filled: true,
      hintStyle: textMedium(ColorConstants.hintColor, scaler.getTextSize(10)),
      contentPadding: scaler.getPaddingLTRB(4, 1.3, 4, 1.3),
      fillColor: ColorConstants.textFieldBg,
      enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: ColorConstants.grey, width: 1),
          borderRadius: BorderRadius.all(Radius.circular(12))),
      disabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: ColorConstants.grey, width: 1),
          borderRadius: BorderRadius.all(Radius.circular(12))),
      focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: ColorConstants.green, width: 1),
          borderRadius: BorderRadius.all(Radius.circular(12))),
      errorBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.red, width: 1),
          borderRadius: BorderRadius.all(Radius.circular(12))),
      focusedErrorBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.red, width: 1),
          borderRadius: BorderRadius.all(Radius.circular(12))),
    );
  }

  static TextStyle textFieldStyle(double size) {
    return TextStyle(
        color: ColorConstants.textColorDark,
        fontWeight: FontWeight.w600,
        fontSize: size);
  }

  static TextStyle textMedium(Color color, double textSize, {bool underline}) {
    return TextStyle(
        color: color,
        fontWeight: FontWeight.w500,
        fontSize: textSize,
        decoration: underline != null ? TextDecoration.underline : null);
  }
}
class AppTextFieldView extends StatelessWidget {
  final String hintText;
  final Function onTap;
  final FocusNode node;
  final FocusNode nextNode;
  final TextInputAction action;
  final TextInputType inputType;
  final bool password;
  final bool valid;

  AppTextFieldView({
    @required this.hintText,
    @required this.onTap,
    this.node,
    this.nextNode,
    this.password,
    this.action,
    this.valid,
    this.inputType,
  });

  @override
  Widget build(BuildContext context) {
    ScreenScaler _scaler = ScreenScaler()..init(context);

    var hint = hintText;
    hint = hint == null ? hintText : hint;

    return TextField(
      inputFormatters: inputType == TextInputType.name
          ? [
        new FilteringTextInputFormatter.allow(RegExp('[a-zA-Z ]')),
      ]
          :inputType == TextInputType.number?
      [
        new FilteringTextInputFormatter.allow(RegExp('[0-9]')),
      ]
          : null,
      enabled: false,
      onTap: onTap,



      focusNode: node == null ? null : node,
      onSubmitted: (data) {
        if (nextNode != null) FocusScope.of(context).requestFocus(nextNode);
      },
      obscureText: password != null && password,
      textInputAction: action == null ? TextInputAction.done : action,
      decoration: inputDecorationWithCurve(hint, _scaler),
      keyboardType: inputType == null ? TextInputType.text : inputType,
      textCapitalization: TextCapitalization.none,
      style: textFieldStyle(_scaler.getTextSize(11)),

    );
  }

  InputDecoration inputDecorationWithCurve(

      String fieldname, ScreenScaler scaler,
      {Widget suffix, Widget prefix}) {
    var name = fieldname;
    name = name == null ? fieldname : name;

    return InputDecoration(
      hintText: name,
      errorText: valid == null || valid ? null : "",
      errorMaxLines: 1,
      errorStyle: TextStyle(fontSize: 0, height: 0),
      isDense: false,
      suffixIcon: valid == null
          ? null
          : valid
          ? (Icon(
        Icons.check_circle,
        color: ColorConstants.green,
      ))
          : Transform.rotate(
        angle: -pi / 4,
        child: (Icon(
          Icons.add_circle,
          color: ColorConstants.red,
        )),
      ),
      prefix: prefix == null ? null : prefix,
      filled: true,
      hintStyle: textMedium(ColorConstants.hintColor, scaler.getTextSize(10)),
      contentPadding: scaler.getPaddingLTRB(4, 1.3, 4, 1.3),
      fillColor: ColorConstants.textFieldBg,
      enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: ColorConstants.grey, width: 1),
          borderRadius: BorderRadius.all(Radius.circular(12))),
      disabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: ColorConstants.grey, width: 1),
          borderRadius: BorderRadius.all(Radius.circular(12))),
      focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: ColorConstants.green, width: 1),
          borderRadius: BorderRadius.all(Radius.circular(12))),
      errorBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.red, width: 1),
          borderRadius: BorderRadius.all(Radius.circular(12))),
      focusedErrorBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.red, width: 1),
          borderRadius: BorderRadius.all(Radius.circular(12))),
    );
  }

  static TextStyle textFieldStyle(double size) {
    return TextStyle(
        color: ColorConstants.textColorDark,
        fontWeight: FontWeight.w600,
        fontSize: size);
  }

  static TextStyle textMedium(Color color, double textSize, {bool underline}) {
    return TextStyle(
        color: color,
        fontWeight: FontWeight.w500,
        fontSize: textSize,
        decoration: underline != null ? TextDecoration.underline : null);
  }
}

import 'package:booktask/Constant/ColorConistant.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_screen_scaler/flutter_screen_scaler.dart';

enum AppTextStyle { title, medium, regular, small }

class AppText extends StatelessWidget {
  final String text;
  final dynamic color;
  final bool capitalise;
  final bool align;
  bool ellipsis;

  final AppTextStyle style;
  final dynamic size;

  AppText({
    @required this.text,
    this.color,
    this.style,
    this.align,
    this.capitalise,
    this.size,
    this.ellipsis =true
  });

  @override
  Widget build(BuildContext context) {
    ScreenScaler _scaler = ScreenScaler()..init(context);

    var data = text;

    data = data == null ? text : data;

    return Text(
      capitalise == null || !capitalise ? data : data.toUpperCase(),
      textAlign: align == null || !align ? null : TextAlign.center,
      overflow: ellipsis== true? TextOverflow.ellipsis: TextOverflow.fade,
      style: getStyle(
        color == null ? ColorConstants.textColorDark : color,
        size == null ? getTextSize(_scaler) : size,
      ),
    );
  }

  TextStyle getStyle(Color color, double textSize, {bool underline}) {
    return TextStyle(
        color: color,
        fontWeight: getWeight(),
        fontSize: textSize,
        decoration: underline != null ? TextDecoration.underline : null);
  }

  getTextSize(ScreenScaler scaler) {
    switch (style) {
      case AppTextStyle.title:
        return scaler.getTextSize(14);
        break;

      case AppTextStyle.medium:
        return scaler.getTextSize(11);
        break;

      case AppTextStyle.small:
        return scaler.getTextSize(10);
        break;

      default:
        return scaler.getTextSize(10);
    }
  }

  getWeight() {
    switch (style) {
      case AppTextStyle.title:
        return FontWeight.w900;
        break;

      case AppTextStyle.medium:
        return FontWeight.w700;
        break;

      case AppTextStyle.small:
        return FontWeight.w300;
        break;

      default:
        return FontWeight.w500;
    }
  }
}

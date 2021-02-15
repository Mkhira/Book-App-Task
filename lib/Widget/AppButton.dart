




import 'package:booktask/Constant/ColorConistant.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screen_scaler/flutter_screen_scaler.dart';

class AppButton extends StatefulWidget {
  AppButton({this.enabled, this.onPressed, this.text,this.height =6,this.width=50});
final bool enabled;
final Function onPressed;
final String text;
 double width;
 double height;

  @override
  _AppButtonState createState() => _AppButtonState();
}

class _AppButtonState extends State<AppButton> {
  @override
  Widget build(BuildContext context) {
    ScreenScaler scaler = ScreenScaler()..init(context);

    return Container(
      width: scaler.getWidth(widget.width),
      child: MaterialButton(

        height:  scaler.getHeight(widget.height),
        onPressed: widget.enabled ?  widget.onPressed :(){},

        color:  widget.enabled? ColorConstants.darkBlueColor: ColorConstants.grey,
        child: Text("${widget.text}",style: TextStyle(color: widget.enabled? ColorConstants.grey :ColorConstants.darkBlueColor),),
        elevation:  widget.enabled? 4:0,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8)
        ),
      ),
    );
  }
}

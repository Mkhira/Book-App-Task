


import 'package:booktask/Constant/ColorConistant.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screen_scaler/flutter_screen_scaler.dart';

import 'app_text.dart';

class BookCard extends StatelessWidget {
  const BookCard({
    Key key,
    @required this.isPortrait,
    @required this.scaler,
    this.amount,
    this.name,
    this.image,
    this.onTap,
  }) : super(key: key);

  final bool isPortrait;
  final ScreenScaler scaler;
  final Function onTap;
  final String name;
  final int amount;
  final String image;


  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Card(
        elevation: 3,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10)
        ),
        child: Container(
          // width: isPortrait ? scaler.getWidth(37):scaler.getWidth(22),
          // height:isPortrait ? scaler.getHeight(32):scaler.getHeight(70),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10)
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Container(
                width: isPortrait ? scaler.getWidth(45):scaler.getWidth(22),
                height:isPortrait ? scaler.getHeight(25):scaler.getHeight(52),


                child: ClipRRect(
                  child: Image(image: AssetImage("$image"),
                    fit: BoxFit.fill,
                  ),
                  borderRadius: BorderRadius.only(topLeft: Radius.circular(10),topRight: Radius.circular(10)),
                ),
              ),
              SizedBox(height: scaler.getHeight(1),),
              Container(
                width: isPortrait ? scaler.getWidth(42):scaler.getWidth(22),
                child: Padding(
                  padding: scaler.getPaddingLTRB(.5, 0, 0, 0),
                  child: AppText(text: "$name",
                    color: ColorConstants.darkBlueColor,
                  ),
                ),

              ),
              SizedBox(height: scaler.getHeight(1),),

              Container(
                width: isPortrait ? scaler.getWidth(36):scaler.getWidth(22),
                child: Padding(
                  padding: scaler.getPaddingLTRB(.5,0,0,0),
                  child: Row(
                    children: [
                      AppText(text: "Amount: ",color: ColorConstants.darkBlueColor,),
                      AppText(text: "$amount",color: Colors.black,),
                    ],
                  ),
                ),

              ),




            ],
          ),
        ),
      ),
    );
  }
}





import 'package:booktask/Constant/ColorConistant.dart';
import 'package:booktask/Models/BookModel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screen_scaler/flutter_screen_scaler.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'AppButton.dart';
import 'app_text.dart';

class Sheet extends StatefulWidget {
  Sheet({this.scaler,this.context,this.author,this.name,this.amount,this.myKey,this.brief,this.image});
  final BuildContext context;
  final String name;
  final String brief;
  final String image;
  final String author;
  final ScreenScaler scaler;
  final int amount;
  final int myKey;
  @override
  _SheetState createState() => _SheetState();
}
String bookModelName = "bookModelName";

class _SheetState extends State<Sheet> {
  double value =0;
  Box<BookModel> bookModelBox;

  @override
  void initState() {
    // TODO: implement initState
    bookModelBox  =Hive.box<BookModel>(bookModelName);

    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    var isPortrait = MediaQuery.of(context).orientation == Orientation.portrait;
    return Container(
      height: widget.scaler.getHeight(50),
      child: SingleChildScrollView(
        child: Column(children: [
          SizedBox(height: widget.scaler.getHeight(2),),

          Align(
            alignment: Alignment.bottomCenter,
            child: ClipRRect(
                borderRadius: BorderRadius.only(topLeft: Radius.circular(10),topRight: Radius.circular(10)),
                child: Image(image: AssetImage("${widget.image}"),height:isPortrait?  widget.scaler.getHeight(18):widget.scaler.getWidth(20) ,)),
          ),
          SizedBox(height: widget.scaler.getHeight(2),),
          Padding(
            padding: widget.scaler.getPaddingLTRB(2, 2, 2, 0),
            child: Align(
              alignment: Alignment.topLeft,
              child: AppText(text: "${widget.name}",
                ellipsis: false,
                color: ColorConstants.darkBlueColor,
                style: AppTextStyle.medium,
              ),
            ),
          ),
          Padding(
            padding: widget.scaler.getPaddingLTRB(2, 1, 2, 0),
            child: Align(
              alignment: Alignment.topLeft,
              child: AppText(text: "${widget.author}",
                ellipsis: false,
                color: ColorConstants.darkBlueColor,
                style: AppTextStyle.regular,
              ),
            ),
          ),
          Padding(
            padding: widget.scaler.getPaddingLTRB(2, 1, 2, 0),
            child: Align(
                alignment: Alignment.topLeft,
                child:
                ValueListenableBuilder(
                  valueListenable: bookModelBox.listenable(),
                builder: (context,Box<BookModel> box,_) {
                  return                 Slider(
                    onChanged: (val){
                      setState(() {
                        value = val;
                      });
                    },
                    value: value,
                    max: double.parse("${box.get(widget.myKey).amount}"),
                    min: 0,
                  );
                }
          )
            ),
          ),

          Center(
            child: Container(
              width: widget.scaler.getWidth(50),
              child: Center(child: AppText(text: "${value.toInt()}",color: ColorConstants.darkBlueColor,style: AppTextStyle.title,)),
            ),
          ),
          SizedBox(height: widget.scaler.getHeight(2),),
          Center(
              child:AppButton(height: 6,width: 50,text: "Request book",enabled: true,
                onPressed: (){
                  setState(() {
                    print("${widget.amount - value.toInt()}");
                    BookModel bookModel = BookModel(
                        brief: widget.brief,
                        image: widget.image,
                        amount: (widget.amount - value.toInt()),
                        author: widget.author,
                        name: widget.name
                    );
                    print(widget.myKey);
                    bookModelBox.put(widget.myKey, bookModel).whenComplete((){
                      Navigator.pop(context);
                    });
                  });
                },)
          )



        ],),
      ),
    );
  }
}

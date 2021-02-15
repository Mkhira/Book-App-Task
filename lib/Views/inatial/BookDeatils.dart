

import 'package:booktask/Constant/ColorConistant.dart';
import 'package:booktask/Models/BookModel.dart';
import 'package:booktask/Widget/AppButton.dart';
import 'package:booktask/Widget/BottomSheet.dart';
import 'package:booktask/Widget/ShakeTransition.dart';
import 'package:booktask/Widget/app_text.dart';
import 'package:booktask/Widget/app_text_field.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screen_scaler/flutter_screen_scaler.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:shared_preferences/shared_preferences.dart';

class BookDetails extends StatefulWidget {
   BookDetails({this.name,this.amount,this.image,this.brief,this.author,this.index});
   final String name;
   final String author;
   final String brief;
   final String image;
   final int index;
   final int amount;

  @override
  _BookDetailsState createState() => _BookDetailsState();
}
String bookModelName = "bookModelName";

class _BookDetailsState extends State<BookDetails> {

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
    ScreenScaler scaler = ScreenScaler()..init(context);
    return SafeArea(child: Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: ColorConstants.darkBlueColor,
        title: AppText(
          text: "${widget.name}",
          color: ColorConstants.grey,
        ),
      ),

      body: SingleChildScrollView(
        child: Column(
         children: [
           SizedBox(height: scaler.getHeight(1),),
           Align(
             alignment: Alignment.center,
             child: Container(
               height: scaler.getHeight(1),
               width: scaler.getWidth(20),
               decoration: BoxDecoration(borderRadius: BorderRadius.circular(20),
               color: ColorConstants.darkBlueColor
               ),
             ),
           ),
           SizedBox(height: scaler.getHeight(2),),
           Padding(
             padding: scaler.getPaddingLTRB(2, 2, 2, 0),
             child: ShakeTransition(

               duration: Duration(milliseconds: 2000),
               axis: Axis.vertical,

               child: Align(
                 alignment: Alignment.topLeft,
                 child: AppText(text: "${widget.name}",
                 ellipsis: false,
                 color: ColorConstants.darkBlueColor,
                   style: AppTextStyle.medium,
                 ),
               ),
             ),
           ),
           Padding(
             padding: scaler.getPaddingLTRB(2, 1, 2, 0),
             child: ShakeTransition(

               duration: Duration(milliseconds: 2000),
               axis: Axis.vertical,

               child: Align(
                 alignment: Alignment.topLeft,
                 child: AppText(text: "${widget.author}",
                 ellipsis: false,
                 color: ColorConstants.darkBlueColor,
                   style: AppTextStyle.regular,
                 ),
               ),
             ),
           ),
           SizedBox(height: scaler.getHeight(2),),
           Container(
             height: isPortrait? scaler.getHeight(35): scaler.getWidth(35),
             width: scaler.getWidth(100),
             child: Stack(
               children: [
                 Positioned(
                   right: 0,
                   bottom: isPortrait? scaler.getHeight(5) : scaler.getWidth(4),
                   child: Container(
                     width: scaler.getWidth(85),
                     height: isPortrait?  scaler.getHeight(25):scaler.getWidth(25) ,
                     decoration: BoxDecoration(
                       color: ColorConstants.grey,
                       borderRadius: BorderRadius.only(topLeft: Radius.circular(20),bottomLeft: Radius.circular(20))
                      ),
                     child: ShakeTransition(
                       duration: Duration(milliseconds: 2000),
                       axis: Axis.horizontal,
                       child: Align(
                         alignment: Alignment.bottomCenter,
                         child: ClipRRect(
                             borderRadius: BorderRadius.only(topLeft: Radius.circular(10),topRight: Radius.circular(10)),
                             child: Image(image: AssetImage("${widget.image}"),height:isPortrait?  scaler.getHeight(23):scaler.getWidth(23) ,)),
                       ),
                     ),

                   ),
                 ),
                 Positioned(
                   right: isPortrait ? scaler.getWidth(5):scaler.getHeight(5),
                   bottom:isPortrait ? scaler.getHeight(2): scaler.getWidth(2),
                   child: ValueListenableBuilder(
                     valueListenable: bookModelBox.listenable(),
                     builder: (context,Box<BookModel> box,_){
                       return  ShakeTransition(
                         duration: Duration(milliseconds: 2000),

                         child: AppButton(
                           enabled: true,
                           height: isPortrait ? 6:10,
                           width: 40,
                           onPressed: (){
                             if(widget.amount !=0 && box.get(widget.index).amount !=0){
                               showBottomSheet(name: widget.name,author: widget.author,context: context,scaler: scaler,amount: widget.amount,myKey: widget.index,image: widget.image,brief: widget.brief);
                             }else{
                               onCustomAnimationAlertPressed(context);
                             }

                           },
                           text: "Borrow the book",
                         ),
                       );
                     },
                   )
                 )
               ],
             ),
           ),
           Padding(
             padding: scaler.getPaddingLTRB(2, 1, 2, 0),
             child: ShakeTransition(

               duration: Duration(milliseconds: 2000),
               axis: Axis.vertical,

               child: Align(
                 alignment: Alignment.topLeft,
                 child: Container(
                   width: isPortrait? scaler.getWidth(80) : scaler.getHeight(80),
                   child: Row(
                     children: [
                       AppText(text: "Amount: ",color: ColorConstants.darkBlueColor,style: AppTextStyle.medium,),
                       ValueListenableBuilder(valueListenable: bookModelBox.listenable(), builder: (context,Box<BookModel> box,_){
                         return                     AppText(text: "${box.get(widget.index).amount}",style: AppTextStyle.regular,color: Colors.black,);
                       })
                     ],
                   ),
                 ),
               ),
             ),
           ),

           SizedBox(height: scaler.getHeight(2),),
           Padding(
             padding: scaler.getPaddingLTRB(2, 1, 2, 0),
             child: ShakeTransition(

               duration: Duration(milliseconds: 2000),
               axis: Axis.vertical,

               child: Align(
                 alignment: Alignment.topLeft,
                 child: AppText(text: "Brief:",
                   ellipsis: false,
                   color: ColorConstants.darkBlueColor,
                   style: AppTextStyle.medium,
                 ),
               ),
             ),
           ),

           Padding(
             padding: scaler.getPaddingLTRB(2, 2, 2, 0),
             child: ShakeTransition(

               duration: Duration(milliseconds: 2000),
               axis: Axis.vertical,

               child: Align(
                 alignment: Alignment.topLeft,
                   child: AppText( text: "${widget.brief}",
                   ellipsis: false,
                   align: false,
                   color: ColorConstants.darkBlueColor,
                   style: AppTextStyle.medium,
                 ),
               ),
             ),
           ),

          SizedBox(height: scaler.getHeight(5),)



         ],
        ),
      ),
    ));
  }
}


showBottomSheet({BuildContext context , String name , String author , ScreenScaler scaler , int amount, int myKey, String brief,String image}){
  showModalBottomSheet(context: context, builder: (BuildContext context){
    double value =1;
    return Sheet(author: author,name: name,scaler: scaler,context: context,amount: amount,myKey: myKey,brief: brief,image: image,);
  });
}

onCustomAnimationAlertPressed(context) {
  Alert(
    context: context,
    title: "We are Sorry",
    desc: "There's no books available soon we will get this book.",
  ).show();
}



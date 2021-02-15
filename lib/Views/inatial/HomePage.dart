import 'package:booktask/Constant/ColorConistant.dart';
import 'package:booktask/Constant/RoutesConstants.dart';
import 'package:booktask/Models/BookModel.dart';
import 'package:booktask/Navigation/Navigation.dart';
import 'package:booktask/Views/inatial/BookDeatils.dart';
import 'package:booktask/Widget/AppButton.dart';
import 'package:booktask/Widget/BookCard.dart';
import 'package:booktask/Widget/app_text.dart';
import 'package:booktask/helpers/Util.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screen_scaler/flutter_screen_scaler.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomePage extends StatefulWidget {
  HomePage();

  @override
  _HomePageState createState() => _HomePageState();
}
String bookModelName = "bookModelName";

class _HomePageState extends State<HomePage> {
  Box<BookModel> bookModelBox;

 @override
  void initState() {
    // TODO: implement initState
    bookModelBox  =Hive.box<BookModel>(bookModelName);
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    final double itemHeight = (size.height - kToolbarHeight - 24) / 2.2;
    final double itemWidth = size.width / 2;
    ScreenScaler scaler = ScreenScaler()..init(context);
    var isPortrait = MediaQuery.of(context).orientation == Orientation.portrait;

    return SafeArea(child: Scaffold(
      appBar: AppBar(
        backgroundColor: ColorConstants.grey,
        title: AppButton(text: "Logout",height: 5,
        width: 30,
        onPressed: ()async{

          SharedPreferences isLogedIn =
              await SharedPreferences.getInstance();
          isLogedIn.setBool(Common.isLogin, false);
          Navigator.of(context).pushReplacementNamed(RoutesConstants.signIn);

        },
          enabled: true,
        ),

      ),
      body: Padding(
        padding: scaler.getPaddingAll(4),
        child: ValueListenableBuilder(
          valueListenable: bookModelBox.listenable(),
          builder: (context,Box<BookModel> box,_){
            List<int> keys = box.keys.cast<int>().toList();
            return  AnimationLimiter(
              child: GridView.count(
                childAspectRatio:isPortrait?itemWidth / itemHeight:3/4.7,
                crossAxisCount: isPortrait? 2 :4,
                padding: scaler.getPaddingAll(4),
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,

                shrinkWrap: true,
                children: List.generate(
                  keys.length,
                      (int index) {
                    final int key =keys[index];
                    final BookModel bookModel  = box.get(key);
                    return AnimationConfiguration.staggeredGrid(

                      position: index,
                      duration: const Duration(milliseconds: 1000),
                      columnCount: isPortrait? 2 :4,
                      child: ScaleAnimation(
                        child: FadeInAnimation(
                          child: BookCard(isPortrait: isPortrait,scaler: scaler,
                            image: bookModel.image,
                            amount: bookModel.amount,
                            name: bookModel.name,
                            onTap: (){
                            Navigator.push(context, PageNavigationNoRout(child: BookDetails(
                              name: bookModel.name,
                              amount: bookModel.amount,
                              image: bookModel.image,
                              author: bookModel.author,
                              brief: bookModel.brief,
                              index: key,
                            )));
                          },),

                        ),
                      ),
                    );
                  },
                ),
              ),
            );
          },
        )
      )

    ));
  }
}


import 'package:booktask/Models/BookModel.dart';
import 'package:booktask/Models/UserModel.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';

import 'Constant/RoutesConstants.dart';
import 'Router.dart';
import 'package:hive/hive.dart';
const String userModelName = "userModelName";
const String bookModelName = "bookModelName";
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final document = await getApplicationDocumentsDirectory();
  Hive.init(document.path);
  Hive.registerAdapter(UserModelAdapter());
  Hive.registerAdapter(BookModelAdapter());
 await Hive.openBox<UserModel>(userModelName);
 await Hive.openBox<BookModel>(bookModelName);
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
          primarySwatch: Colors.blue,

        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      initialRoute: RoutesConstants.splash,
      onGenerateRoute: PageRouter.generateRoute,
    );
  }
}



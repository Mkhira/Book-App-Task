import 'dart:async';

import 'package:booktask/Constant/RoutesConstants.dart';
import 'package:booktask/Widget/app_text.dart';
import 'package:booktask/helpers/Util.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screen_scaler/flutter_screen_scaler.dart';

class Splash extends StatefulWidget {
  @override
  _SplashState createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  @override
  void initState() {
    // TODO: implement initState
    // provider.initialize();
    startTime();
    super.initState();
  }
  @override
  void dispose() {
    // TODO: implement dispose

    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    ScreenScaler _scaler = ScreenScaler()..init(context);
    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        width: _scaler.getWidth(100),
        height: _scaler.getHeight(100),
        child: Column(
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              height: _scaler.getHeight(8),
            ),
            AppText(
              text: "Welcome",
              style: AppTextStyle.title,
            ),
            SizedBox(
              height: _scaler.getHeight(35),
            ),
            AppText(
              text: "Book App Task",
              style: AppTextStyle.medium,
            ),
          ],
        ),
      ),
    );
  }

  startTime() async {
    var _duration = new Duration(seconds: 3);
    WidgetsFlutterBinding.ensureInitialized();
    return new Timer(_duration, navigationPage);
  }
  Future<void> navigationPage() async {
//     if (AuthRepository.authRepository.isLogin()) {
// // check if all initial steps are completed or not, and take appropriate step
//       await AuthRepository.authRepository.getUserDetail();
//       await AuthRepository.authRepository.getPlanTime();
//       print(AuthRepository.authRepository.userModel.email);
//       var currentStep = AuthRepository.authRepository.userModel.completedSteps;
//       if (currentStep == 8){
//         WidgetsFlutterBinding.ensureInitialized();
//         Navigator.of(context).popAndPushNamed(
//           RoutesConstants.navigation_home,
//         );}
//       else
//         Navigator.of(context).popAndPushNamed(
//           RoutesConstants.step_main,
//         );
//     } else
//

    bool status = await Common.getIsLogin();
    if(status == true){
    Navigator.of(context).popAndPushNamed(RoutesConstants.homePage);
  }else{
      Navigator.of(context).popAndPushNamed(RoutesConstants.signIn);

    }
}
}





import 'package:booktask/Constant/ColorConistant.dart';
import 'package:booktask/Constant/RoutesConstants.dart';
import 'package:booktask/Models/UserModel.dart';
import 'package:booktask/Widget/AppButton.dart';
import 'package:booktask/Widget/app_text.dart';
import 'package:booktask/Widget/app_text_field.dart';
import 'package:booktask/helpers/Util.dart';
import 'package:booktask/helpers/validations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screen_scaler/flutter_screen_scaler.dart';
import 'package:hive/hive.dart';
import 'package:lottie/lottie.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SignIn extends StatefulWidget {
  @override
  _SignInState createState() => _SignInState();
}
String userModelName = "userModelName";
class _SignInState extends State<SignIn> {
  ScreenScaler scaler;
  var nodes = List<FocusNode>();
  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  bool isEmailValid = null;
  bool isPasswordValid = null;
  bool animation = false;

  String errorText = "";
  Box<UserModel> userModelBox;

  @override
  void initState() {
    userModelBox  =Hive.box<UserModel>(userModelName);
    nodes.add(FocusNode());
    nodes.add(FocusNode());

    nodes[0].addListener(() {
      if (!nodes[0].hasFocus)
        validateEmail();
      else if (emailController.text.toString().isNotEmpty) {
        emailController.addListener(() {
          validateEmail();
        });
      }
    });

    nodes[1].addListener(() {
      if (!nodes[1].hasFocus)
        validatePassword();
      else if (passwordController.text.toString().isNotEmpty) {
        passwordController.addListener(() {
          passwordController.removeListener(() {});
          validatePassword();
        });
      } else {
        passwordController.addListener(() {
          if (isPasswordValid != null && isPasswordValid) validatePassword();

          if (passwordController.text.toString().length >= 6)
            setState(() {
              isPasswordValid = true;
            });
        });
      }
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    if (scaler == null) scaler = ScreenScaler()..init(context);

    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Stack(
          children: [
            Center(
              child: SingleChildScrollView(
                physics: BouncingScrollPhysics(),
                child: Container(
                  margin: scaler.getMargin(0, 4),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      AppText(
                        text: "Sign in",
                        style: AppTextStyle.title,
                      ),
                      SizedBox(
                        height: scaler.getHeight(1),
                      ),
                      AppText(
                        text: "Welcome back",
                        style: AppTextStyle.regular,
                        size: scaler.getTextSize(11),
                      ),
                      SizedBox(
                        height: scaler.getHeight(2),
                      ),
                      AppTextField(
                        hintText: 'Email',
                        inputType: TextInputType.emailAddress,
                        action: TextInputAction.next,
                        controller: emailController,
                        password: false,
                        valid: isEmailValid,
                        node: nodes[0],
                        nextNode: nodes[1],
                      ),
                      SizedBox(
                        height: scaler.getHeight(3),
                      ),
                      AppTextField(
                        hintText: "Password",
                        action: TextInputAction.done,
                        controller: passwordController,
                        password: true,
                        valid: isPasswordValid,
                        node: nodes[1],
                      ),
                      SizedBox(
                        height: scaler.getHeight(3),
                      ),
                      Align(
                        alignment: Alignment.center,
                        child: AppButton(
                          onPressed: ()async{
                            userModelBox.get(0);
                            print('${userModelBox.get(0).email}');
                            print('${userModelBox.get(0).password}');
                            for(int x=0; x < userModelBox.length ;x++ ){
                              if(emailController.text == userModelBox.get(x).email && passwordController.text == userModelBox.get(x).password){

                                SharedPreferences isLogedIn =
                                    await SharedPreferences.getInstance();
                                isLogedIn.setBool(Common.isLogin, true);
                                SharedPreferences nameshared =
                                    await SharedPreferences.getInstance();
                                nameshared.setString(Common.name, userModelBox.get(x).name);
                                Navigator.of(context).pushReplacementNamed(RoutesConstants.homePage);

                              }else{
                                errorText = "Email or password is wrong";
                              }
                            }

                          },
                          text: "Sign in",
                          enabled: (isEmailValid != null && isEmailValid) &&
                              (isPasswordValid != null && isPasswordValid),
                        ),
                      ),
                      SizedBox(
                        height: scaler.getHeight(1),
                      ),
                      AppText(
                        text: errorText,
                        color: ColorConstants.red,
                      ),
                      SizedBox(
                        height: scaler.getHeight(1),
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.of(context)
                              .popAndPushNamed(RoutesConstants.signUp);
                        },
                        child: Container(
                            padding: scaler.getPadding(1, 1),
                            alignment: Alignment.centerRight,
                            child: AppText(
                              text: "New user",
                              style: AppTextStyle.medium,

                              color: ColorConstants.darkBlueColor,
                            )),
                      ),
                      SizedBox(
                        height: scaler.getHeight(2),
                      ),
                    ],
                  ),
                ),
              ),
            ),

            animation == true?  Positioned(
              child: Container(
                  color: ColorConstants.grey.withOpacity(.5),
                  child: Center(child: Lottie.asset('animations/loader.json'))),
            ): Container(),
          ],
        ),
      ),
    );
  }


  validateEmail() {
    setState(() {
      isEmailValid =
          Validations.emailValidation(emailController.text.toString());

      errorText = !isEmailValid ? "Invalid email" : "";
    });
  }

  validatePassword() {
    setState(() {
      isPasswordValid =
          Validations.passwordValidation(passwordController.text.toString());
      errorText = !isPasswordValid ? "Invalid password" : "";
    });
  }
}

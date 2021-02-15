
import 'package:booktask/Constant/ColorConistant.dart';
import 'package:booktask/Constant/RoutesConstants.dart';
import 'package:booktask/Models/BookModel.dart';
import 'package:booktask/Models/UserModel.dart';
import 'package:booktask/Widget/AppButton.dart';
import 'package:booktask/Widget/app_text.dart';
import 'package:booktask/Widget/app_text_field.dart';
import 'package:booktask/helpers/CreateBookDataBase.dart';
import 'package:booktask/helpers/Util.dart';
import 'package:booktask/helpers/validations.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screen_scaler/flutter_screen_scaler.dart';
import 'package:hive/hive.dart';
import 'package:lottie/lottie.dart';
import 'package:shared_preferences/shared_preferences.dart';
class SignUp extends StatefulWidget {
  @override
  _SignUpState createState() => _SignUpState();
}

String bookModelName = "bookModelName";
String userModelName = "userModelName";

class _SignUpState extends State<SignUp> {

  ScreenScaler scaler;
  var nodes = List<FocusNode>();
  var nameController = TextEditingController();
  var emailController = TextEditingController();
  var passwordController = TextEditingController();

  bool isNameValid = null;
  bool isEmailValid = null;
  bool isPasswordValid = null;
  bool animation = false;
  String errorText = "";
  String errorEmail = "";

  Box<UserModel> userModelBox;
  Box<BookModel> bookModelBox;


  @override
  void initState() {
    userModelBox  =Hive.box<UserModel>(userModelName);
    bookModelBox  =Hive.box<BookModel>(bookModelName);
    nodes.add(FocusNode());
    nodes.add(FocusNode());
    nodes.add(FocusNode());

    nodes[0].addListener(() {
      if (!nodes[0].hasFocus)
        validateName();
      else if (nameController.text.toString().isNotEmpty) {
        nameController.addListener(() {
          validateName();
        });
      }
    });

    nodes[1].addListener(() {
      if (!nodes[1].hasFocus)
        validateEmail();
      else if (emailController.text.toString().isNotEmpty) {
        emailController.addListener(() {
          validateEmail();
        });
      }
    });

    nodes[2].addListener(() {
      if (!nodes[2].hasFocus)
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
                          text: "Get started",
                          style: AppTextStyle.title,
                        ),
                        SizedBox(
                          height: scaler.getHeight(2),
                        ),
                        AppText(
                          text:"Sign up now",
                          style: AppTextStyle.regular,
                          size: scaler.getTextSize(11),
                        ),
                        SizedBox(
                          height: scaler.getHeight(3),
                        ),
                        AppTextField(
                          hintText: "Name",
                          inputType: TextInputType.name,
                          action: TextInputAction.next,
                          controller: nameController,
                          node: nodes[0],
                          password: false,
                          nextNode: nodes[1],
                          valid: isNameValid,
                        ),
                        SizedBox(
                          height: scaler.getHeight(3),
                        ),
                        AppTextField(
                          node: nodes[1],
                          nextNode: nodes[2],
                          hintText: "Email",
                          inputType: TextInputType.emailAddress,
                          action: TextInputAction.next,
                          controller: emailController,
                          password: false,
                          valid: isEmailValid,
                        ),
                        SizedBox(
                          height: scaler.getHeight(3),
                        ),
                        AppTextField(
                          node: nodes[2],
                          hintText: "Password",
                          action: TextInputAction.done,
                          controller: passwordController,
                          password: true,
                          valid: isPasswordValid,
                        ),
                        SizedBox(
                          height: scaler.getHeight(3),
                        ),
                        GestureDetector(
                          onTap: () {

                            Navigator.of(context)
                                .popAndPushNamed(RoutesConstants.signIn);


                          },
                          child: Container(
                              padding: scaler.getPadding(1, 1),
                              alignment: Alignment.topRight,
                              child: AppText(
                                text: "Existing",
                                color: ColorConstants.red,
                              )),
                        ),
                        SizedBox(
                          height: scaler.getHeight(2),
                        ),
                        Align(
                          alignment: Alignment.center,
                          child: AppButton(enabled: (isEmailValid != null && isEmailValid) &&
                              (isPasswordValid != null && isPasswordValid) &&
                              (isNameValid != null && isNameValid),
                          text: "Sign up",
                            onPressed: ()async{
                              animation = true;
                              final String name = nameController.text;
                              final String email = emailController.text;
                              final String password = passwordController.text;

                              SharedPreferences isLogedIn =
                              await SharedPreferences.getInstance();
                              isLogedIn.setBool(Common.isLogin, true);
                              SharedPreferences nameshared =
                              await SharedPreferences.getInstance();
                              nameshared.setString(Common.name, nameController.text);

                              UserModel userModel = UserModel(name: name,email: email,password:password );

                              bookModelBox.add(CreateBookDataBse().bookModel1);
                              bookModelBox.add(CreateBookDataBse().bookModel2);
                              bookModelBox.add(CreateBookDataBse().bookModel3);
                              bookModelBox.add(CreateBookDataBse().bookModel4);
                              bookModelBox.add(CreateBookDataBse().bookModel6);
                              bookModelBox.add(CreateBookDataBse().bookModel7);
                              bookModelBox.add(CreateBookDataBse().bookModel8);
                              bookModelBox.add(CreateBookDataBse().bookModel9).whenComplete(() {
                                userModelBox.add(userModel).whenComplete((){
                                  animation = false;

                                  Navigator.of(context).pushReplacementNamed(RoutesConstants.homePage);

                                });
                              });                            },
                          )
                        ),
                        SizedBox(
                          height: scaler.getHeight(2),
                        ),
                        AppText(
                          text: errorText,
                          color: ColorConstants.red,
                        ),
                        SizedBox(
                          height: scaler.getHeight(2),
                        ),
                                          ],
                    ),
                  ),
                )
            ),
          animation != false?  Positioned(
              child: Container(
                  color: ColorConstants.grey.withOpacity(.5),
                  child: Center(child: Lottie.asset('animations/loader.json'))),
            ): Container(),
          ],
        )
      ),
    );
  }



  validateName() {
    setState(() {
      isNameValid = Validations.nameValidation(nameController.text.toString());
    });
  }

  validateEmail() {
    setState(() {
      isEmailValid =
          Validations.emailValidation(emailController.text.toString());

      errorText=!isEmailValid ? "Invalid_email":"";
    });
  }

  validatePassword() {
    setState(() {
      isPasswordValid =Validations.passwordValidation(passwordController.text.toString());
      errorText=!isPasswordValid ? "Invalid password":"";
    });
  }
}

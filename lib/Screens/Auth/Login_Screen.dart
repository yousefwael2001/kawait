import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:kawait/Screens/Auth/Auth_Screen.dart';
import 'package:kawait/Screens/Auth/Register_screen.dart';
import 'package:kawait/Screens/Home/Home_Screen.dart';
import 'package:kawait/fb-controllers/fb_auth_controller.dart';
import 'package:kawait/widgets/text_field.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  late StreamSubscription stream;

  late TextEditingController _emailcontroller;
  late TextEditingController _passwordcontroller;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _emailcontroller = TextEditingController();
    _passwordcontroller = TextEditingController();
  }

  @override
  void dispose() {
    _emailcontroller.dispose();
    _passwordcontroller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0XFFF3F3F9),
      appBar: AppBar(
        title: Text(
          'تسجيل الدخول',
          style: GoogleFonts.tajawal(
            fontSize: 17.sp,
            fontStyle: FontStyle.normal,
            color: Colors.black,
          ),
          textAlign: TextAlign.center,
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
        leading: SizedBox(),
        actions: [
          IconButton(
            onPressed: () {
              Get.back();
            },
            icon: Icon(
              Icons.navigate_next_sharp,
              color: Colors.black,
              size: 35.r,
            ),
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(
              decoration: BoxDecoration(
                color: Colors.white,
              ),
              padding: EdgeInsets.symmetric(horizontal: 16.w),
              child: Column(
                children: [
                  SizedBox(
                    height: 45.h,
                  ),
                  TextFieldStyle(
                    isenablelable: true,
                    lableText: 'اسم المستخدم أو البريد الالكتروني',
                    hintText: 'اسم المستخدم أو البريد الالكتروني',
                    codeTextController: _emailcontroller,
                    obscureText: false,
                    inputType: TextInputType.emailAddress,
                  ),
                  SizedBox(
                    height: 9.h,
                  ),
                  TextFieldStyle(
                    isenablelable: true,
                    lableText: 'كلمة المرور',
                    hintText: 'كلمة المرور',
                    codeTextController: _passwordcontroller,
                    obscureText: true,
                    inputType: TextInputType.visiblePassword,
                  ),
                  SizedBox(
                    height: 7.h,
                  ),
                  InkWell(
                    onTap: () {
                      Get.to(() => RegisterScreen());
                    },
                    child: RichText(
                      text: TextSpan(
                        style: GoogleFonts.tajawal(
                            fontSize: 18.sp, color: Colors.black),
                        children: <TextSpan>[
                          TextSpan(
                            text: 'ليس لديك حساب!  ',
                            style: GoogleFonts.tajawal(
                              fontSize: 14.sp,
                              color: Color(0XFF777777),
                            ),
                          ),
                          TextSpan(
                            text: 'إنشاء حساب',
                            style: GoogleFonts.tajawal(
                              fontSize: 14.sp,
                              color: Color(0XFFFED235),
                              decoration: TextDecoration.underline,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 27.h,
                  ),
                  ElevatedButton(
                    onPressed: () {
                      performLogin();
                    },
                    child: Text(
                      "تسجيل الدخول",
                      style: GoogleFonts.tajawal(
                        fontSize: 18.sp,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    style: ElevatedButton.styleFrom(
                      minimumSize: Size(343.w, 47.h),
                      backgroundColor: Color(0XFFFED235),
                      shadowColor: Colors.transparent,
                      shape: RoundedRectangleBorder(
                        side: BorderSide(
                          color: Color(0XFFFED235),
                        ),
                        borderRadius: BorderRadius.circular(8.r),
                      ),
                      alignment: Alignment.center,
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> performLogin() async {
    if (checkData()) {
      showDialog(
        context: context,
        builder: (context) {
          return Center(
            child: SpinKitFadingCircle(
              color: Colors.blue,
              size: 80.0,
            ),
          );
        },
      );
      await login();
    }
  }

  bool checkData() {
    if (_emailcontroller.text.isNotEmpty &&
        _passwordcontroller.text.isNotEmpty) {
      return true;
    } else {
      return false;
    }
  }

  Future<void> login() async {
    bool status = await FbAuthController().signIn(
        context: context,
        email: _emailcontroller.text,
        password: _passwordcontroller.text);
    if (status) {
      Get.back();
      stream = FbAuthController().checkUserStatus(({required bool loggedIn}) {
        loggedIn ? Get.to(HomeScreen(), arguments: "1") : Get.to(AuthScreen());
      });
    }
  }
}

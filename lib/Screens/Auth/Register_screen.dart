import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:get/get_connect/http/src/utils/utils.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:kawait/Screens/Auth/Login_Screen.dart';
import 'package:kawait/Screens/Home/Home_Screen.dart';
import 'package:kawait/fb-controllers/fb_auth_controller.dart';
import 'package:kawait/utils/helpers.dart';
import 'package:kawait/widgets/text_field.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> with Helpers {
  late TextEditingController _nameController;
  late TextEditingController _emailController;
  late TextEditingController _phoneController;
  late TextEditingController _companyNameController;
  late TextEditingController _passwordController;
  late TextEditingController _passwordController1;
  File? _image;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _nameController = TextEditingController();
    _emailController = TextEditingController();
    _phoneController = TextEditingController();
    _passwordController = TextEditingController();
    _passwordController1 = TextEditingController();
    _companyNameController = TextEditingController();
  }

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    _companyNameController.dispose();
    _passwordController.dispose();
    _passwordController1.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0XFFF3F3F9),
      appBar: AppBar(
        title: Text(
          "إنشاء حساب",
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
                    lableText: "الاسم",
                    hintText: "",
                    codeTextController: _nameController,
                    obscureText: false,
                    inputType: TextInputType.name,
                  ),
                  SizedBox(
                    height: 9.h,
                  ),
                  TextFieldStyle(
                    isenablelable: true,
                    lableText: 'الايميل',
                    hintText: "",
                    codeTextController: _emailController,
                    obscureText: false,
                    inputType: TextInputType.emailAddress,
                  ),
                  SizedBox(
                    height: 9.h,
                  ),
                  TextFieldStyle(
                    isenablelable: true,
                    lableText: 'رقم الهاتف',
                    hintText: "",
                    codeTextController: _phoneController,
                    obscureText: false,
                    inputType: TextInputType.phone,
                  ),
                  SizedBox(
                    height: 9.h,
                  ),
                  TextFieldStyle(
                    isenablelable: true,
                    lableText: "اسم الشركة",
                    hintText: "",
                    codeTextController: _companyNameController,
                    obscureText: false,
                    inputType: TextInputType.name,
                  ),
                  SizedBox(
                    height: 9.h,
                  ),
                  TextFieldStyle(
                    isenablelable: true,
                    lableText: 'كلمة المرور',
                    hintText: "************",
                    codeTextController: _passwordController,
                    obscureText: true,
                    inputType: TextInputType.visiblePassword,
                  ),
                  SizedBox(
                    height: 9.h,
                  ),
                  TextFieldStyle(
                    isenablelable: true,
                    lableText: 'تأكيد كلمة المرور',
                    hintText: "************",
                    codeTextController: _passwordController1,
                    obscureText: true,
                    inputType: TextInputType.visiblePassword,
                  ),
                  SizedBox(
                    height: 7.h,
                  ),
                  InkWell(
                    onTap: () {
                      Get.to(() => LoginScreen());
                    },
                    child: RichText(
                      text: TextSpan(
                        style: GoogleFonts.tajawal(
                            fontSize: 18.sp, color: Colors.black),
                        children: <TextSpan>[
                          TextSpan(
                            text: 'لديك حساب!  ',
                            style: GoogleFonts.tajawal(
                              fontSize: 14.sp,
                              color: Color(0XFF777777),
                            ),
                          ),
                          TextSpan(
                            text: 'تسجيل الدخول',
                            onEnter: (event) {},
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
                      performRegister();
                    },
                    child: Text(
                      "إنشاء حساب",
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

  Future<void> performRegister() async {
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
      await register();
    }
  }

  bool checkData() {
    if (_nameController.text.isNotEmpty &&
        _emailController.text.isNotEmpty &&
        _companyNameController.text.isNotEmpty &&
        _passwordController.text.isNotEmpty &&
        _passwordController1.text.isNotEmpty &&
        _phoneController.text.isNotEmpty) {
      if (_passwordController.text == _passwordController1.text) {
        return true;
      } else {
        showSnackBar(
            context: context, message: 'Passwords do not match', error: true);
      }
    } else {
      showSnackBar(
          context: context, message: 'Enter requried Data', error: true);
      return false;
    }
    return false;
  }

  Future<void> register() async {
    bool status = await FbAuthController().createAccount(_image,
        name: _nameController.text,
        phone: _phoneController.text,
        context: context,
        email: _emailController.text,
        company_name: _companyNameController.text,
        password: _passwordController.text);
    if (status) {
      Get.off(HomeScreen(), arguments: "1");
    }
  }
}

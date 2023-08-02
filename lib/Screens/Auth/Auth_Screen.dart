import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:kawait/Screens/Auth/Login_Screen.dart';
import 'package:kawait/Screens/Home/Home_Screen.dart';

class AuthScreen extends StatefulWidget {
  const AuthScreen({super.key});

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage(
                'images/close-up-businessman-holding-briefcase.png',
              ),
              fit: BoxFit.fill,
            ),
          ),
          padding: EdgeInsets.symmetric(horizontal: 16.w),
          width: 375.w,
          height: 812.h,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 179.h,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'مرحبا بك',
                    style: GoogleFonts.tajawal(
                      fontSize: 46.sp,
                      fontWeight: FontWeight.bold,
                      color: Color(0xffFED235),
                      shadows: [
                        BoxShadow(
                          color: Color(0XFF707070),
                          blurRadius: 6,
                          offset: Offset(0, 3),
                        ),
                      ],
                    ),
                  ),
                  Text(
                    'في قروب\nمدينة الكويت السكنية',
                    style: GoogleFonts.tajawal(
                      fontSize: 30.sp,
                      color: Colors.black,
                      shadows: [
                        BoxShadow(
                          color: Color(0XFF707070),
                          blurRadius: 6,
                          offset: Offset(0, 3),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 264.h,
              ),
              ElevatedButton(
                onPressed: () {
                  Get.to(() => LoginScreen());
                },
                child: Text(
                  'تسجيل الدخول',
                  style: GoogleFonts.tajawal(
                    fontSize: 18.sp,
                    fontWeight: FontWeight.bold,
                    color: Color(0XFFFED235),
                  ),
                ),
                style: ElevatedButton.styleFrom(
                  minimumSize: Size(343.w, 47.h),
                  backgroundColor: Colors.transparent,
                  shadowColor: Colors.transparent,
                  shape: RoundedRectangleBorder(
                    side: BorderSide(
                      color: Color(0XFFFED235),
                    ),
                    borderRadius: BorderRadius.circular(8.r),
                  ),
                  alignment: Alignment.center,
                ),
              ),
              SizedBox(
                height: 20.h,
              ),
              ElevatedButton(
                onPressed: () {
                  Get.to(() => HomeScreen(), arguments: "0");
                },
                child: Text(
                  "تصفح",
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
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:kawait/Screens/Auth/Auth_Screen.dart';
import 'package:kawait/Screens/Home/Home_Screen.dart';
import 'package:kawait/Screens/OnBoardingScreen/OnBoardingScreen.dart';
import 'package:kawait/Shared%20preferences/shared_preferences.dart';

class SplachScreen extends StatefulWidget {
  const SplachScreen({super.key});

  @override
  State<SplachScreen> createState() => _SplachScreenState();
}

class _SplachScreenState extends State<SplachScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Future.delayed(
      Duration(
        seconds: 2,
      ),
      () {
        AppSettingsPreferences().state == "1"
            ? Get.off(AuthScreen(), transition: Transition.circularReveal)
            : Get.off(OnBoardingScreen(),
                transition: Transition.circularReveal);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset("images/Group 41472.png"),
            SizedBox(
              height: 15,
            ),
            Text(
              "مدينة الكويت السكنية",
              style: GoogleFonts.tajawal(
                fontSize: 18.sp,
                color: Colors.black,
                shadows: [
                  BoxShadow(
                    color: Color(0XFF707070),
                    blurRadius: 6,
                    offset: Offset(0, 3),
                  ),
                ],
                fontWeight: FontWeight.bold,
              ),
            )
          ],
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kawait/Screens/Home/HomePages/AdsPage/ads_screen.dart';

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
        Get.off(AdsScreen());
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Container(
            width: double.infinity,
            height: double.infinity,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage("images/tall-office-buildings-city.jpg"),
                fit: BoxFit.cover,
              ),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  "images/newLogo.png",
                ),
                // SizedBox(
                //   height: 15,
                // ),
                // Text(
                //   "مدينة الكويت السكنية",
                //   style: GoogleFonts.tajawal(
                //     fontSize: 18.sp,
                //     color: Colors.black,
                //     shadows: [
                //       BoxShadow(
                //         color: Color(0XFF707070),
                //         blurRadius: 6,
                //         offset: Offset(0, 3),
                //       ),
                //     ],
                //     fontWeight: FontWeight.bold,
                //   ),
                // )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

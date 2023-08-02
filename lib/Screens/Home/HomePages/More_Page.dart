import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:kawait/Screens/Home/HomePages/MorePageScreens/condetions_of_use.dart';
import 'package:kawait/widgets/list_tile_style.dart';

import 'MorePageScreens/how_us.dart';
import 'MorePageScreens/reports.dart';

class MorePage extends StatefulWidget {
  const MorePage({super.key});

  @override
  State<MorePage> createState() => _MorePageState();
}

class _MorePageState extends State<MorePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Color(0xffF8F8F8),
        title: Text(
          "المزيد",
          style: GoogleFonts.tajawal(
            fontSize: 17.sp,
            color: Colors.black,
            fontWeight: FontWeight.w600,
          ),
        ),
        leadingWidth: 90.w,
        leading: SizedBox(),
        actions: [
          Padding(
            padding: EdgeInsets.only(left: 15.w),
            child: Icon(
              Icons.notifications_none_rounded,
              color: Color(0xffC7C7C7),
            ),
          )
        ],
        toolbarHeight: 60.h,
      ),
      body: Container(
        decoration: BoxDecoration(
          color: Colors.white,
        ),
        child: Column(
          children: [
            SizedBox(
              height: 42.h,
            ),
            ListTileStyleWidget(
              leadingImage: 'images/Path 68597.png',
              onTap: () {
                Get.to(() => HowUs());
              },
              title: "من نحن",
            ),
            SizedBox(
              height: 11.h,
            ),
            ListTileStyleWidget(
              leadingImage: 'images/svgexport-6 (27).png',
              onTap: () {
                Get.to(() => ConditionsOfUse());
              },
              title: 'شروط الاستخدام',
            ),
            SizedBox(
              height: 11.h,
            ),
            ListTileStyleWidget(
              leadingImage: 'images/Group 40348.png',
              onTap: () {
                Get.to(() => Reports());
              },
              title: "الشكاوي والاقتراحات",
            ),
            SizedBox(
              height: 11.h,
            ),
            ListTileStyleWidget(
              leadingImage: 'images/Group 40349.png',
              onTap: () {
                // Get.to(() => EditPasswordPage());
              },
              title: "مشاركة التطبيق",
            ),
            SizedBox(
              height: 11.h,
            ),
            ListTileStyleWidget(
              leadingImage: 'images/_x31_4_comment.png',
              onTap: () async {
                // return await showDialog(
                //   context: context,
                //   builder: (context) {
                //     return StatefulBuilder(
                //       builder: (context, setState) {
                //         return AlertDialogWidget(
                //           contant: 'logout_state',
                //           ensure: "confirmodrder",
                //           exit: "cancel",
                //           title: "confirmyourorder",
                //           ontap: () async {
                //             // await logout();
                //           },
                //         );
                //       },
                //     );
                //   },
                // );
              },
              title: "تواصل معنا",
            ),
            SizedBox(
              height: 35.h,
            ),
            Column(
              children: [
                Text(
                  "تابعنا على حساباتنا",
                  style: GoogleFonts.tajawal(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w500,
                    color: Colors.black,
                    shadows: [
                      Shadow(
                        color: Color(0xFFFED235),
                        offset: Offset(2, 2),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 26.h,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CircleAvatar(
                      radius: 25.r,
                      child: Image.asset(
                        "images/svgexport-17 (81).png",
                        width: 20.w,
                        height: 16.h,
                      ),
                      backgroundColor: Color(0xffF7F7F7),
                    ),
                    SizedBox(
                      width: 24.w,
                    ),
                    CircleAvatar(
                      radius: 25.r,
                      child: Image.asset(
                        "images/Group 38378.png",
                        width: 20.w,
                        height: 16.h,
                      ),
                      backgroundColor: Color(0xffF7F7F7),
                    ),
                    SizedBox(
                      width: 24.w,
                    ),
                    CircleAvatar(
                      radius: 25.r,
                      child: Image.asset(
                        "images/Path 66795.png",
                        width: 20.w,
                        height: 16.h,
                      ),
                      backgroundColor: Color(0xffF7F7F7),
                    ),
                    SizedBox(
                      width: 24.w,
                    ),
                    CircleAvatar(
                      radius: 25.r,
                      child: Image.asset(
                        "images/svgexport-17 (83).png",
                        width: 20.w,
                        height: 16.h,
                      ),
                      backgroundColor: Color(0xffF7F7F7),
                    )
                  ],
                ),
                SizedBox(
                  height: 14.h,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CircleAvatar(
                      radius: 25.r,
                      child: Image.asset(
                        "images/svgexport-17 (80).png",
                        width: 20.w,
                        height: 16.h,
                      ),
                      backgroundColor: Color(0xffF7F7F7),
                    ),
                    SizedBox(
                      width: 24.w,
                    ),
                    CircleAvatar(
                      radius: 25.r,
                      child: Image.asset(
                        "images/svgexport-17 (79).png",
                        width: 20.w,
                        height: 16.h,
                      ),
                      backgroundColor: Color(0xffF7F7F7),
                    ),
                    SizedBox(
                      width: 24.w,
                    ),
                    CircleAvatar(
                      radius: 25.r,
                      child: Image.asset(
                        "images/svgexport-17 (82).png",
                        width: 20.w,
                        height: 16.h,
                      ),
                      backgroundColor: Color(0xffF7F7F7),
                    ),
                  ],
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}

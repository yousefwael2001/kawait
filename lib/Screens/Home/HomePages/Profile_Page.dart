import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:kawait/Screens/Home/HomePages/ProfilePageScreens/service_page.dart';
import 'package:kawait/Shared%20preferences/shared_preferences.dart';
import 'package:kawait/fb-controllers/fb_auth_controller.dart';
import 'package:kawait/widgets/alert_dialog_widget.dart';
import 'package:kawait/widgets/list_tile_style.dart';

import 'ProfilePageScreens/details_page.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Color(0xffF8F8F8),
        title: Text(
          "ملفي",
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
              height: 20.h,
            ),
            CircleAvatar(
              maxRadius: 36.r,
              child: AppSettingsPreferences().user().imageURL == ""
                  ? Image.asset(
                      'images/Ellipse 3.png',
                      fit: BoxFit.cover,
                      filterQuality: FilterQuality.high,
                    )
                  : Image.network(AppSettingsPreferences().user().imageURL!),
              backgroundColor: Colors.transparent,
            ),
            SizedBox(
              height: 11.h,
            ),
            Text(
              AppSettingsPreferences().user().name!,
              style: GoogleFonts.tajawal(
                fontSize: 16.sp,
                color: Colors.black,
              ),
            ),
            SizedBox(
              height: 42.h,
            ),
            ListTileStyleWidget(
              leadingImage: 'images/svgexport-6 (31).png',
              onTap: () {
                Get.to(() => DetailsPage());
              },
              title: 'معلومات الحساب',
            ),
            SizedBox(
              height: 11.h,
            ),
            ListTileStyleWidget(
              leadingImage: 'images/svgexport-6 (22).png',
              onTap: () {
                Get.to(() => ServicePage());
              },
              title: 'خدماتي',
            ),
            SizedBox(
              height: 11.h,
            ),
            ListTileStyleWidget(
              leadingImage: 'images/Group 40349.png',
              onTap: () {
                // Get.to(() => EditPasswordPage());
              },
              title: 'مشاركة التطبيق',
            ),
            SizedBox(
              height: 11.h,
            ),
            ListTileStyleWidget(
              leadingImage: 'images/svgexport-17 (4).png',
              onTap: () async {
                return await showDialog(
                  context: context,
                  builder: (context) {
                    return StatefulBuilder(
                      builder: (context, setState) {
                        return AlertDialogWidget(
                          contant: 'هل أنت متأكد من تسجيل الخروج',
                          ensure: "تسجيل الخروج",
                          exit: "إلغاء",
                          title: "أكد طلبك",
                          ontap: () async {
                            await FbAuthController().signOut();
                          },
                        );
                      },
                    );
                  },
                );
              },
              title: 'تسجيل خروج',
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

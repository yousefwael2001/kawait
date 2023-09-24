import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:kawait/Screens/Home/HomePages/ProfilePageScreens/service_page.dart';
import 'package:kawait/Shared%20preferences/shared_preferences.dart';
import 'package:kawait/fb-controllers/fb_auth_controller.dart';
import 'package:kawait/widgets/alert_dialog_widget.dart';
import 'package:kawait/widgets/list_tile_style.dart';
import 'package:share_plus/share_plus.dart';
import 'package:url_launcher/url_launcher.dart';

import 'AdsPage/ads_screen_managements.dart';
import 'ProfilePageScreens/details_page.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  void tikTokAppOpen() async {
    var url =
        'https://www.tiktok.com/@kuwaitcityresidential?_t=8ecxjxfkqef&_r=1';
    await launch(url);
  }

  void instegramAppOpen() async {
    var url = 'https://www.instagram.com/kuwait_city_residential/';
    await launch(url);
  }

  void facebookAppOpen() async {
    var url = 'https://www.facebook.com/KuwaitCityResidential';
    await launch(url);
  }

  void telagramAppOpen() async {
    var url = 'https://t.me/+AEKkD7-xGIpmYmM0';
    await launch(url);
  }

  void snapshatAppOpen() async {
    var url = 'https://t.snapchat.com/9dXSIzwG';
    await launch(url);
  }

  void youtubeAppOpen() async {
    var url = 'https://www.youtube.com/@KuwaitCity1';
    await launch(url);
  }

  void twitterAppOpen() async {
    var url = 'https://twitter.com/kuwait_res';
    await launch(url);
  }

  void whatsAppOpen() async {
    var url = 'http://wa.me/+96561660571?text=Hello';
    await launch(url);
  }

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
        child: ListView(
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
                  : ClipRRect(
                      borderRadius: BorderRadius.circular(50.r),
                      child: Image.network(
                        AppSettingsPreferences().user().imageURL!,
                        width: 80,
                        fit: BoxFit.fill,
                      )),
              backgroundColor: Colors.transparent,
            ),
            SizedBox(
              height: 11.h,
            ),
            Align(
              alignment: Alignment.center,
              child: Text(
                AppSettingsPreferences().user().name!,
                style: GoogleFonts.tajawal(
                  fontSize: 16.sp,
                  color: Colors.black,
                ),
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
            Visibility(
              visible:
                  AppSettingsPreferences().email == "bkerziara11@gmail.com",
              child: SizedBox(
                height: 11.h,
              ),
            ),
            Visibility(
              visible:
                  AppSettingsPreferences().email == "bkerziara11@gmail.com",
              child: ListTileStyleWidget(
                leadingImage: 'images/svgexport-6 (22).png',
                onTap: () {
                  Get.to(() => AdsManageScreen());
                },
                title: 'الخدمات المميزة',
              ),
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
                Share.share(
                    "https://play.google.com/store/apps/details?id=com.kuwait.kawait&pli=1");
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
            SizedBox(
              height: 250.h,
              child: Column(
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
                      InkWell(
                        onTap: () {
                          tikTokAppOpen();
                        },
                        child: CircleAvatar(
                          radius: 25.r,
                          child: Image.asset(
                            "images/svgexport-17 (81).png",
                            width: 20.w,
                            height: 16.h,
                          ),
                          backgroundColor: Color(0xffF7F7F7),
                        ),
                      ),
                      SizedBox(
                        width: 24.w,
                      ),
                      InkWell(
                        onTap: () {
                          instegramAppOpen();
                        },
                        child: CircleAvatar(
                          radius: 25.r,
                          child: Image.asset(
                            "images/Group 38378.png",
                            width: 20.w,
                            height: 16.h,
                          ),
                          backgroundColor: Color(0xffF7F7F7),
                        ),
                      ),
                      SizedBox(
                        width: 24.w,
                      ),
                      InkWell(
                        onTap: () {
                          facebookAppOpen();
                        },
                        child: CircleAvatar(
                          radius: 25.r,
                          child: Image.asset(
                            "images/Path 66795.png",
                            width: 20.w,
                            height: 16.h,
                          ),
                          backgroundColor: Color(0xffF7F7F7),
                        ),
                      ),
                      SizedBox(
                        width: 24.w,
                      ),
                      InkWell(
                        onTap: () {
                          telagramAppOpen();
                        },
                        child: CircleAvatar(
                          radius: 25.r,
                          child: Image.asset(
                            "images/svgexport-17 (83).png",
                            width: 20.w,
                            height: 16.h,
                          ),
                          backgroundColor: Color(0xffF7F7F7),
                        ),
                      )
                    ],
                  ),
                  SizedBox(
                    height: 14.h,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      InkWell(
                        onTap: () {
                          snapshatAppOpen();
                        },
                        child: CircleAvatar(
                          radius: 25.r,
                          child: Image.asset(
                            "images/svgexport-17 (80).png",
                            width: 20.w,
                            height: 16.h,
                          ),
                          backgroundColor: Color(0xffF7F7F7),
                        ),
                      ),
                      SizedBox(
                        width: 24.w,
                      ),
                      InkWell(
                        onTap: () {
                          youtubeAppOpen();
                        },
                        child: CircleAvatar(
                          radius: 25.r,
                          child: Image.asset(
                            "images/svgexport-17 (79).png",
                            width: 20.w,
                            height: 16.h,
                          ),
                          backgroundColor: Color(0xffF7F7F7),
                        ),
                      ),
                      SizedBox(
                        width: 24.w,
                      ),
                      InkWell(
                        onTap: () {
                          twitterAppOpen();
                        },
                        child: CircleAvatar(
                          radius: 25.r,
                          child: Image.asset(
                            "images/svgexport-17 (82).png",
                            width: 20.w,
                            height: 16.h,
                          ),
                          backgroundColor: Color(0xffF7F7F7),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

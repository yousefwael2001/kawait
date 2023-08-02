import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:kawait/widgets/alert_dialog_widget.dart';
import 'package:kawait/widgets/list_tile_style.dart';

class ConditionsOfUse extends StatefulWidget {
  const ConditionsOfUse({super.key});

  @override
  State<ConditionsOfUse> createState() => _ConditionsOfUseState();
}

class _ConditionsOfUseState extends State<ConditionsOfUse> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Color(0xffF8F8F8),
        title: Text(
          "شروط الاستخدام",
          style: GoogleFonts.tajawal(
            fontSize: 17.sp,
            color: Colors.black,
            fontWeight: FontWeight.w600,
          ),
        ),
        leadingWidth: 90.w,
        leading: Padding(
          padding: EdgeInsets.only(left: 15.w),
          child: InkWell(
            onTap: () {
              Get.back();
            },
            child: Icon(
              Icons.arrow_back_ios,
              color: Colors.black,
            ),
          ),
        ),
        toolbarHeight: 60.h,
      ),
      body: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          color: Colors.white,
        ),
        padding: EdgeInsets.symmetric(horizontal: 16.w),
        child: ListView(
          children: [
            SizedBox(
              height: 20.h,
            ),
            Text(
              "شروط الاستخدام",
              style: GoogleFonts.tajawal(
                fontSize: 16.sp,
                fontWeight: FontWeight.bold,
                color: Color(0XFFFED235),
              ),
            ),
            SizedBox(
              height: 9.h,
            ),
            Text(
              "هذا نص تجريبي لاختبار شكل و حجم النصوص و طريقة عرضهاi في هذا المكان و حجم و لون الخط حيث يتم في هذا النص لشكل العام للقسم او الصفحة أو الموقع.",
              style: GoogleFonts.tajawal(
                fontSize: 15.sp,
                color: Color(0XFF505050),
              ),
            ),
            SizedBox(
              height: 20.h,
            ),
            Container(
              height: 190.h,
              padding: EdgeInsets.only(right: 15.w),
              decoration: BoxDecoration(
                  color: Color(0XFFFED235),
                  borderRadius: BorderRadius.circular(25.r)),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 16.h,
                  ),
                  Text(
                    "تابعنا على مواقع التواصل الإجتماعي",
                    style: GoogleFonts.tajawal(
                      fontSize: 14.sp,
                      color: Colors.white,
                    ),
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Column(
                        children: [
                          SizedBox(
                            height: 24.h,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Icon(
                                CupertinoIcons.phone_circle,
                                color: Colors.white,
                                size: 20.r,
                              ),
                              SizedBox(
                                width: 7.w,
                              ),
                              Text(
                                "+972 595967150",
                                style: GoogleFonts.tajawal(
                                  fontSize: 14.sp,
                                  color: Colors.white,
                                ),
                              )
                            ],
                          ),
                          SizedBox(
                            height: 18.h,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Icon(
                                Icons.facebook,
                                color: Colors.white,
                                size: 20.r,
                              ),
                              SizedBox(
                                width: 7.w,
                              ),
                              Text(
                                "@facebookuser",
                                style: GoogleFonts.tajawal(
                                  fontSize: 14.sp,
                                  color: Colors.white,
                                ),
                              )
                            ],
                          ),
                          SizedBox(
                            height: 18.h,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Image.asset(
                                "images/Group 38378.png",
                                color: Colors.white,
                              ),
                              SizedBox(
                                width: 7.w,
                              ),
                              Text(
                                "@instagramuser",
                                style: GoogleFonts.tajawal(
                                  fontSize: 14.sp,
                                  color: Colors.white,
                                ),
                              )
                            ],
                          )
                        ],
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: 5.h),
                        child: Image.asset("images/Group 38964.png"),
                      )
                    ],
                  )
                ],
              ),
            ),
            SizedBox(
              height: 15.h,
            ),
            Text(
              "هذا نص تجريبي لاختبار شكل و حجم النصوص و طريقة عرضهاi في هذا المكان و حجم و لون الخط حيث يتم التحكم في هذا النص وامكانية تغييرة في اي وقت عن طريق ادارة الموقع . يتم اضافة هذا النص كنص تجريبي للمعاينة فقط وهو لا يعبر عن أي موضوع محدد انما لتحديد الشكل العام للقسم او الصفحة أو الموقع.",
              style: GoogleFonts.tajawal(
                fontSize: 14.sp,
                color: Color(0XFF505050),
              ),
            ),
            SizedBox(
              height: 15.h,
            ),
            Text(
              "هذا نص تجريبي لاختبار شكل و حجم النصوص و طريقة عرضهاi في هذا المكان و حجم و لون الخط حيث يتم التحكم في هذا النص وامكانية تغييرة في اي وقت عن طريق ادارة الموقع . يتم اضافة هذا النص كنص تجريبي للمعاينة فقط وهو لا يعبر عن أي موضوع محدد انما لتحديد الشكل العام للقسم او الصفحة أو الموقع.",
              style: GoogleFonts.tajawal(
                fontSize: 14.sp,
                color: Color(0XFF505050),
              ),
            ),
            SizedBox(
              height: 15.h,
            ),
            Text(
              "هذا نص تجريبي لاختبار شكل و حجم النصوص و طريقة عرضهاi في هذا المكان و حجم و لون الخط حيث يتم التحكم في هذا النص وامكانية تغييرة في اي وقت عن طريق ادارة الموقع . يتم اضافة هذا النص كنص تجريبي للمعاينة فقط وهو لا يعبر عن أي موضوع محدد انما لتحديد الشكل العام للقسم او الصفحة أو الموقع.",
              style: GoogleFonts.tajawal(
                fontSize: 14.sp,
                color: Color(0XFF505050),
              ),
            ),
            SizedBox(
              height: 15.h,
            ),
            Text(
              "هذا نص تجريبي لاختبار شكل و حجم النصوص و طريقة عرضهاi في هذا المكان و حجم و لون الخط حيث يتم التحكم في هذا النص وامكانية تغييرة في اي وقت عن طريق ادارة الموقع . يتم اضافة هذا النص كنص تجريبي للمعاينة فقط وهو لا يعبر عن أي موضوع محدد انما لتحديد الشكل العام للقسم او الصفحة أو الموقع.",
              style: GoogleFonts.tajawal(
                fontSize: 14.sp,
                color: Color(0XFF505050),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

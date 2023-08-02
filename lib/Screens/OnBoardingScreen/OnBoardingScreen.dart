import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:kawait/Provider/on_boradring_state.dart';
import 'package:kawait/Screens/Auth/Auth_Screen.dart';
import 'package:kawait/Screens/Home/Home_Screen.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class OnBoardingScreen extends StatefulWidget {
  const OnBoardingScreen({super.key});

  @override
  State<OnBoardingScreen> createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  final controller = PageController();
  bool isLastPage = false;

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        shadowColor: Colors.transparent,
        backgroundColor: Colors.white,
        leadingWidth: 115.w,
        actions: [
          InkWell(
            onTap: () {
              controller.nextPage(
                duration: const Duration(milliseconds: 500),
                curve: Curves.easeInOut,
              );
            },
            child: Container(
              margin: EdgeInsets.symmetric(vertical: 10.h, horizontal: 16.w),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8.r),
                color: Color(0XFFFED235),
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                  SizedBox(
                    width: 8.w,
                  ),
                  Text(
                    'تخطي',
                    style: GoogleFonts.tajawal(
                      color: Colors.white,
                      fontSize: 18.sp,
                      fontStyle: FontStyle.normal,
                    ),
                  ),
                  Icon(
                    Icons.navigate_next_rounded,
                    color: Colors.white,
                    size: 28.w,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
      body: Stack(
        children: [
          PageView(
            controller: controller,
            onPageChanged: (value) {
              setState(() {
                isLastPage = value == 2;
              });
            },
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(
                    height: 202.73.h,
                    width: 317.71.w,
                    child: Image.asset(
                      'images/undraw_details_8k13.png',
                      fit: BoxFit.fill,
                      filterQuality: FilterQuality.high,
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 53.1.h, bottom: 15.h),
                    child: SizedBox(
                      child: Text(
                        'الأفضل',
                        style: GoogleFonts.tajawal(
                          fontSize: 20.sp,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 343.w,
                    child: Text(
                      'لانه يقدم لك مزودين خدمة محترفين ومخلصين مختارين من قبل كادر هندسي مختص, وضمان على جودة العمل',
                      textAlign: TextAlign.center,
                      style: GoogleFonts.tajawal(
                        fontSize: 17.sp,
                        fontStyle: FontStyle.normal,
                        color: Color(0XFF707070),
                      ),
                    ),
                  ),
                ],
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(
                    height: 233.h,
                    width: 343.w,
                    child: Image.asset(
                      'images/undraw_organize_resume_re_k45b.png',
                      fit: BoxFit.fill,
                      filterQuality: FilterQuality.high,
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 35.h, bottom: 15.h),
                    child: SizedBox(
                      child: Text(
                        'الأسهل',
                        style: GoogleFonts.tajawal(
                          fontSize: 20.sp,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 343.w,
                    child: Text(
                      "لانه يوفر لك وقت البحث عن مزودين الخدمة الاكفاء من خلال ضغطة زر",
                      style: GoogleFonts.tajawal(
                        fontSize: 17.sp,
                        fontStyle: FontStyle.normal,
                        color: Color(0XFF707070),
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ],
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(
                    height: 233.h,
                    width: 343.w,
                    child: Image.asset(
                      'images/undraw_bitcoin_p2p_re_1xqa.png',
                      fit: BoxFit.fill,
                      filterQuality: FilterQuality.high,
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 35.h, bottom: 15.h),
                    child: SizedBox(
                      child: Text(
                        'الأرخص'.tr,
                        style: GoogleFonts.tajawal(
                          fontSize: 20.sp,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 343.w,
                    child: Text(
                      'لانه يقدم لك الخدمة عن طريق مناقصة سريعة من قبل مزودين الخدمة , ولايضيف التطبيق اي فائدة له',
                      style: GoogleFonts.tajawal(
                        fontSize: 17.sp,
                        fontStyle: FontStyle.normal,
                        color: Color(0XFF707070),
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ],
              ),

              // Column(
              //   mainAxisAlignment: MainAxisAlignment.center,
              //   children: [
              //     SizedBox(
              //       height: 233.h,
              //       width: 343.w,
              //       child: Image.asset(
              //         'images/onboarding3.png',
              //         fit: BoxFit.fill,
              //         filterQuality: FilterQuality.high,
              //       ),
              //     ),
              //     Padding(
              //       padding: EdgeInsets.only(top: 35.h, bottom: 15.h),
              //       child: SizedBox(
              //         child: Text(
              //           'data_order'.tr,
              //           style: GoogleFonts.tajawal(
              //             fontSize: 20.sp,
              //             fontWeight: FontWeight.bold,
              //             color: Colors.black,
              //           ),
              //         ),
              //       ),
              //     ),
              //     SizedBox(
              //       width: 343.w,
              //       child: Text(
              //         'data_order_state'.tr,
              //         style: GoogleFonts.tajawal(
              //           fontSize: 17.sp,
              //           fontStyle: FontStyle.normal,
              //           color: Color(0XFF707070),
              //         ),
              //         textAlign: TextAlign.center,
              //       ),
              //     ),
              //   ],
              // ),
            ],
          ),
          Container(
            alignment: const Alignment(0, 0.70),
            child: SmoothPageIndicator(
              controller: controller, // PageController
              count: 3,
              // forcing the indicator to use a specific direction
              // textDirection: AppSettingsPreferences().langCode == 'ar'
              //     ? TextDirection.rtl
              //     : TextDirection.ltr,
              effect: ExpandingDotsEffect(
                activeDotColor: Color(0XFFFED235),
                dotHeight: 6.h,
                dotWidth: 8.w,
                dotColor: Color(0XFFE0E0E0),
              ),
            ),
          )
        ],
      ),
      bottomSheet: isLastPage
          ? Container(
              height: 60,
              margin: EdgeInsets.only(bottom: 34.h),
              alignment: Alignment.center,
              child: ElevatedButton(
                onPressed: () {
                  ChangeStateOnBoardingNotifier().changeState(state: "1");
                  Get.off(AuthScreen(), transition: Transition.cupertino);
                },
                style: ElevatedButton.styleFrom(
                    minimumSize: Size(
                      343.w,
                      50.h,
                    ),
                    backgroundColor: Color(0XFFFED235),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8.r),
                    ),
                    elevation: 0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(Icons.arrow_back_rounded),
                    SizedBox(
                      width: 17.w,
                    ),
                    Text(
                      'الاستمرار'.tr,
                      style: GoogleFonts.tajawal(
                        fontSize: 18.sp,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            )
          : const SizedBox(),
    );
  }
}

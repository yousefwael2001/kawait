// import 'package:admob_flutter/admob_flutter.dart';
import 'package:admob_flutter/admob_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:kawait/Screens/Auth/Login_Screen.dart';
import 'package:kawait/Screens/Home/Home_Screen.dart';

import '../../Service/ads_mobile_service.dart';
import '../../Shared preferences/shared_preferences.dart';

class AuthScreen extends StatefulWidget {
  const AuthScreen({super.key});

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  late AdmobInterstitial interstitialAd;
  late AdmobInterstitial interstitialAd1;
  GlobalKey<ScaffoldState> scaffoldState = GlobalKey();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    interstitialAd = AdmobInterstitial(
      adUnitId: AdHelper.interstitialAdUnitId,
      listener: (AdmobAdEvent event, Map<String, dynamic>? args) {
        if (event == AdmobAdEvent.closed) interstitialAd.load();
        handleEvent(event, args, 'Interstitial');
      },
    );
    interstitialAd.load();

    interstitialAd1 = AdmobInterstitial(
      adUnitId: AdHelper.interstitialAdUnitId,
      listener: (AdmobAdEvent event, Map<String, dynamic>? args) {
        if (event == AdmobAdEvent.closed) interstitialAd1.load();
        handleEvent1(event, args, 'Interstitial');
      },
    );
    interstitialAd1.load();
  }

  void handleEvent(
      AdmobAdEvent event, Map<String, dynamic>? args, String adType) {
    switch (event) {
      case AdmobAdEvent.loaded:
        // showSnackBar('New Admob $adType Ad loaded!');
        break;
      case AdmobAdEvent.opened:
        // showSnackBar('Admob $adType Ad opened!');
        break;
      case AdmobAdEvent.closed:
        Get.to(() => LoginScreen());
        // showSnackBar('Admob $adType Ad closed!');
        break;
      case AdmobAdEvent.failedToLoad:
        // showSnackBar('Admob $adType failed to load. :(');
        break;
      case AdmobAdEvent.rewarded:
        showDialog(
          context: scaffoldState.currentContext!,
          builder: (BuildContext context) {
            return WillPopScope(
              onWillPop: () async {
                ScaffoldMessenger.of(context).hideCurrentSnackBar();
                return true;
              },
              child: AlertDialog(
                content: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Text('Reward callback fired. Thanks Andrew!'),
                    Text('Type: ${args!['type']}'),
                    Text('Amount: ${args['amount']}'),
                  ],
                ),
              ),
            );
          },
        );
        break;
      default:
    }
  }

  void handleEvent1(
      AdmobAdEvent event, Map<String, dynamic>? args, String adType) {
    switch (event) {
      case AdmobAdEvent.loaded:
        // showSnackBar('New Admob $adType Ad loaded!');
        break;
      case AdmobAdEvent.opened:
        // showSnackBar('Admob $adType Ad opened!');
        break;
      case AdmobAdEvent.closed:
        Get.to(() => HomeScreen(), arguments: "0");

        // showSnackBar('Admob $adType Ad closed!');
        break;
      case AdmobAdEvent.failedToLoad:
        // showSnackBar('Admob $adType failed to load. :(');
        break;
      case AdmobAdEvent.rewarded:
        showDialog(
          context: scaffoldState.currentContext!,
          builder: (BuildContext context) {
            return WillPopScope(
              onWillPop: () async {
                ScaffoldMessenger.of(context).hideCurrentSnackBar();
                return true;
              },
              child: AlertDialog(
                content: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Text('Reward callback fired. Thanks Andrew!'),
                    Text('Type: ${args!['type']}'),
                    Text('Amount: ${args['amount']}'),
                  ],
                ),
              ),
            );
          },
        );
        break;
      default:
    }
  }

  void showSnackBar(String content) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(content),
        duration: Duration(milliseconds: 1500),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 131, 129, 129),
      body: SafeArea(
        child: SizedBox(
          width: double.infinity,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                height: 100.h,
              ),
              Image.asset(
                "images/newLogo.png",
                width: 250.w,
                height: 200.h,
                fit: BoxFit.cover,
                filterQuality: FilterQuality.high,
              ),
              Text(
                'مرحبا بك',
                style: GoogleFonts.tajawal(
                  fontSize: 40.sp,
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
                'في \n هوم كويت',
                textAlign: TextAlign.center,
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
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(
                height: 150.h,
              ),
              ElevatedButton(
                onPressed: () async {
                  // final isLoaded = await interstitialAd.isLoaded;
                  // if (isLoaded ?? false) {
                  //   interstitialAd.show();
                  // } else {
                  //   // showSnackBar('Interstitial ad is still loading...');
                  // }
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
                onPressed: () async {
                  Get.to(() => HomeScreen(), arguments: "0");

                  // final isLoaded = await interstitialAd1.isLoaded;
                  // if (isLoaded ?? false) {
                  //   interstitialAd1.show();
                  // } else {
                  //   // showSnackBar('Interstitial ad is still loading...');
                  // }
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

        // child: Container(
        //   decoration: BoxDecoration(
        //     image: DecorationImage(
        //       image: AssetImage(
        //         'images/close-up-businessman-holding-briefcase.png',
        //       ),
        //       fit: BoxFit.fill,
        //     ),
        //   ),
        //   padding: EdgeInsets.symmetric(horizontal: 16.w),
        //   width: 375.w,
        //   height: 812.h,
        //   child: Column(
        //     crossAxisAlignment: CrossAxisAlignment.start,
        //     children: [
        //       SizedBox(
        //         height: 179.h,
        //       ),
        //       Column(
        //         crossAxisAlignment: CrossAxisAlignment.start,
        //         children: [
        //           Text(
        //             'مرحبا بك',
        //             style: GoogleFonts.tajawal(
        //               fontSize: 46.sp,
        //               fontWeight: FontWeight.bold,
        //               color: Color(0xffFED235),
        //               shadows: [
        //                 BoxShadow(
        //                   color: Color(0XFF707070),
        //                   blurRadius: 6,
        //                   offset: Offset(0, 3),
        //                 ),
        //               ],
        //             ),
        //           ),
        //           Text(
        //             'في مدينة \nالكويت السكنية',
        //             style: GoogleFonts.tajawal(
        //               fontSize: 30.sp,
        //               color: Colors.black,
        //               shadows: [
        //                 BoxShadow(
        //                   color: Color(0XFF707070),
        //                   blurRadius: 6,
        //                   offset: Offset(0, 3),
        //                 ),
        //               ],
        //               fontWeight: FontWeight.bold,
        //             ),
        //           ),
        //         ],
        //       ),
        //       SizedBox(
        //         height: 264.h,
        //       ),
        //       ElevatedButton(
        //         onPressed: () {
        //           Get.to(() => LoginScreen());
        //         },
        //         child: Text(
        //           'تسجيل الدخول',
        //           style: GoogleFonts.tajawal(
        //             fontSize: 18.sp,
        //             fontWeight: FontWeight.bold,
        //             color: Color(0XFFFED235),
        //           ),
        //         ),
        //         style: ElevatedButton.styleFrom(
        //           minimumSize: Size(343.w, 47.h),
        //           backgroundColor: Colors.transparent,
        //           shadowColor: Colors.transparent,
        //           shape: RoundedRectangleBorder(
        //             side: BorderSide(
        //               color: Color(0XFFFED235),
        //             ),
        //             borderRadius: BorderRadius.circular(8.r),
        //           ),
        //           alignment: Alignment.center,
        //         ),
        //       ),
        //       SizedBox(
        //         height: 20.h,
        //       ),
        //       ElevatedButton(
        //         onPressed: () {
        //           Get.to(() => HomeScreen(), arguments: "0");
        //         },
        //         child: Text(
        //           "تصفح",
        //           style: GoogleFonts.tajawal(
        //             fontSize: 18.sp,
        //             fontWeight: FontWeight.bold,
        //             color: Colors.white,
        //           ),
        //         ),
        //         style: ElevatedButton.styleFrom(
        //           minimumSize: Size(343.w, 47.h),
        //           backgroundColor: Color(0XFFFED235),
        //           shadowColor: Colors.transparent,
        //           shape: RoundedRectangleBorder(
        //             side: BorderSide(
        //               color: Color(0XFFFED235),
        //             ),
        //             borderRadius: BorderRadius.circular(8.r),
        //           ),
        //           alignment: Alignment.center,
        //         ),
        //       )
        //     ],
        //   ),
        // ),
      ),
    );
  }
}

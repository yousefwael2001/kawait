import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../Models/ad.dart';
import '../../../../Shared preferences/shared_preferences.dart';
import '../../../Auth/Auth_Screen.dart';
import '../../../OnBoardingScreen/OnBoardingScreen.dart';
import '../../Home_Screen.dart';

class AdsScreen extends StatefulWidget {
  const AdsScreen({super.key});

  @override
  State<AdsScreen> createState() => _AdsScreenState();
}

class _AdsScreenState extends State<AdsScreen> {
  Future<List<Ad>> _loadAds() async {
    try {
      QuerySnapshot querySnapshot =
          await FirebaseFirestore.instance.collection('ads').get();

      List<Ad> ads = querySnapshot.docs.map((doc) {
        return Ad.fromMap(doc.data() as Map<String, dynamic>, doc.id);
      }).toList();

      return ads;
    } catch (error) {
      // Handle Firestore read error here
      print('Firestore read error: $error');
      return [];
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: FutureBuilder(
          future: _loadAds(),
          builder: (BuildContext context, AsyncSnapshot<List<Ad>> snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(
                child: SpinKitFadingCircle(
                  color: Colors.blue,
                  size: 80.0,
                ),
              );
            } else if (snapshot.hasError) {
              // If an error occurs while loading, display an error message.
              return Center(child: Text('Error: ${snapshot.error}'));
            } else {
              // If the data is loaded successfully, display the list of ads.
              dynamic ads = snapshot.data;

              if (ads!.isNotEmpty) {
                int randomIndex = Random().nextInt(ads.length);
                Ad randomValue = ads[randomIndex];

                return Column(
                  children: [
                    Container(
                      child: Column(
                        children: [
                          Image.network(
                            randomValue.imageUrl,
                            height: 650.h,
                            width: double.infinity,
                            fit: BoxFit.fill,
                          ),
                          SizedBox(
                            height: 40.h,
                          ),
                          ElevatedButton(
                            onPressed: () async {
                              AppSettingsPreferences().state == "1"
                                  ? AppSettingsPreferences().id == null ||
                                          AppSettingsPreferences().id == ""
                                      ? Get.off(AuthScreen(),
                                          transition: Transition.circularReveal)
                                      : Get.to(HomeScreen(), arguments: "1")
                                  : Get.off(OnBoardingScreen(),
                                      transition: Transition.circularReveal);
                            },
                            child: Text(
                              "استمر الى التطبيق",
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
                    )
                  ],
                );
              } else {
                return Container(
                  margin: EdgeInsets.symmetric(
                    horizontal: 15.w,
                    vertical: 15.h,
                  ),
                  height: 151.h,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8.0.r),
                    color: Color(0xffF8F8F7),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.5), // Shadow color
                        spreadRadius: 2, // How far the shadow spreads
                        blurRadius: 10, // Soften the shadow
                        offset: Offset(2, 2), // Offset in the X and Y direction
                      ),
                    ],
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.warning,
                        size: 80.r,
                        color: const Color.fromARGB(255, 201, 8, 8),
                      ),
                      SizedBox(
                        width: 15.w,
                      ),
                      Text(
                        "لا يوجد إعلانات مميزة",
                        style: GoogleFonts.tajawal(
                          fontSize: 16.sp,
                          color: const Color.fromARGB(255, 201, 8, 8),
                          fontWeight: FontWeight.bold,
                        ),
                      )
                    ],
                  ),
                );
              }
            }
          },
        ),
      ),
    );
  }
}

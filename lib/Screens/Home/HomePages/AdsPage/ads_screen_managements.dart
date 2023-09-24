import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../Models/ad.dart';
import '../../../../Models/service.dart';
import 'add_ads.dart';

class AdsManageScreen extends StatefulWidget {
  const AdsManageScreen({super.key});

  @override
  State<AdsManageScreen> createState() => _AdsManageScreenState();
}

class _AdsManageScreenState extends State<AdsManageScreen> {
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

  Future<void> _deleteAd(String adId) async {
    try {
      await FirebaseFirestore.instance.collection('ads').doc(adId).delete();
      // Reload the ads list after deleting an ad
      setState(() {
        _loadAds();
      });
    } catch (error) {
      // Handle Firestore delete error here
      print('Firestore delete error: $error');
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          backgroundColor: Color(0xffF8F8F8),
          title: Text(
            "الخدمات المميزة",
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
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Get.to(() => AddAds());
          },
          child: Icon(
            Icons.add,
            color: Colors.white,
          ),
          shape: CircleBorder(),
          backgroundColor: Colors.amber,
        ),
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
                return ListView.builder(
                  padding: EdgeInsets.only(top: 30.h),
                  itemCount: ads!.length,
                  itemBuilder: (context, index) {
                    return Container(
                      height: 300.h,
                      margin: EdgeInsets.symmetric(horizontal: 50.w),
                      child: Column(
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(10.r),
                            child: Image.network(
                              ads[index].imageUrl,
                              width: 300.w,
                              height: 200.h,
                              fit: BoxFit.fill,
                            ),
                          ),
                          SizedBox(
                            height: 10.h,
                          ),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "العنوان: ",
                                style: GoogleFonts.tajawal(
                                  fontSize: 17.sp,
                                  color: Colors.black,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              SizedBox(
                                width: 150.w,
                                child: Text(
                                  ads[index].title,
                                  style: GoogleFonts.tajawal(
                                    fontSize: 17.sp,
                                    color: Colors.black,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                              Spacer(),
                              InkWell(
                                onTap: () async {
                                  await _deleteAd(ads[index].id);
                                },
                                child: Icon(
                                  Icons.delete_outline_outlined,
                                  color: Colors.red,
                                  size: 30,
                                ),
                              )
                            ],
                          ),
                          Row(
                            children: [
                              Text(
                                "الوصف: ",
                                style: GoogleFonts.tajawal(
                                  fontSize: 17.sp,
                                  color: Colors.black,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              Text(
                                ads[index].description,
                                style: GoogleFonts.tajawal(
                                  fontSize: 17.sp,
                                  color: Colors.black,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ],
                          )
                        ],
                      ),
                    );
                  },
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

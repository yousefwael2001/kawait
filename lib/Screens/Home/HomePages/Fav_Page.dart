import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class FavPage extends StatefulWidget {
  const FavPage({super.key});

  @override
  State<FavPage> createState() => _FavPageState();
}

class _FavPageState extends State<FavPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Color(0xffF8F8F8),
        title: Text(
          "المفضلة",
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
        color: Colors.white,
        child: Padding(
          padding: EdgeInsets.only(top: 23.h),
          child: ListView.builder(
            itemBuilder: (context, index) {
              return Stack(
                children: [
                  Container(
                    decoration: BoxDecoration(color: Color(0xffF9F9F9)),
                    margin:
                        EdgeInsets.only(right: 15.w, left: 15.w, bottom: 10.h),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Image.asset(
                          "images/buoyant-successful-handyman-posing-against-white-wall.png",
                        ),
                        SizedBox(
                          width: 12.w,
                        ),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              SizedBox(
                                height: 18.h,
                              ),
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Text(
                                    "اسم الخدمة",
                                    style: GoogleFonts.tajawal(
                                      fontSize: 16.sp,
                                      fontWeight: FontWeight.w400,
                                    ),
                                  ),
                                  SizedBox(
                                    width: 10.w,
                                  ),
                                  Text(
                                    "التصنيف",
                                    style: GoogleFonts.tajawal(
                                      fontSize: 9.sp,
                                      color: Color(0xff6D6D6D),
                                    ),
                                  )
                                ],
                              ),
                              SizedBox(
                                height: 11.h,
                              ),
                              Text(
                                "وصف صغير لخدمة",
                                style: GoogleFonts.tajawal(
                                  fontSize: 10.sp,
                                ),
                              ),
                              SizedBox(
                                height: 9.h,
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment
                                    .start, // Move this row to the left
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Icon(
                                    Icons.star,
                                    color: Color(0xffFED235),
                                    size: 24.r,
                                  ),
                                  SizedBox(
                                    width: 5.w,
                                  ),
                                  Text(
                                    "4.9",
                                    style: GoogleFonts.tajawal(
                                      fontSize: 8.sp,
                                      color: Color(0xff576D8B),
                                    ),
                                  ),
                                  SizedBox(
                                    width: 3.w,
                                  ),
                                  Text(
                                    "(120)",
                                    style: GoogleFonts.tajawal(
                                      fontSize: 10.sp,
                                      color: Color(0xff707070),
                                    ),
                                  ),
                                  Spacer(),
                                  Text(
                                    "د.ك50",
                                    style: GoogleFonts.tajawal(
                                      fontWeight: FontWeight.bold,
                                      color: Color(0xffFED235),
                                    ),
                                  ),
                                  SizedBox(
                                    width: 15.w,
                                  )
                                ],
                              )
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 30.w, top: 10.4.h),
                    child: Align(
                      alignment: Alignment.topLeft,
                      child: Icon(
                        Icons.favorite,
                        color: Color(0XFFFF1E1E),
                      ),
                    ),
                  )
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:kawait/Screens/Home/HomePages/CategoryPageScreens/services_category.dart';

class FurniturePage extends StatefulWidget {
  const FurniturePage({super.key});

  @override
  State<FurniturePage> createState() => _FurniturePageState();
}

class Item {
  final String name;
  final String imageUrl;

  Item({required this.name, required this.imageUrl});
}

class _FurniturePageState extends State<FurniturePage> {
  List<Item> items = [
    Item(name: 'نشتري الأثاث المستعمل', imageUrl: 'images/Group 41602.png'),
    Item(name: 'أثاث منزلي', imageUrl: 'images/Group 46920.png'),
    Item(name: "أثاث مكتبي", imageUrl: 'images/Group 47018.png'),
    Item(name: "تنجيد", imageUrl: 'images/Group 47092.png'),
    Item(name: "المفروشات", imageUrl: 'images/Group 47018.png'),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Color(0xffF8F8F8),
        title: Text(
          "التصنيفات",
          style: GoogleFonts.tajawal(
            fontSize: 17.sp,
            color: Colors.black,
            fontWeight: FontWeight.w600,
          ),
        ),
        leading: IconButton(
          onPressed: () {
            Get.back();
          },
          icon: Icon(
            Icons.arrow_back_ios,
            color: Colors.black,
          ),
        ),
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
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 22.h,
            ),
            Padding(
              padding: EdgeInsets.only(right: 16.w),
              child: Text(
                "عقارات",
                style: GoogleFonts.tajawal(
                    fontSize: 17.sp, fontWeight: FontWeight.bold),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(right: 16.w, top: 6.h, bottom: 16.h),
              child: Text(
                "أحصل على أفضل الخدمات",
                style: GoogleFonts.tajawal(
                  fontSize: 12.sp,
                ),
              ),
            ),
            Expanded(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.w),
                child: GridView.builder(
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3, // Number of items in each row
                    crossAxisSpacing: 8.0, // Spacing between columns
                    mainAxisSpacing: 8.0, // Spacing between rows
                    mainAxisExtent: 150.h,
                  ),
                  itemCount: items.length,
                  itemBuilder: (context, index) {
                    return InkWell(
                      onTap: () {
                        Get.to(
                            ServiceCategory(Category_Name: items[index].name));
                      },
                      child: SizedBox(
                        height: 134.h,
                        width: 107.w,
                        child: Column(
                          children: [
                            Container(
                              height: 113.h,
                              width: 107.w,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8.r),
                                color: Color(0XFFF4F4F4),
                              ),
                              child: Image.asset(items[index].imageUrl),
                            ),
                            SizedBox(
                              height: 5.h,
                            ),
                            Text(
                              items[index].name,
                              style: GoogleFonts.tajawal(
                                fontSize: 12.sp,
                                fontWeight: FontWeight.normal,
                              ),
                              textAlign: TextAlign.center,
                            )
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:kawait/Screens/Home/HomePages/CategoryPageScreens/services_category.dart';

import 'service_subcategory_page.dart';

class ConstructionPage extends StatefulWidget {
  const ConstructionPage({super.key});

  @override
  State<ConstructionPage> createState() => _ConstructionPageState();
}

class Item {
  final String name;
  final String imageUrl;

  Item({required this.name, required this.imageUrl});
}

class _ConstructionPageState extends State<ConstructionPage> {
  List<Item> items = [
    Item(name: 'مقاول صحي', imageUrl: 'images/Group 43872.png'),
    Item(name: "الأقفال", imageUrl: 'images/Group 44255.png'),
    Item(name: "تسليك مجاري", imageUrl: 'images/Group 44257.png'),
    Item(name: "التكييف", imageUrl: 'images/Group 44405.png'),
    Item(name: "أصباغ", imageUrl: 'images/Group 44431.png'),
    Item(name: 'أعمال الديكور', imageUrl: 'images/Group 44652.png'),
    Item(name: "مشاتل وحدائق", imageUrl: 'images/Group 45442.png'),
    Item(name: "صيانة أجهزة منزلية", imageUrl: 'images/Group 45444.png'),
    Item(name: 'خزانات مياه', imageUrl: 'images/Group 55868.png'),
    Item(name: 'حدادة', imageUrl: 'images/Group 45845.png'),
    Item(name: 'مقاولات بناء', imageUrl: 'images/Group 45905.png'),
    Item(name: "كاشي وسيراميك", imageUrl: 'images/Group 46044.png'),
    Item(name: 'فني زجاج', imageUrl: 'images/Group 46175.png'),
    Item(name: 'عازل', imageUrl: 'images/Group 46192.png'),
    Item(name: 'مقاول كهرباء', imageUrl: 'images/Group 46692.png'),
    Item(name: 'نجار', imageUrl: 'images/Group 46877.png'),
    Item(name: 'منتجات زراعية', imageUrl: 'images/Group 46962.png'),
    Item(name: 'مواد بناء', imageUrl: 'images/Group 46919.png'),
    Item(name: 'أعمال التهوية', imageUrl: 'images/Group 46922.png'),
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
                "مقاولات",
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
                        Get.to(ServiceSubCategoryPage(
                            Category_Name: items[index].name));
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

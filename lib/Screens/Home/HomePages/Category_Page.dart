import 'package:carousel_slider/carousel_slider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:kawait/Screens/Home/HomePages/CategoryPageScreens/Furniture_Page.dart';
import 'package:kawait/Screens/Home/HomePages/CategoryPageScreens/Real_Estates_Page.dart';
import 'package:kawait/Screens/Home/HomePages/CategoryPageScreens/services_category.dart';

import 'CategoryPageScreens/Construction_Page.dart';
import 'HomePageScreens/service_page.dart';

class CategoryPage extends StatefulWidget {
  const CategoryPage({super.key});

  @override
  State<CategoryPage> createState() => _CategoryPageState();
}

final List<String> imgList = [
  'images/plumber-making-ok-sign.png',
  "images/plumber-making-ok-sign.png",
  "images/plumber-making-ok-sign.png",
  "images/plumber-making-ok-sign.png",
  "images/plumber-making-ok-sign.png",
];

class Item {
  final String name;
  final String imageUrl;

  Item({required this.name, required this.imageUrl});
}

class _CategoryPageState extends State<CategoryPage> {
  int _current = 0;

  final CarouselController _controller = CarouselController();
  final List<Widget> imageSliders = imgList
      .map(
        (item) => Container(
          height: 150.h,
          padding: EdgeInsets.only(left: 10.w),
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
            // crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                margin: EdgeInsets.only(left: 21.w),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8.0.r),
                  border: Border.all(
                    color: Color(0xffFED235),
                  ),
                ),
                child: Image.asset(
                  "images/plumber-making-ok-sign.png",
                  height: 150.h,
                  width: 133.w,
                  fit: BoxFit.cover,
                ),
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: EdgeInsets.only(top: 11.5.h),
                      child: Row(
                        children: [
                          Image.asset("images/NoPath.png"),
                          SizedBox(
                            width: 7.w,
                          ),
                          Text(
                            "شركة احمد محسن",
                            style: GoogleFonts.tajawal(
                              fontSize: 10.sp,
                              color: Colors.black,
                            ),
                          ),
                          SizedBox(
                            width: 58.w,
                          ),
                          Icon(Icons.favorite_border)
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 8.5.h,
                    ),
                    SizedBox(
                      width: 123.w,
                      child: Text(
                        "خدمات تصليح مكيفات وسباكة\nالبيت والعديد من الخدمات",
                        style: GoogleFonts.tajawal(
                          fontSize: 10.sp,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 8.5.h,
                    ),
                    Text(
                      "خصومات تصل ل",
                      style: GoogleFonts.tajawal(
                        fontSize: 10.sp,
                      ),
                    ),
                    Text(
                      "70%",
                      style: GoogleFonts.tajawal(
                        fontSize: 16.sp,
                        color: Color(0xffFED235),
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Row(
                      mainAxisAlignment:
                          MainAxisAlignment.end, // Move this row to the left
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
                      ],
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      )
      .toList();

  List<Item> items = [
    Item(name: 'مقاولات', imageUrl: 'images/Group 41602.png'),
    Item(name: 'عقارات', imageUrl: 'images/Group 41603.png'),
    Item(name: 'خدمات عقارية', imageUrl: 'images/Group 41638.png'),
    Item(name: 'نقل عفش', imageUrl: 'images/Group 41695.png'),
    Item(name: 'أثاث ومفروشات', imageUrl: 'images/Group 41696.png'),
    Item(name: 'عمالة منزلية', imageUrl: 'images/Group 41951.png'),
    Item(name: 'التنظيف', imageUrl: 'images/Group 41947.png'),
    Item(name: 'خدمات توصيل', imageUrl: 'images/Group 42084.png'),
    Item(name: 'رخص تجارية', imageUrl: 'images/Group 42085.png'),
    Item(name: 'معدات ثقيلة', imageUrl: 'images/Group 42108.png'),
    Item(name: 'معدات مهنية', imageUrl: 'images/Group 42496.png'),
    Item(name: 'تأجير معدات', imageUrl: 'images/Group 42616.png'),
    Item(name: 'تأجير وبيع مولدات', imageUrl: 'images/Illustration.png'),
    Item(name: 'محركات واليات', imageUrl: 'images/Group 42694.png'),
    Item(name: 'أجهزة الكترونية', imageUrl: 'images/Group 42837.png'),
    Item(name: 'كاميرات مراقبة', imageUrl: 'images/04.png'),
    Item(name: 'ستلايت', imageUrl: 'images/Group 43618.png'),
    Item(name: 'خدمات اعلانية', imageUrl: 'images/Artboard – 1.png'),
    Item(name: 'تنقيب ومعاملات', imageUrl: 'images/Group 43661.png'),
    Item(name: 'متفرقات', imageUrl: 'images/12.png'),
    Item(name: 'مكافحة حشرات', imageUrl: 'images/Group 43830.png'),
    Item(name: 'خدمات مختلفة', imageUrl: 'images/Group 43811.png'),
  ];

  Future<List<Map<String, dynamic>>>? _productsFuture;

  Future<List<Map<String, dynamic>>> getAllProducts() async {
    List<Map<String, dynamic>> productsList = [];

    try {
      QuerySnapshot querySnapshot =
          await FirebaseFirestore.instance.collectionGroup('products').get();

      for (QueryDocumentSnapshot doc in querySnapshot.docs) {
        Map<String, dynamic>? productData = doc.data() as Map<String, dynamic>?;

        if (productData != null) {
          String? categoryId =
              productData['categoryId']; // Use String? instead of String

          if (categoryId != null) {
            DocumentSnapshot categorySnapshot = await FirebaseFirestore.instance
                .collection('categories')
                .doc(categoryId)
                .get();

            Map<String, dynamic>? categoryData =
                categorySnapshot.data() as Map<String, dynamic>?;

            if (categoryData != null) {
              productData['categoryName'] = categoryData['name'];
            }
          }

          productsList.add(productData);
        }
      }
    } catch (e) {
      print('Error fetching products: $e');
    }

    return productsList;
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _productsFuture = getAllProducts();
  }

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
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            FutureBuilder<List<Map<String, dynamic>>>(
                future: _productsFuture,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(
                      child: SpinKitFadingCircle(
                        color: Colors.blue,
                        size: 80.0,
                      ),
                    );
                  } else if (snapshot.hasError) {
                    return Text('Error: ${snapshot.error}');
                  } else {
                    List<Map<String, dynamic>> productList = snapshot.data ??
                        []; // Get the list of products or an empty list if null.

                    final List<Widget> imageSliders = productList
                        .map(
                          (item) => InkWell(
                            onTap: () {
                              Get.to(() => ServicePage(
                                    service_data: item,
                                  ));
                            },
                            child: Container(
                              height: 150.h,
                              padding: EdgeInsets.only(left: 10.w),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8.0.r),
                                color: Color(0xffF8F8F7),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.grey
                                        .withOpacity(0.5), // Shadow color
                                    spreadRadius:
                                        2, // How far the shadow spreads
                                    blurRadius: 10, // Soften the shadow
                                    offset: Offset(2,
                                        2), // Offset in the X and Y direction
                                  ),
                                ],
                              ),
                              child: Row(
                                // crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                    margin: EdgeInsets.only(left: 21.w),
                                    decoration: BoxDecoration(
                                      borderRadius:
                                          BorderRadius.circular(8.0.r),
                                      border: Border.all(
                                        color: Color(0xffFED235),
                                      ),
                                    ),
                                    child: Image.asset(
                                      "images/plumber-making-ok-sign.png",
                                      height: 150.h,
                                      width: 133.w,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Padding(
                                          padding: EdgeInsets.only(top: 11.5.h),
                                          child: Row(
                                            children: [
                                              Image.asset("images/NoPath.png"),
                                              SizedBox(
                                                width: 7.w,
                                              ),
                                              Text(
                                                item["user_companyName"],
                                                style: GoogleFonts.tajawal(
                                                  fontSize: 10.sp,
                                                  color: Colors.black,
                                                ),
                                              ),
                                              SizedBox(
                                                width:
                                                    item["user_companyName"] ==
                                                            ""
                                                        ? 135.w
                                                        : 58.w,
                                              ),
                                            ],
                                          ),
                                        ),
                                        SizedBox(
                                          height: 8.5.h,
                                        ),
                                        SizedBox(
                                          width: 123.w,
                                          child: Text(
                                            item["longDescription"],
                                            style: GoogleFonts.tajawal(
                                              fontSize: 10.sp,
                                            ),
                                          ),
                                        ),
                                        SizedBox(
                                          height: 8.5.h,
                                        ),
                                        Text(
                                          "خصومات تصل ل",
                                          style: GoogleFonts.tajawal(
                                            fontSize: 10.sp,
                                          ),
                                        ),
                                        Text(
                                          "70%",
                                          style: GoogleFonts.tajawal(
                                            fontSize: 16.sp,
                                            color: Color(0xffFED235),
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        )
                        .toList();
                    if (productList.isNotEmpty) {
                      return AnimationConfiguration.staggeredList(
                        position: 0,
                        duration: const Duration(milliseconds: 500),
                        child: SlideAnimation(
                          verticalOffset: 50.0,
                          child: FadeInAnimation(
                            child: Padding(
                              padding: EdgeInsets.only(
                                  top: 22.h,
                                  right: 16.w,
                                  left: 16.w,
                                  bottom: 10.h),
                              child: CarouselSlider(
                                carouselController: _controller,
                                items: imageSliders,
                                //Slider Container properties
                                options: CarouselOptions(
                                  height: 151.0,
                                  autoPlay: true,
                                  aspectRatio: 16 / 9,
                                  autoPlayCurve: Curves.fastOutSlowIn,
                                  enableInfiniteScroll: true,
                                  autoPlayAnimationDuration:
                                      Duration(milliseconds: 800),
                                  viewportFraction: 1.0,
                                  enlargeCenterPage: false,
                                  onPageChanged: (index, reason) {
                                    setState(() {
                                      _current = index;
                                    });
                                  },
                                ),
                              ),
                            ),
                          ),
                        ),
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
                              color:
                                  Colors.grey.withOpacity(0.5), // Shadow color
                              spreadRadius: 2, // How far the shadow spreads
                              blurRadius: 10, // Soften the shadow
                              offset: Offset(
                                  2, 2), // Offset in the X and Y direction
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
                              "لا يوجد عروض",
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
                }),
            FutureBuilder<List<Map<String, dynamic>>>(
                future: _productsFuture,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(
                      child: SpinKitFadingCircle(
                        color: Colors.blue,
                        size: 80.0,
                      ),
                    );
                  } else if (snapshot.hasError) {
                    return Text('Error: ${snapshot.error}');
                  } else {
                    List<Map<String, dynamic>> productList = snapshot.data ??
                        []; // Get the list of products or an empty list if null.
                    if (productList.isNotEmpty) {
                      return Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: productList.asMap().entries.map((entry) {
                          return GestureDetector(
                            onTap: () => _controller.animateToPage(entry.key),
                            child: Container(
                              width: 16.w,
                              height: 3.h,
                              margin: EdgeInsets.symmetric(
                                  vertical: 8.0, horizontal: 4.0),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(3.r),
                                color: _current == entry.key
                                    ? Color(0xffFED235)
                                    : Color(0xffD5D5D5),
                              ),
                            ),
                          );
                        }).toList(),
                      );
                    } else {
                      return SizedBox();
                    }
                  }
                }),
            Padding(
              padding: EdgeInsets.only(right: 16.w),
              child: Text(
                "أختر الخدمة",
                style: GoogleFonts.tajawal(
                    fontSize: 17.sp, fontWeight: FontWeight.bold),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(right: 16.w, top: 6.h, bottom: 16.h),
              child: Text(
                "ثم أحصل على أفضل عروض الأسعار من مزودي الخدمة",
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
                    return AnimationConfiguration.staggeredList(
                      position: 0,
                      duration: const Duration(milliseconds: 500),
                      child: SlideAnimation(
                        verticalOffset: 50.0,
                        child: FadeInAnimation(
                          child: InkWell(
                            onTap: () {
                              if (index == 0) {
                                Get.to(() => ConstructionPage());
                              } else if (index == 1) {
                                Get.to(() => RealEstatesPage());
                              } else if (index == 4) {
                                Get.to(() => FurniturePage());
                              } else {
                                Get.to(
                                  () => ServiceCategory(
                                    Category_Name: items[index].name,
                                  ),
                                );
                              }
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
                          ),
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

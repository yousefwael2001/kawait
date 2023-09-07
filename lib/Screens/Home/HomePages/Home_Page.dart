import 'package:carousel_slider/carousel_slider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:kawait/Screens/Home/HomePages/HomePageScreens/service_page.dart';
import 'package:kawait/fb-controllers/fb_fire_store_controller.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
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

class _HomePageState extends State<HomePage> {
  int _current = 0;
  final CarouselController _controller = CarouselController();
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
    Item(name: 'خدمات مختلفة', imageUrl: 'images/Group 43811.png'),
  ];

  String filter = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.white,
        title: Column(
          children: [
            Image.asset(
              "images/Group 41472.png",
              height: 36.h,
              width: 51.w,
              fit: BoxFit.cover,
            ),
            SizedBox(
              height: 5.h,
            ),
            Text(
              "مدينة الكويت السكنية",
              style: GoogleFonts.tajawal(
                fontSize: 9.sp,
                color: Colors.black,
              ),
              textAlign: TextAlign.center,
            )
          ],
        ),
        leadingWidth: 90.w,
        leading: Center(
          child: Text(
            "الرئيسية",
            style: GoogleFonts.tajawal(
              fontSize: 17.sp,
              color: Colors.black,
              fontWeight: FontWeight.w600,
            ),
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
        toolbarHeight: 80.h,
      ),
      body: Container(
        color: Colors.white,
        child: Column(
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
                                    child: item["imageUrls"][0] == null
                                        ? Image.asset(
                                            "images/plumber-making-ok-sign.png",
                                            height: 150.h,
                                            width: 133.w,
                                            fit: BoxFit.cover,
                                          )
                                        : Image.network(
                                            item["imageUrls"][0],
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
                      return Padding(
                        padding: EdgeInsets.only(
                            top: 22.h, right: 16.w, left: 16.w, bottom: 10.h),
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
            Container(
              height: 35.h,
              margin: EdgeInsets.only(top: 22.h, bottom: 20.h),
              child: Row(
                children: [
                  Container(
                    width: 110.w,
                    margin: EdgeInsets.only(right: 15.w),
                    decoration: BoxDecoration(
                      color: Color(0xffFED235).withOpacity(.7),
                      borderRadius: BorderRadius.circular(15.r),
                    ),
                    padding: EdgeInsets.symmetric(horizontal: 2.w),
                    child: Row(
                      children: [
                        Text(
                          "النوع",
                          style: GoogleFonts.tajawal(fontSize: 10.sp),
                        ),
                        SizedBox(
                          width: 1.w,
                        ),
                        Text(
                          filter,
                          style: GoogleFonts.tajawal(fontSize: 9.sp),
                        ),
                        Icon(Icons.navigate_next_outlined)
                      ],
                    ),
                  ),
                  Expanded(
                    child: ListView.builder(
                      padding: EdgeInsets.all(0),
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (context, index) {
                        return InkWell(
                          onTap: () {
                            setState(() {
                              filter = items[index].name;
                            });
                          },
                          child: Padding(
                            padding: EdgeInsets.only(right: 31.w),
                            child: Center(
                                child: Text(
                              items[index].name,
                              style: GoogleFonts.tajawal(
                                fontSize: 14.sp,
                                fontWeight: FontWeight.w500,
                              ),
                            )),
                          ),
                        );
                      },
                      itemCount: items.length,
                    ),
                  ),
                  SizedBox(
                    width: 16.w,
                  )
                ],
              ),
            ),
            Expanded(
              child: FutureBuilder(
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
                      List<Map<String, dynamic>> products =
                          snapshot.data as List<Map<String, dynamic>>;
                      List<Map<String, dynamic>> filteredProducts = filter
                              .isEmpty
                          ? products // If filter is empty, show all products
                          : products
                              .where((product) =>
                                  product['categoryName'] == filter)
                              .toList(); // Show products with matching category name
                      if (products.isNotEmpty) {
                        return ListView.builder(
                          padding: EdgeInsets.all(0),
                          shrinkWrap: true,
                          physics: ClampingScrollPhysics(),
                          itemBuilder: (context, index) {
                            Map<String, dynamic> productData =
                                filteredProducts[index];
                            List<String> imageUrls =
                                List.castFrom<dynamic, String>(
                                    productData['imageUrls'] ?? []);

                            return Stack(
                              children: [
                                Container(
                                  decoration:
                                      BoxDecoration(color: Color(0xffF9F9F9)),
                                  margin: EdgeInsets.only(
                                      right: 15.w, left: 15.w, bottom: 10.h),
                                  child: Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      imageUrls.length == 0
                                          ? Image.asset(
                                              "images/buoyant-successful-handyman-posing-against-white-wall.png",
                                            )
                                          : SizedBox(
                                              width: 125.w,
                                              height: 95.h,
                                              child: ClipRRect(
                                                borderRadius: BorderRadius.only(
                                                  topRight:
                                                      Radius.circular(8.r),
                                                  bottomRight:
                                                      Radius.circular(8.r),
                                                ),
                                                child: Image.network(
                                                  imageUrls[0],
                                                  width: 70.w,
                                                  height: 50.h,
                                                  fit: BoxFit.cover,
                                                ),
                                              ),
                                            ),
                                      SizedBox(
                                        width: 12.w,
                                      ),
                                      Expanded(
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          children: [
                                            SizedBox(
                                              height: 18.h,
                                            ),
                                            Row(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.center,
                                              children: [
                                                Text(
                                                  productData['name'],
                                                  style: GoogleFonts.tajawal(
                                                    fontSize: 16.sp,
                                                    fontWeight: FontWeight.w400,
                                                  ),
                                                ),
                                                SizedBox(
                                                  width: 10.w,
                                                ),
                                                Text(
                                                  productData['categoryName'] ==
                                                          null
                                                      ? ""
                                                      : productData[
                                                          'categoryName'],
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
                                              productData['shortDescription'] ==
                                                      null
                                                  ? ""
                                                  : productData[
                                                      'shortDescription'],
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
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.center,
                                              children: [
                                                Spacer(),
                                                Text(
                                                  productData['price'] == null
                                                      ? ""
                                                      : productData['price'] +
                                                          "د.ك",
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
                                  padding:
                                      EdgeInsets.only(left: 30.w, top: 10.4.h),
                                  child: Align(
                                    alignment: Alignment.topLeft,
                                    child: InkWell(
                                      onTap: () async {
                                        await FbFireStoreController()
                                            .addtoFav(productData, context);
                                      },
                                      child: Icon(
                                        Icons.favorite_border,
                                        color: Color(0XFFFF1E1E),
                                      ),
                                    ),
                                  ),
                                )
                              ],
                            );
                          },
                          itemCount: filteredProducts.length,
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
                                color: Colors.grey
                                    .withOpacity(0.5), // Shadow color
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
                                "لا يوجد خدمات",
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
            ),
            SizedBox(
              height: 55.h,
            ),
          ],
        ),
      ),
    );
  }
}

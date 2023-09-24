import 'package:carousel_slider/carousel_slider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:kawait/Screens/Home/HomePages/CategoryPageScreens/Furniture_Page.dart';
import 'package:kawait/Screens/Home/HomePages/CategoryPageScreens/Real_Estates_Page.dart';

import '../HomePageScreens/service_image.dart';
import '../HomePageScreens/service_page.dart';

class ServiceCategory extends StatefulWidget {
  ServiceCategory({super.key, required this.Category_Name});
  final String Category_Name;
  @override
  State<ServiceCategory> createState() => _ServiceCategoryState();
}

class Item {
  final String name;
  final String imageUrl;

  Item({required this.name, required this.imageUrl});
}

class _ServiceCategoryState extends State<ServiceCategory> {
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
      backgroundColor: Colors.white,
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Color(0xffF8F8F8),
        title: Text(
          widget.Category_Name,
          style: GoogleFonts.tajawal(
            fontSize: 17.sp,
            color: Colors.black,
            fontWeight: FontWeight.w600,
          ),
        ),
        leadingWidth: 90.w,
        leading: IconButton(
          icon: Transform.rotate(
            angle: -3.14,
            child: Icon(
              Icons.arrow_back_ios_new,
              color: Colors.black,
            ),
          ),
          onPressed: () {
            Get.back();
          },
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
      body: FutureBuilder(
          future: _productsFuture,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return Text('Error: ${snapshot.error}');
            } else {
              List<Map<String, dynamic>> products =
                  snapshot.data as List<Map<String, dynamic>>;
              List<Map<String, dynamic>> filteredProducts = widget
                      .Category_Name.isEmpty
                  ? products // If filter is empty, show all products
                  : products
                      .where((product) =>
                          product['categoryName'] == widget.Category_Name)
                      .toList(); // Show products with matching category name
              if (filteredProducts.isNotEmpty) {
                return ListView.builder(
                  padding: EdgeInsets.only(top: 20.h),
                  shrinkWrap: true,
                  physics: ClampingScrollPhysics(),
                  itemBuilder: (context, index) {
                    Map<String, dynamic> productData = filteredProducts[index];
                    List<String> imageUrls = List.castFrom<dynamic, String>(
                        productData['imageUrls'] ?? []);

                    return Stack(
                      children: [
                        InkWell(
                          onTap: () {
                            Get.to(() => ServicePage(
                                  service_data: productData,
                                ));
                          },
                          child: Container(
                            decoration: BoxDecoration(color: Color(0xffF9F9F9)),
                            margin: EdgeInsets.only(
                                right: 15.w, left: 15.w, bottom: 10.h),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
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
                                            topRight: Radius.circular(8.r),
                                            bottomRight: Radius.circular(8.r),
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
                                    mainAxisAlignment: MainAxisAlignment.start,
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
                                            productData['categoryName'] == null
                                                ? ""
                                                : productData['categoryName'],
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
                                        productData['shortDescription'] == null
                                            ? ""
                                            : productData['shortDescription'],
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
                                                : productData['price'] + "د.ك",
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
                        ),
                        Padding(
                          padding: EdgeInsets.only(left: 30.w, top: 10.4.h),
                          child: Align(
                            alignment: Alignment.topLeft,
                            child: Icon(
                              Icons.favorite_border,
                              color: Color(0XFFFF1E1E),
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
    );
  }
}

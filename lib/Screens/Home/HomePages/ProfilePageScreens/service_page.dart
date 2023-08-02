import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:kawait/Shared%20preferences/shared_preferences.dart';
import 'package:kawait/widgets/alert_dialog_widget.dart';
import 'package:kawait/widgets/list_tile_style.dart';
import 'package:kawait/widgets/text_field.dart';

class ServicePage extends StatefulWidget {
  const ServicePage({super.key});

  @override
  State<ServicePage> createState() => _ServicePageState();
}

class _ServicePageState extends State<ServicePage> {
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
          "خدماتي",
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
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 16.w),
        decoration: BoxDecoration(
          color: Colors.white,
        ),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                height: 20.h,
              ),
              Stack(
                children: [
                  CircleAvatar(
                    maxRadius: 36.r,
                    child: Image.asset(
                      'images/Ellipse 3.png',
                      fit: BoxFit.cover,
                      filterQuality: FilterQuality.high,
                    ),
                    backgroundColor: Colors.transparent,
                  ),
                  Positioned(
                    bottom: 0,
                    child: CircleAvatar(
                      radius: 15.r,
                      backgroundColor: Color(0XFFF7F7F7),
                      child: Icon(
                        Icons.add_a_photo_rounded,
                        color: Colors.black,
                        size: 18.r,
                      ),
                    ),
                  )
                ],
              ),
              SizedBox(
                height: 11.h,
              ),
              Text(
                "يوسف",
                style: GoogleFonts.tajawal(
                  fontSize: 16.sp,
                  color: Colors.black,
                ),
              ),
              SizedBox(
                height: 25.h,
              ),
              FutureBuilder(
                  future: _productsFuture,
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Center(child: CircularProgressIndicator());
                    } else if (snapshot.hasError) {
                      return Text('Error: ${snapshot.error}');
                    } else {
                      List<Map<String, dynamic>> products =
                          snapshot.data as List<Map<String, dynamic>>;
                      List<
                          Map<String,
                              dynamic>> filteredProducts = AppSettingsPreferences()
                                  .user()
                                  .id ==
                              null
                          ? products // If filter is empty, show all products
                          : products
                              .where((product) =>
                                  product['user_id'] ==
                                  AppSettingsPreferences().user().id)
                              .toList(); // Show products with matching category name
                      if (filteredProducts.isNotEmpty) {
                        return ListView.builder(
                          padding: EdgeInsets.only(top: 20.h),
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
                                  margin: EdgeInsets.only(bottom: 10.h),
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
                                    child: Icon(
                                      Icons.favorite,
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
                        return Center(
                          child: Text("لا يوجد بيانات"),
                        );
                      }
                    }
                  }),

              // Expanded(
              //   child: ListView.builder(
              //     itemBuilder: (context, index) {
              //       return Stack(
              //         children: [
              //           Container(
              //             decoration: BoxDecoration(color: Color(0xffF9F9F9)),
              //             margin: EdgeInsets.only(bottom: 10.h),
              //             child: Row(
              //               crossAxisAlignment: CrossAxisAlignment.start,
              //               children: [
              //                 Image.asset(
              //                   "images/buoyant-successful-handyman-posing-against-white-wall.png",
              //                 ),
              //                 SizedBox(
              //                   width: 12.w,
              //                 ),
              //                 Expanded(
              //                   child: Column(
              //                     crossAxisAlignment: CrossAxisAlignment.start,
              //                     mainAxisAlignment: MainAxisAlignment.start,
              //                     children: [
              //                       SizedBox(
              //                         height: 18.h,
              //                       ),
              //                       Row(
              //                         crossAxisAlignment:
              //                             CrossAxisAlignment.center,
              //                         children: [
              //                           Text(
              //                             "اسم الخدمة",
              //                             style: GoogleFonts.tajawal(
              //                               fontSize: 16.sp,
              //                               fontWeight: FontWeight.w400,
              //                             ),
              //                           ),
              //                           SizedBox(
              //                             width: 10.w,
              //                           ),
              //                           Text(
              //                             "التصنيف",
              //                             style: GoogleFonts.tajawal(
              //                               fontSize: 9.sp,
              //                               color: Color(0xff6D6D6D),
              //                             ),
              //                           )
              //                         ],
              //                       ),
              //                       SizedBox(
              //                         height: 11.h,
              //                       ),
              //                       Text(
              //                         "وصف صغير لخدمة",
              //                         style: GoogleFonts.tajawal(
              //                           fontSize: 10.sp,
              //                         ),
              //                       ),
              //                       SizedBox(
              //                         height: 9.h,
              //                       ),
              //                       Row(
              //                         mainAxisAlignment: MainAxisAlignment
              //                             .start, // Move this row to the left
              //                         crossAxisAlignment:
              //                             CrossAxisAlignment.center,
              //                         children: [
              //                           Icon(
              //                             Icons.star,
              //                             color: Color(0xffFED235),
              //                             size: 24.r,
              //                           ),
              //                           SizedBox(
              //                             width: 5.w,
              //                           ),
              //                           Text(
              //                             "4.9",
              //                             style: GoogleFonts.tajawal(
              //                               fontSize: 8.sp,
              //                               color: Color(0xff576D8B),
              //                             ),
              //                           ),
              //                           SizedBox(
              //                             width: 3.w,
              //                           ),
              //                           Text(
              //                             "(120)",
              //                             style: GoogleFonts.tajawal(
              //                               fontSize: 10.sp,
              //                               color: Color(0xff707070),
              //                             ),
              //                           ),
              //                           Spacer(),
              //                           Text(
              //                             "د.ك50",
              //                             style: GoogleFonts.tajawal(
              //                               fontWeight: FontWeight.bold,
              //                               color: Color(0xffFED235),
              //                             ),
              //                           ),
              //                           SizedBox(
              //                             width: 15.w,
              //                           )
              //                         ],
              //                       )
              //                     ],
              //                   ),
              //                 )
              //               ],
              //             ),
              //           ),
              //           Padding(
              //             padding: EdgeInsets.only(left: 30.w, top: 10.4.h),
              //             child: Align(
              //               alignment: Alignment.topLeft,
              //               child: Icon(
              //                 Icons.favorite,
              //                 color: Color(0XFFFF1E1E),
              //               ),
              //             ),
              //           )
              //         ],
              //       );
              //     },
              //   ),
              // ),
            ],
          ),
        ),
      ),
    );
  }
}

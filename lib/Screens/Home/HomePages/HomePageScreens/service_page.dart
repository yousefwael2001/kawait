import 'package:carousel_slider/carousel_slider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:kawait/Screens/Home/HomePages/HomePageScreens/service_image.dart';
import 'package:kawait/Screens/Home/HomePages/HomePageScreens/service_video.dart';
import 'package:kawait/Shared%20preferences/shared_preferences.dart';
import 'package:kawait/utils/helpers.dart';
import 'package:url_launcher/url_launcher.dart';

class ServicePage extends StatefulWidget {
  const ServicePage({super.key, required this.service_data});
  final Map<String, dynamic> service_data;
  @override
  State<ServicePage> createState() => _ServicePageState();
}

class _ServicePageState extends State<ServicePage> with Helpers {
  int _current = 0;
  final CarouselController _controller = CarouselController();

  void whatsAppOpen(String number) async {
    var url = 'http://wa.me/$number?text=مرحبا';
    await launch(url);
  }

  String? encodeQueryParameters(Map<String, String> params) {
    return params.entries
        .map((MapEntry<String, String> e) =>
            '${Uri.encodeComponent(e.key)}=${Uri.encodeComponent(e.value)}')
        .join('&');
  }

  void _composeMail() {
// #docregion encode-query-parameters
    final Uri emailLaunchUri = Uri(
      scheme: 'mailto',
      path: widget.service_data['user_email'],
      query: encodeQueryParameters(<String, String>{
        'subject': 'مرحبا',
      }),
    );

    launchUrl(emailLaunchUri);
// #enddocregion encode-query-parameters
  }

  Future<void> _sendEmail() async {
    // final Uri _emailLaunchUri = Uri(
    //   scheme: 'mailto',
    //   path: widget.service_data['user_email'],
    //   queryParameters: {
    //     'subject': 'طالب خدمة',
    //     'body': 'السلام عليكم',
    //   },
    // );

    // try {
    //   if (await canLaunchUrl(Uri.parse(_emailLaunchUri.toString()))) {
    //     await launchUrl(Uri.parse(_emailLaunchUri.toString()));
    //   } else {
    //     throw 'Could not launch email: Email app not found.';
    //   }
    // } catch (e) {
    //   print('Error launching email: $e');
    //   // Handle the error gracefully, e.g., show an error message to the user.
    // }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: SafeArea(
          child: ListView(
            children: [
              SizedBox(
                height: 0.h,
              ),
              Visibility(
                visible: widget.service_data['imageUrls'] != null,
                child: Stack(
                  children: [
                    CarouselSlider(
                      carouselController: _controller,
                      items: widget.service_data['imageUrls']
                          .map<Widget>(
                            (item) => Container(
                              width: double.infinity,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.only(
                                  bottomLeft: Radius.circular(8.r),
                                  bottomRight: Radius.circular(8.r),
                                ),
                              ),
                              child: GestureDetector(
                                onTap: () {
                                  Get.to(() => ServiceImage(
                                      service_data: widget.service_data));
                                },
                                child: ClipRRect(
                                  borderRadius: BorderRadius.only(
                                    bottomLeft: Radius.circular(15.r),
                                    bottomRight: Radius.circular(15.r),
                                  ),
                                  child: Image.network(
                                    item,
                                    fit: BoxFit.fill,
                                  ),
                                ),
                              ),
                            ),
                          )
                          .toList(),

                      //Slider Container properties
                      options: CarouselOptions(
                        height: 300.0.h,
                        autoPlay: true,
                        aspectRatio: 16 / 9,
                        autoPlayCurve: Curves.fastOutSlowIn,
                        enableInfiniteScroll: true,
                        autoPlayAnimationDuration: Duration(milliseconds: 800),
                        viewportFraction: 1.0,
                        enlargeCenterPage: false,
                        onPageChanged: (index, reason) {
                          setState(() {
                            _current = index;
                          });
                        },
                      ),
                    ),
                    Positioned(
                      bottom: 10,
                      right: 170,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: widget.service_data['imageUrls']
                            .asMap()
                            .entries
                            .map<Widget>((entry) {
                          final int index = entry.key;
                          return GestureDetector(
                            onTap: () {
                              // Move to the tapped page index.
                              // _controller.animateToPage(index);
                            },
                            child: Container(
                              width: 16.w,
                              height: 3.h,
                              margin: EdgeInsets.symmetric(
                                  vertical: 8.0, horizontal: 4.0),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(3.r),
                                color: _current == index
                                    ? Color(0xffFED235)
                                    : Color(0xffD5D5D5),
                              ),
                            ),
                          );
                        }).toList(),
                      ),
                    ),
                    Positioned(
                      top: 15.h,
                      left: 10.w,
                      child: InkWell(
                        onTap: () {
                          Get.back();
                        },
                        child: Padding(
                          padding: EdgeInsets.only(left: 15.w),
                          child: Transform.rotate(
                            angle: -3.14,
                            child: Container(
                              height: 30.h,
                              width: 30.w,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: Colors.white,
                              ),
                              child: Icon(
                                Icons.arrow_back,
                                color: Colors.black,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: 22.h,
                    ),
                    Row(
                      children: [
                        Text(
                          widget.service_data['name'],
                          style: GoogleFonts.tajawal(
                            fontSize: 14.sp,
                            color: Color(0xff262626),
                          ),
                        ),
                        Spacer(),
                        Text(
                          widget.service_data['price'] == null
                              ? ""
                              : widget.service_data['price'] + "د.ك",
                          style: GoogleFonts.tajawal(
                            fontWeight: FontWeight.bold,
                            color: Color(0xffFED235),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 23.h,
                    ),
                    Row(
                      children: [
                        Text(
                          widget.service_data['shortDescription'] == null
                              ? ""
                              : widget.service_data['shortDescription'],
                          style: GoogleFonts.tajawal(
                            fontSize: 17.sp,
                            fontWeight: FontWeight.bold,
                            color: Color(0xffFED235),
                          ),
                        ),
                        Spacer(),
                        Visibility(
                          visible: AppSettingsPreferences().email ==
                              "bkerziara11@gmail.com",
                          child: IconButton(
                            onPressed: () {
                              showDialog(
                                context: context,
                                builder: (context) {
                                  return AlertDialog(
                                    content: Column(
                                      mainAxisSize: MainAxisSize.min,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          "هل تريد حذف الخدمة؟",
                                          style: GoogleFonts.tajawal(
                                            fontWeight: FontWeight.bold,
                                            color: Colors.black,
                                          ),
                                        ),
                                        SizedBox(
                                          height: 10.h,
                                        ),
                                        Row(
                                          children: [
                                            ElevatedButton(
                                              onPressed: () async {
                                                await removeProduct(
                                                    widget.service_data['id']);
                                              },
                                              child: Text(
                                                "حذف",
                                                style: GoogleFonts.tajawal(
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                              style: ElevatedButton.styleFrom(
                                                backgroundColor:
                                                    Color(0xffFED235),
                                                minimumSize: Size(100.w, 40.h),
                                                shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          10.r),
                                                ),
                                              ),
                                            ),
                                            SizedBox(
                                              width: 15.w,
                                            ),
                                            ElevatedButton(
                                              onPressed: () {
                                                Get.back();
                                              },
                                              child: Text(
                                                "رجوع",
                                                style: GoogleFonts.tajawal(
                                                  fontWeight: FontWeight.bold,
                                                  color: Color(0xffFED235),
                                                ),
                                              ),
                                              style: ElevatedButton.styleFrom(
                                                shape: RoundedRectangleBorder(
                                                  side: BorderSide(
                                                    color: Color(0xffFED235),
                                                  ),
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                    10.r,
                                                  ),
                                                ),
                                                backgroundColor: Colors.white,
                                                minimumSize: Size(100.w, 40.h),
                                              ),
                                            ),
                                          ],
                                        )
                                      ],
                                    ),
                                  );
                                },
                              );
                            },
                            icon: Icon(
                              Icons.delete,
                              color: Colors.redAccent,
                            ),
                          ),
                        )
                      ],
                    ),
                    SizedBox(
                      height: 7.h,
                    ),
                    Text(
                      widget.service_data['longDescription'] == null
                          ? ""
                          : widget.service_data['longDescription'],
                      style: GoogleFonts.tajawal(
                        fontSize: 15.sp,
                        color: Color(0xff505050),
                      ),
                    ),
                    SizedBox(
                      height: 23.h,
                    ),
                    Row(children: [
                      Image.asset(
                        "images/14.png",
                        fit: BoxFit.cover,
                      ),
                      SizedBox(
                        width: 7.w,
                      ),
                      Text(
                        widget.service_data["user_companyName"] == ""
                            ? "لا يوجد اسم شركة"
                            : widget.service_data["user_companyName"],
                        style: GoogleFonts.tajawal(
                          fontSize: 14.sp,
                          color: Color(0xff262626),
                        ),
                      ),
                    ]),
                    widget.service_data["videoUrl"] == ""
                        ? SizedBox()
                        : SizedBox(
                            height: 15.h,
                          ),
                    widget.service_data["videoUrl"] == ""
                        ? SizedBox()
                        : Container(
                            decoration: BoxDecoration(
                              color: Color.fromARGB(255, 228, 227, 227)
                                  .withOpacity(1),
                              borderRadius: BorderRadius.circular(8.r),
                            ),
                            child: ListTile(
                              leading: Icon(Icons.video_collection_outlined),
                              title: Text(
                                "الفيديو الخاص بالإعلان",
                                style: GoogleFonts.tajawal(
                                  fontSize: 17.sp,
                                ),
                              ),
                              trailing: Icon(
                                Icons.navigate_next_outlined,
                                size: 30.r,
                                color: Colors.black,
                              ),
                              onTap: () {
                                Get.to(
                                  () => ServiceVideo(
                                    video_url: widget.service_data["videoUrl"],
                                  ),
                                );
                              },
                            ),
                          ),
                    SizedBox(
                      height: 16.h,
                    ),
                    Text(
                      "رقم الهاتف",
                      style: GoogleFonts.tajawal(
                        fontSize: 17.sp,
                        color: Color(0xff000000),
                      ),
                    ),
                    SizedBox(
                      height: 6.h,
                    ),
                    InkWell(
                      onTap: () {
                        makePhoneCall("+965" + widget.service_data["phone"]);
                      },
                      child: Container(
                        height: 40.h,
                        width: double.infinity,
                        decoration: BoxDecoration(
                          color:
                              Color.fromARGB(255, 228, 227, 227).withOpacity(1),
                          borderRadius: BorderRadius.circular(8.r),
                        ),
                        child: Align(
                          alignment: Alignment.centerRight,
                          child: Padding(
                            padding: EdgeInsets.only(right: 10.w),
                            child: Text(
                              "+965" + widget.service_data["phone"],
                              style: GoogleFonts.tajawal(
                                fontSize: 15.sp,
                                color: Color(0xff7E7E7E),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 15.h,
                    ),
                    Container(
                      decoration: BoxDecoration(
                        color:
                            Color.fromARGB(255, 228, 227, 227).withOpacity(1),
                        borderRadius: BorderRadius.circular(8.r),
                      ),
                      child: ListTile(
                        leading: Image.asset("images/svgexport-17 (9).png"),
                        title: Text(
                          "تواصل عبر الواتس اب",
                          style: GoogleFonts.tajawal(
                            fontSize: 17.sp,
                          ),
                        ),
                        trailing: Icon(
                          Icons.navigate_next_outlined,
                          size: 30.r,
                          color: Colors.black,
                        ),
                        onTap: () {
                          whatsAppOpen(
                              "+965" + widget.service_data['user_phone']);
                        },
                      ),
                    ),
                    SizedBox(
                      height: 15.h,
                    ),
                    Container(
                      decoration: BoxDecoration(
                        color:
                            Color.fromARGB(255, 228, 227, 227).withOpacity(1),
                        borderRadius: BorderRadius.circular(8.r),
                      ),
                      child: ListTile(
                        leading: Image.asset("images/svgexport-17 (10).png"),
                        title: Text(
                          "تواصل عبر الجيميل",
                          style: GoogleFonts.tajawal(
                            fontSize: 17.sp,
                          ),
                        ),
                        trailing: Icon(
                          Icons.navigate_next_outlined,
                          size: 30.r,
                          color: Colors.black,
                        ),
                        onTap: () {
                          _composeMail();
                        },
                      ),
                    )
                  ],
                ),
              ),
              SizedBox(
                height: 20.h,
              ),
            ],
          ),
        ));
  }

  Future<void> removeProduct(String productId) async {
    try {
      // Get a reference to the product document
      DocumentReference productRef =
          FirebaseFirestore.instance.collection('products').doc(productId);

      // Delete the product document
      await productRef.delete();
      showSnackBar(context: context, message: "تم حذف الخدمة بنجاح");
      print('Product with ID $productId removed successfully.');
      Get.back();
      Get.back();
    } catch (e) {
      showSnackBar(context: context, message: "خطأ في حذف الخدمة", error: true);
      Get.back();

      print('Error removing product: $e');
    }
  }

  Future<List<Map<String, dynamic>>> getAllProducts(String productName) async {
    List<Map<String, dynamic>> productsList = [];

    try {
      QuerySnapshot querySnapshot =
          await FirebaseFirestore.instance.collectionGroup('products').get();

      for (QueryDocumentSnapshot doc in querySnapshot.docs) {
        Map<String, dynamic>? productData = doc.data() as Map<String, dynamic>?;

        if (productData != null) {
          String? categoryId = productData['categoryId'];

          if (categoryId != null) {
            DocumentSnapshot categorySnapshot = await FirebaseFirestore.instance
                .collection('categories')
                .doc(categoryId)
                .get();
            categorySnapshot.id;

            Map<String, dynamic>? categoryData =
                categorySnapshot.data() as Map<String, dynamic>?;

            if (categoryData != null) {
              productData['categoryName'] = categoryData['name'];
            }
          }

          // Check if the current product matches the one to be removed
          if (productData['productName'] == productName) {
            // Get the product document ID and remove it
            String productId = doc.id;
            await removeProduct(productId);
          } else {
            // Add the product data to the list
            productsList.add(productData);
          }
        }
      }
    } catch (e) {
      print('Error fetching products: $e');
    }

    return productsList;
  }

  void makePhoneCall(String phoneNumber) async {
    final url = 'tel:$phoneNumber';
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }
}

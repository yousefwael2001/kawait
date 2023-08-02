import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher.dart';

class ServicePage extends StatefulWidget {
  const ServicePage({super.key, required this.service_data});
  final Map<String, dynamic> service_data;
  @override
  State<ServicePage> createState() => _ServicePageState();
}

class _ServicePageState extends State<ServicePage> {
  int _current = 0;
  final CarouselController _controller = CarouselController();

  void whatsAppOpen(String number) async {
    var url = 'http://wa.me/$number?text=Hello';
    await launch(url);
  }

  void _sendEmail() async {
    final Uri _emailLaunchUri = Uri(
      scheme: 'mailto',
      path: widget.service_data['user_email'],
      queryParameters: {
        'subject': 'طالب خدمة',
        'body': 'السلام عليكم',
      },
    );

    if (await canLaunch(_emailLaunchUri.toString())) {
      await launch(_emailLaunchUri.toString());
    } else {
      throw 'Could not launch email';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: SafeArea(
          child: ListView(
            children: [
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
                              child: ClipRRect(
                                borderRadius: BorderRadius.only(
                                  bottomLeft: Radius.circular(15.r),
                                  bottomRight: Radius.circular(15.r),
                                ),
                                child: Image.network(
                                  item,
                                  fit: BoxFit.cover,
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
                    Container(
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
                            widget.service_data["user_phone"],
                            style: GoogleFonts.tajawal(
                              fontSize: 15.sp,
                              color: Color(0xff7E7E7E),
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
                          whatsAppOpen(widget.service_data['user_phone']);
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
                          _sendEmail();
                        },
                      ),
                    )
                  ],
                ),
              )
            ],
          ),
        ));
  }
}

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class Reports extends StatefulWidget {
  const Reports({super.key});

  @override
  State<Reports> createState() => _ReportsState();
}

class _ReportsState extends State<Reports> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Color(0xffF8F8F8),
        title: Text(
          "الشكاوي والاقتراحات",
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
        width: double.infinity,
        decoration: BoxDecoration(
          color: Colors.white,
        ),
        padding: EdgeInsets.symmetric(horizontal: 16.w),
        child: ListView(
          children: [
            SizedBox(
              height: 20.h,
            ),
            Text(
              "رأيك يهمنا",
              style: GoogleFonts.tajawal(
                fontSize: 16.sp,
                fontWeight: FontWeight.bold,
                color: Color(0XFFFED235),
              ),
            ),
            SizedBox(
              height: 9.h,
            ),
            Text(
              "نحن نهتم برأيك ونقدّر مساهمتك في تحسين ما نقدمه\nفإن آراؤك تعد قيّمة ومهمة بالنسبة لنا",
              style: GoogleFonts.tajawal(
                fontSize: 15.sp,
                color: Color(0XFF505050),
              ),
            ),
            SizedBox(
              height: 21.h,
            ),
            Text(
              "شكوة",
              style: GoogleFonts.tajawal(
                fontSize: 14.sp,
                color: Color(0XFF505050),
              ),
            ),
            Text(
              "دون ملاحظتك",
              style: GoogleFonts.tajawal(
                fontSize: 10.sp,
                color: Color(0XFF484848),
              ),
            ),
            SizedBox(
              height: 8.h,
            ),
            TextField(
              obscureText: false,
              keyboardType: TextInputType.text,
              minLines: 6,
              maxLines: 12,
              maxLength: 50,
              cursorHeight: 25.h,
              textAlign: TextAlign.start,
              textAlignVertical: TextAlignVertical.top,
              decoration: InputDecoration(
                contentPadding: const EdgeInsets.all(18),
                counterText: "",
                hintMaxLines: 1,
                alignLabelWithHint: true,
                label: Row(
                  children: [
                    Icon(Icons.chat_outlined),
                    SizedBox(
                      width: 10.w,
                    ),
                    Text(
                      "هل تود أن تخبرنا أي شيء ؟",
                      style: GoogleFonts.tajawal(
                        color: Color(0XFFBCBCBC),
                        fontWeight: FontWeight.normal,
                        fontSize: 12.sp,
                      ),
                    ),
                  ],
                ),
                labelStyle: TextStyle(
                    color: Color(0XFFBCBCBC),
                    fontWeight: FontWeight.normal,
                    fontSize: 18),
                floatingLabelBehavior: FloatingLabelBehavior.never,
                fillColor: Color(0XFFF3F3F9),
                filled: true,

                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: BorderSide(
                    width: 0,
                    color: Colors.grey.shade300,
                  ),
                ),
                // focusColor: Color(0XFF22A45D),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(5),
                  borderSide: BorderSide(
                      width: 1,
                      color: Colors.grey.shade300,
                      style: BorderStyle.solid),
                ),
                errorBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide(
                      width: 1,
                      color: Colors.red.shade300,
                      style: BorderStyle.solid),
                ),
                focusedErrorBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide(
                      width: 1,
                      color: Colors.red.shade900,
                      style: BorderStyle.solid),
                ),
              ),
            ),
            SizedBox(
              height: 21.h,
            ),
            Text(
              "اقتراح",
              style: GoogleFonts.tajawal(
                fontSize: 14.sp,
                color: Color(0XFF505050),
              ),
            ),
            Text(
              "دون ملاحظتك",
              style: GoogleFonts.tajawal(
                fontSize: 10.sp,
                color: Color(0XFF484848),
              ),
            ),
            SizedBox(
              height: 8.h,
            ),
            TextField(
              obscureText: false,
              keyboardType: TextInputType.text,
              minLines: 6,
              maxLines: 12,
              maxLength: 50,
              cursorHeight: 25.h,
              textAlign: TextAlign.start,
              textAlignVertical: TextAlignVertical.top,
              decoration: InputDecoration(
                contentPadding: const EdgeInsets.all(18),
                counterText: "",
                hintMaxLines: 1,
                alignLabelWithHint: true,
                label: Row(
                  children: [
                    Icon(Icons.chat_outlined),
                    SizedBox(
                      width: 10.w,
                    ),
                    Text(
                      "هل تود أن تخبرنا أي شيء ؟",
                      style: GoogleFonts.tajawal(
                        color: Color(0XFFBCBCBC),
                        fontWeight: FontWeight.normal,
                        fontSize: 12.sp,
                      ),
                    ),
                  ],
                ),
                labelStyle: TextStyle(
                    color: Color(0XFFBCBCBC),
                    fontWeight: FontWeight.normal,
                    fontSize: 18),
                floatingLabelBehavior: FloatingLabelBehavior.never,
                fillColor: Color(0XFFF3F3F9),
                filled: true,

                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: BorderSide(
                    width: 0,
                    color: Colors.grey.shade300,
                  ),
                ),
                // focusColor: Color(0XFF22A45D),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(5),
                  borderSide: BorderSide(
                      width: 1,
                      color: Colors.grey.shade300,
                      style: BorderStyle.solid),
                ),
                errorBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide(
                      width: 1,
                      color: Colors.red.shade300,
                      style: BorderStyle.solid),
                ),
                focusedErrorBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide(
                      width: 1,
                      color: Colors.red.shade900,
                      style: BorderStyle.solid),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

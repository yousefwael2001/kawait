import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class HowUs extends StatefulWidget {
  const HowUs({super.key});

  @override
  State<HowUs> createState() => _HowUsState();
}

class _HowUsState extends State<HowUs> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Color(0xffF8F8F8),
        title: Text(
          "من نحن",
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
              "مالك التطبيق",
              style: GoogleFonts.tajawal(
                fontSize: 16.sp,
                fontWeight: FontWeight.bold,
                color: Color(0XFFFED235),
              ),
            ),
            Text(
              "م .نواف ممدوح الشمري",
              style: GoogleFonts.tajawal(
                fontSize: 16.sp,
                fontWeight: FontWeight.bold,
                color: Color(0XFFFED235),
              ),
            ),
            SizedBox(
              height: 9.h,
            ),
            Image.asset('images/WhatsApp Image 2023-08-09 at 18.57.00.jpg'),
            SizedBox(
              height: 15.h,
            ),
            Text(
              "هوم كويت",
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
              "مرحباً بك في هوم كويت - المكان الذي يجمع بين الشركات الرسمية والجمهور المستهدف ، نحن نقدم منصة متكاملة تتيح للشركات الرسمية الوصول إلى جمهورها بطرق مبتكرة وفعالة.\nفي هوم كويت، نجمع بين قاعدة بياناتنا الواسعة من الشركات الرسمية والمستخدمين الباحثين عن منتجات وخدمات موثوقة ،  نسعى جاهدين لتحقيق التواصل الفعال بين هاتين الفئتين من خلال توفير حلول إعلانية مبتكرة ومستهدفة.",
              style: GoogleFonts.tajawal(
                fontSize: 12.sp,
                color: Color(0XFF505050),
              ),
            ),
            SizedBox(
              height: 9.h,
            ),
            Text(
              "مع توفيرنا لمجموعة متنوعة من خيارات الإعلانات والحملات الموجهة ، نضمن لشركاتنا الرسمية تحقيق أقصى استفادة من جهودها التسويقية  نحن ندعمكم في كل خطوة على طريق نجاحكم .\nانضموا إلينا في هوم كويت واستفيدوا من تجربة فريدة للتسويق والإعلان التي تضمن لكم الوصول إلى الجمهور المناسب وتحقيق نتائج ملموسة .",
              style: GoogleFonts.tajawal(
                fontSize: 12.sp,
                color: Color(0XFF505050),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

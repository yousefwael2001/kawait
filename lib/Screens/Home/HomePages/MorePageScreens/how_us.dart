import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:kawait/widgets/alert_dialog_widget.dart';
import 'package:kawait/widgets/list_tile_style.dart';

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
              "مدينة الكويت السكنية",
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
              "تطبيق مدينة الكويت السكنية هو تطبيق يهدف إلى توفير وسيلة فعالة للترويج والدعاية للمشاريع الإنشائية والمقاولاتية سيقوم التطبيق بتوفير مجموعة من الميزات والخدمات التي تمكن المقاولين وشركات البناء من عرض أعمالهم والتواصل مع الجمهور المستهدف بطريقة مبتكرة وجذابة فيما يلي نموذج للمحتوى الكامل لتطبيق دعاية للمباني والمقاولات",
              style: GoogleFonts.tajawal(
                fontSize: 12.sp,
                color: Color(0XFF505050),
              ),
            ),
            SizedBox(
              height: 15.h,
            ),
            Text(
              "نبذة عن التطبيق:",
              style: GoogleFonts.tajawal(
                fontSize: 16.sp,
                fontWeight: FontWeight.bold,
                color: Color(0XFFFED235),
              ),
            ),
            SizedBox(
              height: 9.h,
            ),
            RichText(
              text: TextSpan(
                style:
                    GoogleFonts.tajawal(fontSize: 18.sp, color: Colors.black),
                children: <TextSpan>[
                  TextSpan(
                    text: 'تطبيق ',
                    style: GoogleFonts.tajawal(
                      fontSize: 12.sp,
                      color: Color(0XFF505050),
                    ),
                  ),
                  TextSpan(
                    text: '\"مدينة الكويت السكنية\"',
                    style: GoogleFonts.tajawal(
                      fontSize: 12.sp,
                      color: Color(0XFFFED235),
                    ),
                  ),
                  TextSpan(
                    text:
                        ' هو منصة شاملة تهدف إلى تسهيل الترويج والدعاية للمشاريع الإنشائية والقوالب البنائية في جميع أنحاء المناطق الناشئة فيها البناء والكويت عامة سيقدم التطبيق فرصة فريدة للمقاولين والشركات الإنشائية للتعريف بمشاريعهم ، وعرض الأعمال المنجزة ، والتواصل مع الجمهور المستهدف بكل سهولة وفاعلية',
                    style: GoogleFonts.tajawal(
                      fontSize: 14.sp,
                      color: Color(0XFF505050),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 15.h,
            ),
            Text(
              "مميزات التطبيق:",
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
              "عرض المشاريع: يتيح التطبيق للمقاولين والشركات الإنشائية عرض مشاريعهم الحالية والسابقة بشكل مبتكر وجذاب يمكن عرض الصور والفيديوهات والوصف الكامل للمشاريع لإلقاء نظرة شاملة على الأعمال الإنشائية المنجزة.",
              style: GoogleFonts.tajawal(
                fontSize: 14.sp,
                color: Color(0XFF505050),
              ),
            ),
            SizedBox(
              height: 6.h,
            ),
            Text(
              "تقييمات العملاء: يتيح التطبيق للعملاء تقييم المشاريع وترك تعليقات وآراء عن الخدمات المقدمة، مما يساعد على بناء سمعة طيبة وزيادة الثقة لدى الجمهور المستهدف.",
              style: GoogleFonts.tajawal(
                fontSize: 14.sp,
                color: Color(0XFF505050),
              ),
            ),
            SizedBox(
              height: 6.h,
            ),
            Text(
              "معلومات الاتصال: يتيح التطبيق وضع معلومات الاتصال الخاصة بالشركة أو المقاول لتسهيل التواصل مع العملاء المحتملين.",
              style: GoogleFonts.tajawal(
                fontSize: 14.sp,
                color: Color(0XFF505050),
              ),
            ),
            SizedBox(
              height: 6.h,
            ),
            Text(
              "عروض وتخفيضات: يمكن عرض العروض الخاصة والتخفيضات على الخدمات والمشاريع القادمة لجذب الزبائن وتشجيعهم على التعاقد.",
              style: GoogleFonts.tajawal(
                fontSize: 14.sp,
                color: Color(0XFF505050),
              ),
            ),
            SizedBox(
              height: 6.h,
            ),
            Text(
              "أخبار ومستجدات: يمكن نشر أحدث الأخبار والمستجدات المتعلقة بالمشاريع والقطاع الإنشائي للمحتوى الجديد والمثير للاهتمام",
              style: GoogleFonts.tajawal(
                fontSize: 14.sp,
                color: Color(0XFF505050),
              ),
            ),
            SizedBox(
              height: 15.h,
            ),
            Text(
              "فوائد التطبيق:",
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
              "يمنح الشركات والمقاولين فرصة للترويج وزيادة الوعي بالمشاريع والخدمات القائمة.",
              style: GoogleFonts.tajawal(
                fontSize: 14.sp,
                color: Color(0XFF505050),
              ),
            ),
            SizedBox(
              height: 6.h,
            ),
            Text(
              "يسهل التواصل بين الشركات والعملاء المحتملين ويعزز فرص التعاقد.",
              style: GoogleFonts.tajawal(
                fontSize: 14.sp,
                color: Color(0XFF505050),
              ),
            ),
            SizedBox(
              height: 6.h,
            ),
            Text(
              "يعزز الثقة والمصداقية من خلال عرض المشاريع المنجزة وتقييمات العملاء.",
              style: GoogleFonts.tajawal(
                fontSize: 14.sp,
                color: Color(0XFF505050),
              ),
            ),
            SizedBox(
              height: 6.h,
            ),
            Text(
              "يوفر منصة شاملة لتبادل الأفكار والتواصل في المجال الإنشائي.",
              style: GoogleFonts.tajawal(
                fontSize: 14.sp,
                color: Color(0XFF505050),
              ),
            ),
            SizedBox(
              height: 6.h,
            ),
            Text(
              "نتمنى أن يكون هذا المحتوى نموذجًا جيدًا لتطبيق دعاية للمباني والمقاولات، وأن يساعد على جذب انتباه العملاء المحتملين وتعزيز مكانة الشركات والمقاولين في سوق البناء والإنشاء",
              style: GoogleFonts.tajawal(
                fontSize: 14.sp,
                color: Color(0XFF505050),
              ),
            ),
            SizedBox(
              height: 10.h,
            )
          ],
        ),
      ),
    );
  }
}

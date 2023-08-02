import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:kawait/Shared%20preferences/shared_preferences.dart';
import 'package:kawait/widgets/alert_dialog_widget.dart';
import 'package:kawait/widgets/list_tile_style.dart';
import 'package:kawait/widgets/text_field.dart';

class DetailsPage extends StatefulWidget {
  const DetailsPage({super.key});

  @override
  State<DetailsPage> createState() => _DetailsPageState();
}

class _DetailsPageState extends State<DetailsPage> {
  late TextEditingController _namecompanycontroller;
  late TextEditingController _emailcompanycontroller;
  late TextEditingController _phonecompanycontroller;
  late TextEditingController _addresscompanycontroller;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _namecompanycontroller = TextEditingController();
    _emailcompanycontroller = TextEditingController();
    _phonecompanycontroller = TextEditingController();
    _addresscompanycontroller = TextEditingController();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _namecompanycontroller.dispose();
    _emailcompanycontroller.dispose();
    _phonecompanycontroller.dispose();
    _addresscompanycontroller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Color(0xffF8F8F8),
        title: Text(
          "تعديل الملف الشخصي",
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
        child: ListView(
          children: [
            SizedBox(
              height: 20.h,
            ),
            Align(
              alignment: Alignment.topCenter,
              child: Stack(
                children: [
                  CircleAvatar(
                    maxRadius: 36.r,
                    child: AppSettingsPreferences().user().imageURL == ""
                        ? Image.asset(
                            'images/Ellipse 3.png',
                            fit: BoxFit.cover,
                            filterQuality: FilterQuality.high,
                          )
                        : Image.network(
                            AppSettingsPreferences().user().imageURL!),
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
            ),
            SizedBox(
              height: 11.h,
            ),
            Align(
              alignment: Alignment.topCenter,
              child: Text(
                AppSettingsPreferences().user().name!,
                style: GoogleFonts.tajawal(
                  fontSize: 16.sp,
                  color: Colors.black,
                ),
              ),
            ),
            SizedBox(
              height: 42.h,
            ),
            TextFieldStyle(
              isenablelable: true,
              lableText: 'اسم الشركة',
              hintText: "شركة احمد محسن",
              codeTextController: _namecompanycontroller
                ..text = AppSettingsPreferences().user().companyName == ""
                    ? ""
                    : AppSettingsPreferences().user().companyName!,
              obscureText: true,
              inputType: TextInputType.name,
            ),
            SizedBox(
              height: 11.h,
            ),
            TextFieldStyle(
              isenablelable: true,
              lableText: 'الاميل',
              hintText: "yousefael2020@gmail.com",
              codeTextController: _emailcompanycontroller
                ..text = AppSettingsPreferences().user().email == ""
                    ? ""
                    : AppSettingsPreferences().user().email!,
              obscureText: false,
              inputType: TextInputType.emailAddress,
            ),
            SizedBox(
              height: 11.h,
            ),
            TextFieldStyle(
              isenablelable: true,
              lableText: 'الرقم',
              hintText: "+970595967150",
              codeTextController: _phonecompanycontroller
                ..text = AppSettingsPreferences().user().phone == ""
                    ? ""
                    : AppSettingsPreferences().user().phone!,
              obscureText: false,
              inputType: TextInputType.phone,
            ),
            SizedBox(
              height: 11.h,
            ),
            TextFieldStyle(
              isenablelable: true,
              lableText: 'العنوان',
              hintText: "غزة - فلسطين",
              codeTextController: _addresscompanycontroller
                ..text = AppSettingsPreferences().user().address == ""
                    ? ""
                    : AppSettingsPreferences().user().address!,
              obscureText: false,
              inputType: TextInputType.streetAddress,
            ),
            SizedBox(
              height: 35.h,
            ),
            ElevatedButton(
              onPressed: () {},
              child: Text(
                "حفظ",
                style: GoogleFonts.tajawal(
                  fontSize: 18.sp,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              style: ElevatedButton.styleFrom(
                minimumSize: Size(343.w, 47.h),
                backgroundColor: Color(0XFFFED235),
                shadowColor: Colors.transparent,
                shape: RoundedRectangleBorder(
                  side: BorderSide(
                    color: Color(0XFFFED235),
                  ),
                  borderRadius: BorderRadius.circular(8.r),
                ),
                alignment: Alignment.center,
              ),
            )
          ],
        ),
      ),
    );
  }
}

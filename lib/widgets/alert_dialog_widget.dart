import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class AlertDialogWidget extends StatelessWidget {
  const AlertDialogWidget({
    Key? key,
    required this.title,
    required this.contant,
    required this.exit,
    required this.ensure,
    required this.ontap,
  }) : super(key: key);
  final String title;
  final String contant;
  final String exit;
  final String ensure;
  final void Function() ontap;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(
        title,
        textDirection: TextDirection.rtl,
      ),
      titleTextStyle: GoogleFonts.tajawal(
        fontSize: 16.sp,
        fontWeight: FontWeight.bold,
        color: Colors.black,
      ),
      contentPadding: EdgeInsets.only(
        top: 12.h,
        right: 16.w,
        left: 22.w,
        bottom: 22.h,
      ),
      content: StatefulBuilder(
        builder: (BuildContext context, StateSetter snapshot) {
          return Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                contant,
                style: GoogleFonts.tajawal(
                  fontSize: 13.sp,
                  fontWeight: FontWeight.bold,
                  color: Color(0XFFABABAB),
                ),
              ),
              SizedBox(
                height: 25.h,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: Text(
                      exit,
                      style: GoogleFonts.tajawal(
                        fontSize: 13.sp,
                        color: Color(0XFFFED235),
                      ),
                    ),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white,
                      minimumSize: Size(24.w, 17.h),
                      elevation: 0,
                    ),
                  ),
                  SizedBox(
                    width: 15.w,
                  ),
                  ElevatedButton(
                    onPressed: ontap,
                    child: Text(
                      ensure,
                      style: GoogleFonts.tajawal(
                        fontSize: 14.sp,
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    style: IconButton.styleFrom(
                      backgroundColor: Color(0XFFFED235),
                      minimumSize: Size(100.w, 45.h),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(
                          8.r,
                        ),
                      ),
                    ),
                  ),
                ],
              )
            ],
          );
        },
      ),
    );
  }
}

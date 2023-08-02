import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class ListTileStyleWidget extends StatelessWidget {
  const ListTileStyleWidget({
    Key? key,
    required this.onTap,
    required this.title,
    required this.leadingImage,
  }) : super(key: key);
  final void Function() onTap;
  final String title;
  final String leadingImage;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8.r),
        color: Color(0XFFF3F3F9),
      ),
      margin: EdgeInsets.symmetric(horizontal: 16.w),
      child: ListTile(
        onTap: onTap,
        trailing: Icon(
          Icons.navigate_next,
          color: Colors.black,
          size: 28.r,
        ),
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SizedBox(
              height: 5.h,
            ),
            Text(
              title,
              style: GoogleFonts.tajawal(
                fontSize: 17.sp,
                color: Colors.black,
              ),
            ),
          ],
        ),
        leading: ImageIcon(
          AssetImage(leadingImage),
          color: Color(0XFFFED235),
          size: 28.r,
        ),
      ),
    );
  }
}

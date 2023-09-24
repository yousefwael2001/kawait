import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:video_player/video_player.dart';

import '../../../../widgets/VideoPlayer.dart';

class ServiceVideo extends StatefulWidget {
  const ServiceVideo({super.key, required this.video_url});
  final String video_url;

  @override
  State<ServiceVideo> createState() => _ServiceVideoState();
}

class _ServiceVideoState extends State<ServiceVideo> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          centerTitle: true,
          backgroundColor: Color(0xffF8F8F8),
          title: Text(
            "فيديو الإعلان",
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
          toolbarHeight: 60.h,
        ),
        body: Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.w),
          child: Center(
            child: SizedBox(
              height: 350.h,
              child: VideoPlayerFromUrl(
                videoUrl: widget.video_url,
                dataSourceType: DataSourceType.network,
              ),
            ),
          ),
        ),
      ),
    );
  }
}

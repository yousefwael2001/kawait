import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:kawait/utils/helpers.dart';

import '../../../../widgets/text_field.dart';

class AddAds extends StatefulWidget {
  const AddAds({super.key});

  @override
  State<AddAds> createState() => _AddAdsState();
}

class _AddAdsState extends State<AddAds> with Helpers {
  TextEditingController _adTitleController = TextEditingController();
  TextEditingController _adDescriptionController = TextEditingController();
  File? _selectedImage;
  String? _imageUrl;

  Future<void> _uploadImage() async {
    try {
      // Generate a unique file name based on timestamp and a random identifier
      String fileName = DateTime.now().millisecondsSinceEpoch.toString() +
          '-' +
          UniqueKey().toString();

      Reference ref =
          FirebaseStorage.instance.ref().child('ad_images').child(fileName);

      UploadTask uploadTask = ref.putFile(_selectedImage!);
      TaskSnapshot snapshot = await uploadTask.whenComplete(() => null);
      _imageUrl = await snapshot.ref.getDownloadURL();
    } catch (error) {
      // Handle image upload error here
      print('Image upload error: $error');
    }
  }

  Future<void> _postAd() async {
    try {
      String adTitle = _adTitleController.text.trim();
      String adDescription = _adDescriptionController.text.trim();

      if (adTitle.isNotEmpty && adDescription.isNotEmpty && _imageUrl != null) {
        await FirebaseFirestore.instance.collection('ads').add({
          'title': adTitle,
          'description': adDescription,
          'image_url': _imageUrl,
        });

        // Clear input fields after successful ad posting
        _adTitleController.clear();
        _adDescriptionController.clear();
        _imageUrl = null;

        // Inform the user that the ad was successfully posted
        showSnackBar(
          context: context,
          message: "تم إنشاء الإعلان بنجاح",
        );
      } else {
        showSnackBar(
          context: context,
          message: "يجب إدخال الحقول الفارغة",
        );
        // Handle invalid input
        print('Ad title, description, and image are required');
      }
    } catch (error) {
      showSnackBar(
        context: context,
        message: "خطأ في إنشاء الإعلان",
      );
      // Handle Firestore write error here
      print('Firestore write error: $error');
    }
  }

  Future<void> _selectImage() async {
    final picker = ImagePicker();
    final pickedImage = await picker.pickImage(source: ImageSource.gallery);

    if (pickedImage != null) {
      setState(() {
        _selectedImage = File(pickedImage.path);
      });
    } else {
      print('No image selected.');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Color(0xffF8F8F8),
        title: Text(
          "إنشاء إعلان مميز",
          style: GoogleFonts.tajawal(
            fontSize: 17.sp,
            color: Colors.black,
            fontWeight: FontWeight.w600,
          ),
        ),
        leadingWidth: 90.w,
        leading: SizedBox(),
        actions: [
          InkWell(
            onTap: () {
              Get.back();
            },
            child: Padding(
              padding: EdgeInsets.only(left: 15.w),
              child: Transform.rotate(
                angle: -3.14,
                child: Icon(
                  Icons.arrow_back,
                  color: Colors.black,
                ),
              ),
            ),
          )
        ],
        toolbarHeight: 60.h,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              SizedBox(
                height: 30.h,
              ),
              TextFieldStyle(
                isenablelable: true,
                lableText: "عنوان الاعلان",
                hintText: "عنوان الاعلان",
                codeTextController: _adTitleController,
                obscureText: false,
                inputType: TextInputType.visiblePassword,
              ),
              SizedBox(height: 16.0.h),
              TextFieldStyle(
                isenablelable: true,
                lableText: "تفاصيل الاعلان",
                hintText: "تفاصيل الاعلان",
                codeTextController: _adDescriptionController,
                obscureText: false,
                inputType: TextInputType.visiblePassword,
              ),
              SizedBox(height: 16.0),
              if (_selectedImage != null)
                ClipRRect(
                  borderRadius: BorderRadius.circular(10.r),
                  child: Image.file(
                    _selectedImage!,
                    height: 300.0.h,
                    width: 300.w,
                    fit: BoxFit.fill,
                  ),
                ),
              SizedBox(height: 16.0),
              ElevatedButton(
                onPressed: _selectImage,
                child: Text(
                  "اختار صورة الإعلان",
                  style: GoogleFonts.tajawal(
                    fontSize: 18.sp,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
                style: ElevatedButton.styleFrom(
                  minimumSize: Size(150.w, 47.h),
                  backgroundColor: Color(0XFFF3F3F9),
                  shadowColor: Colors.transparent,
                  shape: RoundedRectangleBorder(
                    side: BorderSide(
                      color: Color(0XFFF3F3F9),
                    ),
                    borderRadius: BorderRadius.circular(8.r),
                  ),
                  alignment: Alignment.center,
                ),
              ),
              SizedBox(height: 30.h),
              ElevatedButton(
                onPressed: () async {
                  showDialog(
                    context: context,
                    builder: (context) {
                      return Center(
                        child: SpinKitFadingCircle(
                          color: Colors.blue,
                          size: 80.0,
                        ),
                      );
                    },
                  );
                  await _uploadImage();
                  await _postAd();
                  Get.back();
                },
                child: Text(
                  "انشر الإعلان",
                  style: GoogleFonts.tajawal(
                    fontSize: 18.sp,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                style: ElevatedButton.styleFrom(
                  minimumSize: Size(200.w, 47.h),
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
              ),
            ],
          ),
        ),
      ),
    );
  }
}

import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:kawait/Shared%20preferences/shared_preferences.dart';
import 'package:kawait/utils/helpers.dart';
import 'package:kawait/widgets/alert_dialog_widget.dart';
import 'package:kawait/widgets/list_tile_style.dart';
import 'package:kawait/widgets/text_field.dart';

import '../../../../Models/User.dart';

class DetailsPage extends StatefulWidget {
  const DetailsPage({super.key});

  @override
  State<DetailsPage> createState() => _DetailsPageState();
}

class _DetailsPageState extends State<DetailsPage> with Helpers {
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

  late ImagePicker _imagePicker;
  XFile? _pickedFile;

  Future pickImage() async {
    _imagePicker = ImagePicker();
    XFile? selectedImageFile =
        await _imagePicker.pickImage(source: ImageSource.gallery);
    if (selectedImageFile != null) {
      setState(() {
        _pickedFile = selectedImageFile;
      });
    }
  }

  Future<String> uploadImageToStorage(String userId, String imagePath) async {
    final Reference storageReference =
        FirebaseStorage.instance.ref().child('user_images/$userId.jpg');

    final UploadTask uploadTask = storageReference.putFile(File(imagePath));

    final TaskSnapshot downloadTaskSnapshot =
        await uploadTask.whenComplete(() {});

    final String downloadURL = await downloadTaskSnapshot.ref.getDownloadURL();

    return downloadURL;
  }

  Future<void> updateUser() async {
    try {
      // Reference to the Firestore collection
      CollectionReference users =
          FirebaseFirestore.instance.collection('users');

      if (_pickedFile != null) {
        String imaageurl = await uploadImageToStorage(
            AppSettingsPreferences().user().id.toString(), _pickedFile!.path);
        await users.doc(AppSettingsPreferences().user().id.toString()).update({
          'imageURL': imaageurl,
          'company_name': _namecompanycontroller.text,
          'email': _emailcompanycontroller.text,
          'phone': _phonecompanycontroller.text,
          'address': _addresscompanycontroller.text,
        });
        UserData updateUser = new UserData(
            id: AppSettingsPreferences().user().id,
            companyName: _namecompanycontroller.text,
            email: _emailcompanycontroller.text,
            address: _addresscompanycontroller.text,
            imageURL: imaageurl,
            name: AppSettingsPreferences().user().name,
            phone: _phonecompanycontroller.text);
        await AppSettingsPreferences().saveUser(user: updateUser);
      } else {
        await users.doc(AppSettingsPreferences().user().id.toString()).update({
          'company_name': _namecompanycontroller.text,
          'email': _emailcompanycontroller.text,
          'phone': _phonecompanycontroller.text,
          'address': _addresscompanycontroller.text,
        });
        UserData updateUser = new UserData(
            id: AppSettingsPreferences().user().id,
            companyName: _namecompanycontroller.text,
            email: _emailcompanycontroller.text,
            address: _addresscompanycontroller.text,
            imageURL: AppSettingsPreferences().user().imageURL,
            name: AppSettingsPreferences().user().name,
            phone: _phonecompanycontroller.text);
        await AppSettingsPreferences().saveUser(user: updateUser);
      }

      // Update the user's data using the user ID
      showSnackBar(
          context: context, message: "تم تعديل البيانات", error: false);
      Get.back();
      print('User data updated successfully');
    } catch (error) {
      showSnackBar(
          context: context, message: "خطأ في تعديل البيانات", error: true);
      Get.back();

      print('Error updating user data: $error');
    }
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
                    child: _pickedFile == null
                        ? AppSettingsPreferences().user().imageURL == ""
                            ? Image.asset(
                                'images/Ellipse 3.png',
                                fit: BoxFit.cover,
                                filterQuality: FilterQuality.high,
                              )
                            : ClipRRect(
                                borderRadius: BorderRadius.circular(50.r),
                                child: Image.network(
                                  AppSettingsPreferences().user().imageURL!,
                                  width: 100.w,
                                  fit: BoxFit.fill,
                                ),
                              )
                        : ClipRRect(
                            borderRadius: BorderRadius.circular(50.r),
                            child: Image.file(
                              File(_pickedFile!.path),
                              width: 100.w,
                              fit: BoxFit.fill,
                            ),
                          ),
                    backgroundColor: Colors.transparent,
                  ),
                  Positioned(
                    bottom: 0,
                    child: InkWell(
                      onTap: () async {
                        await pickImage();
                      },
                      child: CircleAvatar(
                        radius: 15.r,
                        backgroundColor: Color(0XFFF7F7F7),
                        child: Icon(
                          Icons.add_a_photo_rounded,
                          color: Colors.black,
                          size: 18.r,
                        ),
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
              hintText: "",
              codeTextController: _namecompanycontroller
                ..text = AppSettingsPreferences().user().companyName == ""
                    ? ""
                    : AppSettingsPreferences().user().companyName!,
              obscureText: false,
              inputType: TextInputType.name,
            ),
            SizedBox(
              height: 11.h,
            ),
            TextFieldStyle(
              isenablelable: true,
              lableText: 'الايميل',
              hintText: "",
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
              hintText: "",
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
              hintText: "",
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
              onPressed: () async {
                await performEdit();
              },
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

  Future<void> performEdit() async {
    await showDialog(
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
    updateUser();
    Get.back();
  }
}

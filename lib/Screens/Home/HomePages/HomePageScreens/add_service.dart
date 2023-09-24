import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:kawait/Models/Product.dart';
import 'package:kawait/Shared%20preferences/shared_preferences.dart';
import 'package:kawait/utils/helpers.dart';
import 'package:kawait/widgets/VideoPlayer.dart';
import 'package:kawait/widgets/text_field.dart';
import 'package:path_provider/path_provider.dart';
import 'package:video_player/video_player.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:path/path.dart' as path;

class AddService extends StatefulWidget {
  const AddService({super.key});

  @override
  State<AddService> createState() => _AddServiceState();
}

class _AddServiceState extends State<AddService> with Helpers {
  late TextEditingController _servicename;
  late TextEditingController _servicedesshort;
  late TextEditingController _servicedeslong;
  late TextEditingController _serviceprice;
  // late TextEditingController _servicedata;
  late TextEditingController _serviceemail;
  late TextEditingController _servicephone;
  final ImagePicker _imagePicker = ImagePicker();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  Product _newProduct = Product(
    name: '',
    shortDescription: '',
    longDescription: '',
    price: 0.0,
    dateOfEnd: DateTime.now(),
    email: '',
    phone: '',
    imagePaths: [],
    videoPath: '',
  );

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _servicename = TextEditingController();
    _servicedesshort = TextEditingController();
    _servicedeslong = TextEditingController();
    _serviceprice = TextEditingController();
    // _servicedata = TextEditingController();
    _serviceemail = TextEditingController();
    _servicephone = TextEditingController();
  }

  @override
  void dispose() {
    _servicename.dispose();
    _servicedesshort.dispose();
    _servicedeslong.dispose();
    _serviceprice.dispose();
    // _servicedata.dispose();
    _serviceemail.dispose();
    _servicephone.dispose();
    super.dispose();
  }

  Future<void> _pickAndUploadImage() async {
    List<XFile>? pickedImages = await _imagePicker.pickMultiImage();

    if (pickedImages != null) {
      List<String> imagePaths = [];
      for (XFile image in pickedImages) {
        // Copy image from temporary directory to application documents directory
        Directory appDocDir = await getApplicationDocumentsDirectory();
        String fileName = path.basename(image.path);
        String savedImagePath = path.join(appDocDir.path, fileName);
        await File(image.path).copy(savedImagePath);

        imagePaths.add(savedImagePath);
      }

      setState(() {
        _newProduct.imagePaths = imagePaths;
      });
    }
  }

  Future<void> _pickAndUploadVideo() async {
    XFile? pickedVideo =
        await _imagePicker.pickVideo(source: ImageSource.gallery);

    if (pickedVideo != null) {
      // Copy video from temporary directory to application documents directory
      Directory appDocDir = await getApplicationDocumentsDirectory();
      String fileName = path.basename(pickedVideo.path);
      String savedVideoPath = path.join(appDocDir.path, fileName);
      await File(pickedVideo.path).copy(savedVideoPath);

      setState(() {
        _newProduct.videoPath = savedVideoPath;
      });
    }
  }

  Future<String> _uploadFileToStorage(
      String path, String storageFolder, String fileName) async {
    try {
      firebase_storage.Reference storageReference = firebase_storage
          .FirebaseStorage.instance
          .ref()
          .child('$storageFolder/$fileName');

      firebase_storage.UploadTask uploadTask =
          storageReference.putFile(File(path));
      await uploadTask.whenComplete(() => null);

      String downloadURL = await storageReference.getDownloadURL();
      return downloadURL;
    } catch (e) {
      print('Error uploading file: $e');
      return '';
    }
  }

  Future<void> _saveProduct(String category_name, String? sub_category) async {
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
    // First, upload images and video to Firebase Storage
    List<String> uploadedImageUrls = [];
    String uploadedVideoUrl = '';

    for (String imagePath in _newProduct.imagePaths) {
      String fileName = path.basename(imagePath);
      String imageUrl =
          await _uploadFileToStorage(imagePath, 'product_images', fileName);
      uploadedImageUrls.add(imageUrl);
    }

    if (_newProduct.videoPath.isNotEmpty) {
      String fileName = path.basename(_newProduct.videoPath);
      uploadedVideoUrl = await _uploadFileToStorage(
          _newProduct.videoPath, 'product_videos', fileName);
    }

    // Save the product data to Firestore in the specific category
    try {
      if (sub_category == null) {
        CollectionReference categoryCollection = FirebaseFirestore.instance
            .collection('categories')
            .doc(category_name)
            .collection('products');

        DocumentReference productDocRef = categoryCollection.doc();

        await categoryCollection.add({
          'id': productDocRef.id,
          'name': _servicename.text,
          'shortDescription': _servicedesshort.text,
          'longDescription': _servicedeslong.text,
          'price': _serviceprice.text,
          // 'dateOfEnd': _servicedata.text,
          'email': _serviceemail.text,
          'phone': _servicephone.text,
          'imageUrls': uploadedImageUrls,
          'videoUrl': uploadedVideoUrl,
          'categoryName': defaultValueCategory,
          'user_id': AppSettingsPreferences().user().id,
          'user_name': AppSettingsPreferences().user().name,
          'user_phone': AppSettingsPreferences().user().phone,
          'user_imageURL': AppSettingsPreferences().user().imageURL,
          'user_address': AppSettingsPreferences().user().address,
          'user_email': AppSettingsPreferences().user().email,
          'user_companyName': AppSettingsPreferences().user().companyName,
        });
      } else {
        CollectionReference categoryRef = FirebaseFirestore.instance
            .collection('categories')
            .doc(category_name)
            .collection('subcategories')
            .doc(sub_category)
            .collection('products');

        // Generate a new document ID for the product
        DocumentReference productDocRef = categoryRef.doc();

        String? subCategoryName;
        if (defaultValueCategory == "مقاولات") {
          setState(() {
            subCategoryName = defaultValueSubCategoryConstruction;
          });
        } else if (defaultValueCategory == "عقارات") {
          setState(() {
            subCategoryName = defaultValueSubCategoryRealEstates;
          });
        } else if (defaultValueCategory == 'أثاث ومفروشات') {
          setState(() {
            subCategoryName = defaultValueSubCategoryFurniture;
          });
        } else if (defaultValueCategory == 'مركبات') {
          setState(() {
            subCategoryName = defaultValueSubCategoryEngines;
          });
        }

        // Create a map containing the product data
        Map<String, dynamic> productData = {
          'id': productDocRef.id,
          'name': _servicename.text,
          'shortDescription': _servicedesshort.text,
          'longDescription': _servicedeslong.text,
          'price': _serviceprice.text,
          // 'dateOfEnd': _servicedata.text,
          'email': _serviceemail.text,
          'phone': _servicephone.text,
          'imageUrls': uploadedImageUrls,
          'videoUrl': uploadedVideoUrl,
          'categoryName': defaultValueCategory,
          'subCategoryName': subCategoryName,
          'user_id': AppSettingsPreferences().user().id,
          'user_name': AppSettingsPreferences().user().name,
          'user_phone': AppSettingsPreferences().user().phone,
          'user_imageURL': AppSettingsPreferences().user().imageURL,
          'user_address': AppSettingsPreferences().user().address,
          'user_email': AppSettingsPreferences().user().email,
          'user_companyName': AppSettingsPreferences().user().companyName,
        };

        // Save the product data to Firestore
        await productDocRef.set(productData);

        print('Product saved successfully!');
      }

      // Reset the form and uploaded URLs after saving
      setState(() {
        _newProduct = Product(
          name: '',
          shortDescription: '',
          longDescription: '',
          price: 0.0,
          dateOfEnd: DateTime.now(),
          email: '',
          phone: '',
          imagePaths: [],
          videoPath: '',
        );
        _servicename.text = "";
        _servicedesshort.text = "";
        _servicedeslong.text = "";
        _serviceprice.text = "";
        // _servicedata.text = "";
        _serviceemail.text = "";
        _servicephone.text = "";
        uploadedImageUrls.clear();
        uploadedVideoUrl = "";
      });

      showSnackBar(
          context: context, message: "تم إضافة الخدمة بنجاح", error: false);
    } catch (e) {
      showSnackBar(
          context: context, message: "خطأ في إضافة الخدمة", error: false);
    }
    Get.back();
  }

  // Define a list of options for the dropdown
  final List<String> optionsCategory = [
    'مقاولات',
    'عقارات',
    "ألمنيوم وشتر",
    "مطابخ",
    'عمالة منزلية',
    'نقل عفش',
    'أثاث ومفروشات',
    'التنظيف',
    'مكافحة حشرات',
    "مشاتل وحدائق",
    'معدات ثقيلة',
    'تأجير معدات',
    'تأجير وبيع مولدات',
    'محركات واليات',
    'مركبات',
    'ستلايت',
    'كاميرات مراقبة',
    'معدات مهنية',
    'أجهزة الكترونية',
    'تعقيب معاملات',
    'متفرقات',
    'خدمات توصيل',
    'رخص تجارية',
    'خدمات اعلانية'
  ];

  // Define a default value for the dropdown
  String defaultValueCategory = "مقاولات";

  // Define a list of options for the dropdown
  final List<String> optionsSubCategoryConstruction = [
    'مكافحة حشرات',
    'مقاول صحي',
    "الأقفال",
    "تسليك مجاري",
    "التكييف",
    "أصباغ",
    'أعمال الديكور',
    "مشاتل وحدائق",
    "صيانة أجهزة منزلية",
    'خزانات مياه',
    'حدادة',
    'مقاولات بناء',
    "كاشي وسيراميك",
    'فني زجاج',
    'عازل',
    'مقاول كهرباء',
    'نجار',
    'منتجات زراعية',
    'مواد بناء',
    'أعمال التهوية',
  ];

  String defaultValueSubCategoryConstruction = 'مكافحة حشرات';

  final List<String> optionsSubCategoryFurniture = [
    'نشتري الأثاث المستعمل',
    'أثاث منزلي',
    "أثاث مكتبي",
    "تنجيد",
    "المفروشات"
  ];

  String defaultValueSubCategoryFurniture = 'نشتري الأثاث المستعمل';

  final List<String> optionsSubCategoryRealEstates = [
    'خدمات عقارية',

    "للبيع",
    "للايجار",
    "للبدل"
  ];

  String defaultValueSubCategoryRealEstates = "للبيع";

  final List<String> optionsSubCategoryEngines = [
    "مكاتب مركبات",
    "بيع مركبات",
    "تأجير مركبات",
    "خدمة مركبات",
  ];

  String defaultValueSubCategoryEngines = "مكاتب مركبات";

  final List<String> optionsSubCategoryNurseriesandGardens = ["منتجات زراعية"];

  String defaultValueSubCategoryNurseriesandGardens = "منتجات زراعية";

  Widget subcategorydropdoun(String defaultValueCategory) {
    if (defaultValueCategory == "مقاولات") {
      return Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Align(
            alignment: Alignment.centerRight,
            child: Text(
              "الفئة الفرعية",
              style: GoogleFonts.tajawal(
                fontSize: 16.sp,
                fontStyle: FontStyle.normal,
                color: Colors.black,
              ),
              textDirection: TextDirection.ltr,
            ),
          ),
          SizedBox(
            height: 6.h,
          ),
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8.0), // Apply border radius
              color: Color(0XFFF3F3F9), // Apply background color
            ),
            padding: EdgeInsets.symmetric(
                horizontal: 16.0), // Add some horizontal padding
            child: DropdownButton<String>(
              underline: SizedBox(),
              isExpanded: true,
              value:
                  defaultValueSubCategoryConstruction, // Set the default value here
              items: optionsSubCategoryConstruction.map((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
              onChanged: (newValue) {
                setState(() {
                  defaultValueSubCategoryConstruction = newValue!;
                });
              },
            ),
          ),
        ],
      );
    } else if (defaultValueCategory == "عقارات") {
      return Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Align(
            alignment: Alignment.centerRight,
            child: Text(
              "الفئة الفرعية",
              style: GoogleFonts.tajawal(
                fontSize: 16.sp,
                fontStyle: FontStyle.normal,
                color: Colors.black,
              ),
              textDirection: TextDirection.ltr,
            ),
          ),
          SizedBox(
            height: 6.h,
          ),
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8.0), // Apply border radius
              color: Color(0XFFF3F3F9), // Apply background color
            ),
            padding: EdgeInsets.symmetric(
                horizontal: 16.0), // Add some horizontal padding
            child: DropdownButton<String>(
              underline: SizedBox(),
              isExpanded: true,
              value:
                  defaultValueSubCategoryRealEstates, // Set the default value here
              items: optionsSubCategoryRealEstates.map((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
              onChanged: (newValue) {
                setState(() {
                  defaultValueSubCategoryRealEstates = newValue!;
                });
              },
            ),
          ),
        ],
      );
    } else if (defaultValueCategory == 'أثاث ومفروشات') {
      return Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Align(
            alignment: Alignment.centerRight,
            child: Text(
              "الفئة الفرعية",
              style: GoogleFonts.tajawal(
                fontSize: 16.sp,
                fontStyle: FontStyle.normal,
                color: Colors.black,
              ),
              textDirection: TextDirection.ltr,
            ),
          ),
          SizedBox(
            height: 6.h,
          ),
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8.0), // Apply border radius
              color: Color(0XFFF3F3F9), // Apply background color
            ),
            padding: EdgeInsets.symmetric(
                horizontal: 16.0), // Add some horizontal padding
            child: DropdownButton<String>(
              underline: SizedBox(),
              isExpanded: true,
              value:
                  defaultValueSubCategoryFurniture, // Set the default value here
              items: optionsSubCategoryFurniture.map((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
              onChanged: (newValue) {
                setState(() {
                  defaultValueSubCategoryFurniture = newValue!;
                });
              },
            ),
          ),
        ],
      );
    } else if (defaultValueCategory == 'مركبات') {
      return Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Align(
            alignment: Alignment.centerRight,
            child: Text(
              "الفئة الفرعية",
              style: GoogleFonts.tajawal(
                fontSize: 16.sp,
                fontStyle: FontStyle.normal,
                color: Colors.black,
              ),
              textDirection: TextDirection.ltr,
            ),
          ),
          SizedBox(
            height: 6.h,
          ),
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8.0), // Apply border radius
              color: Color(0XFFF3F3F9), // Apply background color
            ),
            padding: EdgeInsets.symmetric(
                horizontal: 16.0), // Add some horizontal padding
            child: DropdownButton<String>(
              underline: SizedBox(),
              isExpanded: true,
              value:
                  defaultValueSubCategoryEngines, // Set the default value here
              items: optionsSubCategoryEngines.map((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
              onChanged: (newValue) {
                setState(() {
                  defaultValueSubCategoryEngines = newValue!;
                });
              },
            ),
          ),
        ],
      );
    } else if (defaultValueCategory == "مشاتل وحدائق") {
      return Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Align(
            alignment: Alignment.centerRight,
            child: Text(
              "الفئة الفرعية",
              style: GoogleFonts.tajawal(
                fontSize: 16.sp,
                fontStyle: FontStyle.normal,
                color: Colors.black,
              ),
              textDirection: TextDirection.ltr,
            ),
          ),
          SizedBox(
            height: 6.h,
          ),
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8.0), // Apply border radius
              color: Color(0XFFF3F3F9), // Apply background color
            ),
            padding: EdgeInsets.symmetric(
                horizontal: 16.0), // Add some horizontal padding
            child: DropdownButton<String>(
              underline: SizedBox(),
              isExpanded: true,
              value:
                  defaultValueSubCategoryNurseriesandGardens, // Set the default value here
              items: optionsSubCategoryNurseriesandGardens.map((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
              onChanged: (newValue) {
                setState(() {
                  defaultValueSubCategoryNurseriesandGardens = newValue!;
                });
              },
            ),
          ),
        ],
      );
    } else {
      return SizedBox();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Color(0xffF8F8F8),
        title: Text(
          "إضافة خدمة",
          style: GoogleFonts.tajawal(
            fontSize: 17.sp,
            color: Colors.black,
            fontWeight: FontWeight.w600,
          ),
        ),
        leadingWidth: 90.w,
        leading: SizedBox(),
        actions: [
          Padding(
            padding: EdgeInsets.only(left: 15.w),
            child: Icon(
              Icons.notifications_none_rounded,
              color: Color(0xffC7C7C7),
            ),
          )
        ],
        toolbarHeight: 60.h,
      ),
      body: ListView(
        padding: EdgeInsets.symmetric(horizontal: 16.w),
        children: [
          SizedBox(
            height: 45.h,
          ),
          TextFieldStyle(
            isenablelable: true,
            lableText: "اسم الخدمة",
            hintText: 'اسم الخدمة',
            codeTextController: _servicename,
            obscureText: false,
            inputType: TextInputType.name,
          ),
          SizedBox(
            height: 11.h,
          ),
          Align(
            alignment: Alignment.centerRight,
            child: Text(
              "الفئة",
              style: GoogleFonts.tajawal(
                fontSize: 16.sp,
                fontStyle: FontStyle.normal,
                color: Colors.black,
              ),
              textDirection: TextDirection.ltr,
            ),
          ),
          SizedBox(
            height: 6.h,
          ),
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8.0), // Apply border radius
              color: Color(0XFFF3F3F9), // Apply background color
            ),
            padding: EdgeInsets.symmetric(
                horizontal: 16.0), // Add some horizontal padding
            child: DropdownButton<String>(
              underline: SizedBox(),
              isExpanded: true,
              value: defaultValueCategory, // Set the default value here
              items: optionsCategory.map((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
              onChanged: (newValue) {
                setState(() {
                  defaultValueCategory = newValue!;
                });
              },
            ),
          ),
          SizedBox(
            height: 11.h,
          ),
          subcategorydropdoun(defaultValueCategory),
          SizedBox(
            height: 11.h,
          ),
          TextFieldStyle(
            isenablelable: true,
            lableText: "وصف صغير للخدمة",
            hintText: 'وصف صغير للخدمة',
            codeTextController: _servicedesshort,
            obscureText: false,
            inputType: TextInputType.text,
          ),
          SizedBox(
            height: 11.h,
          ),
          Column(
            children: [
              Align(
                alignment: Alignment.centerRight,
                child: Text(
                  "وصف طويل للخدمة",
                  style: GoogleFonts.tajawal(
                    fontSize: 16.sp,
                    fontStyle: FontStyle.normal,
                    color: Colors.black,
                  ),
                  textDirection: TextDirection.ltr,
                ),
              ),
              SizedBox(
                height: 6.h,
              ),
              TextFormField(
                controller: _servicedeslong,
                keyboardType: TextInputType.text,
                minLines: 6,
                maxLines: 12,
                // maxLength: 50,
                cursorHeight: 25.h,
                textAlign: TextAlign.start,
                textAlignVertical: TextAlignVertical.top,
                decoration: InputDecoration(
                  contentPadding: const EdgeInsets.all(18),
                  counterText: "",
                  alignLabelWithHint: true,
                  labelText: "وصف طويل للخدمة",
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
          SizedBox(
            height: 11.h,
          ),
          Column(
            children: [
              Align(
                alignment: Alignment.centerRight,
                child: Text(
                  "السعر بالدينار",
                  style: GoogleFonts.tajawal(
                    fontSize: 16.sp,
                    fontStyle: FontStyle.normal,
                    color: Colors.black,
                  ),
                  textDirection: TextDirection.ltr,
                ),
              ),
              SizedBox(
                height: 6.h,
              ),
              TextField(
                controller: _serviceprice,
                obscureText: false,
                keyboardType: TextInputType.number,
                maxLines: 1,
                maxLength: 50,
                cursorHeight: 25.h,
                decoration: InputDecoration(
                  contentPadding: const EdgeInsets.all(18),
                  counterText: "",
                  labelText: "50",
                  labelStyle: TextStyle(
                      color: Color(0XFFBCBCBC),
                      fontWeight: FontWeight.normal,
                      fontSize: 18),
                  floatingLabelBehavior: FloatingLabelBehavior.never,
                  fillColor: Color(0XFFF3F3F9),
                  filled: true,
                  suffixIcon: SizedBox(
                    width: 30.w,
                    child: Align(
                        alignment: Alignment.centerLeft,
                        child: Padding(
                          padding: EdgeInsets.only(left: 16.w),
                          child: Text(
                            "د.ك",
                            style: GoogleFonts.tajawal(
                              color: Color(0xffFED235),
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        )),
                  ),
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
          SizedBox(
            height: 11.h,
          ),
          Column(
            children: [
              Align(
                alignment: Alignment.centerRight,
                child: Text(
                  "الايميل لتواصل الزبون",
                  style: GoogleFonts.tajawal(
                    fontSize: 16.sp,
                    fontStyle: FontStyle.normal,
                    color: Colors.black,
                  ),
                  textDirection: TextDirection.ltr,
                ),
              ),
              SizedBox(
                height: 6.h,
              ),
              TextField(
                controller: _serviceemail,
                obscureText: false,
                keyboardType: TextInputType.emailAddress,
                maxLines: 1,
                maxLength: 50,
                cursorHeight: 25.h,
                decoration: InputDecoration(
                  contentPadding: const EdgeInsets.all(18),
                  counterText: "",
                  // labelText: "yousefael2020@gmail.com",
                  hintText: "example@gmail.com",
                  labelStyle: TextStyle(
                      color: Color(0XFFBCBCBC),
                      fontWeight: FontWeight.normal,
                      fontSize: 18),
                  floatingLabelBehavior: FloatingLabelBehavior.never,
                  fillColor: Color(0XFFF3F3F9),
                  filled: true,
                  suffixIcon: SizedBox(
                    width: 30.w,
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Padding(
                        padding: EdgeInsets.only(left: 16.w),
                        child: Image.asset("images/svgexport-17 (10).png"),
                      ),
                    ),
                  ),
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
          SizedBox(
            height: 11.h,
          ),
          Column(
            children: [
              Align(
                alignment: Alignment.centerRight,
                child: Text(
                  "رقم الهاتف لتواصل الزبون",
                  style: GoogleFonts.tajawal(
                    fontSize: 16.sp,
                    fontStyle: FontStyle.normal,
                    color: Colors.black,
                  ),
                  textDirection: TextDirection.ltr,
                ),
              ),
              SizedBox(
                height: 6.h,
              ),
              TextField(
                controller: _servicephone,
                obscureText: false,
                keyboardType: TextInputType.number,
                maxLines: 1,
                maxLength: 50,
                cursorHeight: 25.h,
                decoration: InputDecoration(
                  contentPadding: const EdgeInsets.all(18),
                  counterText: "",
                  // labelText: "059555555",
                  hintText: "أدخل رقم الهاتف",
                  hintStyle: TextStyle(
                      color: Color(0XFFBCBCBC),
                      fontWeight: FontWeight.normal,
                      fontSize: 18),
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
          SizedBox(
            height: 11.h,
          ),
          Card(
            color: Color(0XFFF3F3F9),
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.r)),
            child: ListTile(
              leading: Icon(
                Icons.add,
                color: Color(0xffFED235),
                size: 30.r,
              ),
              onTap: () {
                _showBottomSheet(context);
              },
              title: Text(
                "إضافة صور للخدمة",
                style: GoogleFonts.tajawal(
                  fontSize: 16.sp,
                ),
              ),
              trailing: Image.asset("images/svgexport-17 (16).png"),
            ),
          ),
          Text(
            "أضف أكثر من صورة للمشكلة حتى يسهل تحديد وفهم المشكلة",
            textAlign: TextAlign.center,
            style: GoogleFonts.tajawal(
              fontSize: 10.sp,
              color: Color(0xffA3A3A3),
            ),
          ),
          Visibility(
            visible: _newProduct.imagePaths.isNotEmpty,
            child: Container(
              height: 150, // Set the desired height for the container
              child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: _newProduct.imagePaths.length,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Image.file(
                        File(_newProduct.imagePaths[index]),
                        width: 100, // Set the desired width for each image
                        fit: BoxFit.cover,
                      ),
                    );
                  }),
            ),
          ),
          SizedBox(
            height: 12.h,
          ),
          Card(
            color: Color(0XFFF3F3F9),
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.r)),
            child: ListTile(
              onTap: () {
                _pickAndUploadVideo();
              },
              leading: Icon(
                Icons.add,
                color: Color(0xffFED235),
                size: 30.r,
              ),
              title: Text(
                "إضافة فيديو للخدمة",
                style: GoogleFonts.tajawal(
                  fontSize: 16.sp,
                ),
              ),
              trailing: Image.asset("images/svgexport-17 (74).png"),
            ),
          ),
          Visibility(
            visible: _newProduct.videoPath.isNotEmpty,
            child: Container(
              color: Colors.black,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(25),
                  child: VideoPlayerFromUrl(
                    videoUrl: _newProduct.videoPath,
                    dataSourceType: DataSourceType.network,
                  ),
                ),
              ),
            ),
          ),
          SizedBox(
            height: 18.h,
          ),
          ElevatedButton(
            onPressed: () async {
              if (defaultValueCategory == "مقاولات") {
                await performSave(defaultValueSubCategoryConstruction,
                    category: defaultValueCategory);
              } else if (defaultValueCategory == "عقارات") {
                await performSave(defaultValueSubCategoryRealEstates,
                    category: defaultValueCategory);
              } else if (defaultValueCategory == 'أثاث ومفروشات') {
                await performSave(defaultValueSubCategoryFurniture,
                    category: defaultValueCategory);
              } else if (defaultValueCategory == 'مركبات') {
                await performSave(defaultValueSubCategoryEngines,
                    category: defaultValueCategory);
              } else if (defaultValueCategory == "مشاتل وحدائق") {
                await performSave(defaultValueSubCategoryNurseriesandGardens,
                    category: defaultValueCategory);
              } else {
                await performSave(null, category: defaultValueCategory);
              }
            },
            child: Text(
              "تأكيد",
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
          ),
          SizedBox(
            height: 16.h,
          )
        ],
      ),
    );
  }

  Future<void> performSave(String? sub_category,
      {required String category}) async {
    if (checkData()) {
      _saveProduct(category, sub_category);
    }
  }

  bool checkData() {
    if (_servicename.text.isNotEmpty &&
        defaultValueCategory.isNotEmpty &&
        _servicedeslong.text.isNotEmpty &&
        _serviceprice.text.isNotEmpty &&
        // _servicedata.text.isNotEmpty &&
        _serviceemail.text.isNotEmpty &&
        _servicephone.text.isNotEmpty) {
      return true;
    } else {
      showSnackBar(
          context: context, message: "أدخل البيانات المطلوبة", error: true);
      return false;
    }
  }

  void _showBottomSheet(BuildContext context) {
    showModalBottomSheet(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
            topLeft: Radius.circular(50.r), topRight: Radius.circular(50.r)),
      ),
      context: context,
      builder: (BuildContext context) {
        return Container(
          padding: EdgeInsets.symmetric(horizontal: 50.w, vertical: 39.h),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ElevatedButton(
                onPressed: () {
                  // Get.to(() => LoginScreen());
                },
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    SizedBox(
                      width: 41.3.w,
                    ),
                    Icon(
                      Icons.add_a_photo,
                      color: Color(0xffFED235),
                    ),
                    SizedBox(
                      width: 16.5.w,
                    ),
                    Text(
                      'التقاط صورة',
                      style: GoogleFonts.tajawal(
                        fontSize: 18.sp,
                        fontWeight: FontWeight.bold,
                        color: Color(0XFFFED235),
                      ),
                    ),
                  ],
                ),
                style: ElevatedButton.styleFrom(
                  minimumSize: Size(343.w, 52.h),
                  backgroundColor: Colors.transparent,
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
              SizedBox(
                height: 20.h,
              ),
              ElevatedButton(
                onPressed: () {
                  _pickAndUploadImage();
                },
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    SizedBox(
                      width: 41.3.w,
                    ),
                    Icon(
                      Icons.photo_outlined,
                      color: Colors.white,
                    ),
                    SizedBox(
                      width: 16.5.w,
                    ),
                    Text(
                      "المعرض",
                      style: GoogleFonts.tajawal(
                        fontSize: 18.sp,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
                style: ElevatedButton.styleFrom(
                  minimumSize: Size(343.w, 52.h),
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
        );
      },
    );
  }
}

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:kawait/Screens/Home/HomePages/Category_Page.dart';
import 'package:kawait/Screens/Home/HomePages/Fav_Page.dart';
import 'package:kawait/Screens/Home/HomePages/HomePageScreens/add_service.dart';
import 'package:kawait/Screens/Home/HomePages/Home_Page.dart';
import 'package:kawait/Screens/Home/HomePages/More_Page.dart';
import 'package:kawait/Screens/Home/HomePages/Profile_Page.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int current_index = 2;
  int current_index1 = 1;
  final List<Widget> pages = [
    ProfilePage(),
    CategoryPage(),
    HomePage(),
    FavPage(),
    MorePage()
  ];

  final List<Widget> pages1 = [
    CategoryPage(),
    HomePage(),
    FavPage(),
    MorePage()
  ];

  void OnTapped(int index) {
    setState(() {
      current_index = index;
    });
  }

  void OnTapped1(int index) {
    setState(() {
      current_index1 = index;
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    // Get.put(CategoriesGetxController());
    super.initState();
  }

  final arguments = Get.arguments as String?;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      extendBody: true,
      body: arguments == "1" ? pages[current_index] : pages1[current_index1],
      bottomNavigationBar: Container(
        height: 72.h,
        width: 375.w,
        padding: EdgeInsets.all(0),
        margin: EdgeInsets.all(0),
        child: ClipRRect(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            mainAxisSize: MainAxisSize.min,
            children: [
              arguments == "1"
                  ? Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Container(
                          height: 2.h,
                          width: 42.w,
                          decoration: BoxDecoration(
                            color: arguments == "1"
                                ? current_index == 0
                                    ? Color(0xffFED235)
                                    : Colors.transparent
                                : current_index1 == 0
                                    ? Color(0xffFED235)
                                    : Colors.transparent,
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(2.r),
                              topRight: Radius.circular(2.r),
                            ),
                          ),
                        ),
                        Container(
                          height: 2.h,
                          width: 42.w,
                          decoration: BoxDecoration(
                            color: arguments == "1"
                                ? current_index == 1
                                    ? Color(0xffFED235)
                                    : Colors.transparent
                                : current_index1 == 1
                                    ? Color(0xffFED235)
                                    : Colors.transparent,
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(2.r),
                              topRight: Radius.circular(2.r),
                            ),
                          ),
                        ),
                        Container(
                          height: 2.h,
                          width: 42.w,
                          decoration: BoxDecoration(
                            color: arguments == "1"
                                ? current_index == 2
                                    ? Color(0xffFED235)
                                    : Colors.transparent
                                : current_index1 == 2
                                    ? Color(0xffFED235)
                                    : Colors.transparent,
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(2.r),
                              topRight: Radius.circular(2.r),
                            ),
                          ),
                        ),
                        Container(
                          height: 2.h,
                          width: 42.w,
                          decoration: BoxDecoration(
                            color: arguments == "1"
                                ? current_index == 3
                                    ? Color(0xffFED235)
                                    : Colors.transparent
                                : current_index1 == 3
                                    ? Color(0xffFED235)
                                    : Colors.transparent,
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(2.r),
                              topRight: Radius.circular(2.r),
                            ),
                          ),
                        ),
                        Container(
                          height: 2.h,
                          width: 42.w,
                          decoration: BoxDecoration(
                            color: arguments == "1"
                                ? current_index == 4
                                    ? Color(0xffFED235)
                                    : Colors.transparent
                                : current_index1 == 4
                                    ? Color(0xffFED235)
                                    : Colors.transparent,
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(2.r),
                              topRight: Radius.circular(2.r),
                            ),
                          ),
                        ),
                      ],
                    )
                  : Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Container(
                          height: 2.h,
                          width: 42.w,
                          decoration: BoxDecoration(
                            color: current_index1 == 0
                                ? Color(0xffFED235)
                                : Colors.transparent,
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(2.r),
                              topRight: Radius.circular(2.r),
                            ),
                          ),
                        ),
                        Container(
                          height: 2.h,
                          width: 42.w,
                          decoration: BoxDecoration(
                            color: current_index1 == 1
                                ? Color(0xffFED235)
                                : Colors.transparent,
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(2.r),
                              topRight: Radius.circular(2.r),
                            ),
                          ),
                        ),
                        Container(
                          height: 2.h,
                          width: 42.w,
                          decoration: BoxDecoration(
                            color: current_index1 == 2
                                ? Color(0xffFED235)
                                : Colors.transparent,
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(2.r),
                              topRight: Radius.circular(2.r),
                            ),
                          ),
                        ),
                        Container(
                          height: 2.h,
                          width: 42.w,
                          decoration: BoxDecoration(
                            color: current_index1 == 3
                                ? Color(0xffFED235)
                                : Colors.transparent,
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(2.r),
                              topRight: Radius.circular(2.r),
                            ),
                          ),
                        ),
                      ],
                    ),
              BottomNavigationBar(
                type: BottomNavigationBarType.fixed,
                backgroundColor: Color(0XFFFFFFFF),
                iconSize: 28.0.r,
                selectedIconTheme: IconThemeData(size: 24.0.r),
                selectedItemColor: Color(0xffFED235),
                unselectedItemColor: Colors.black,
                selectedFontSize: 10.sp,
                unselectedFontSize: 10.sp,
                currentIndex: arguments == "1" ? current_index : current_index1,
                onTap: arguments == "1" ? OnTapped : OnTapped1,
                items: arguments == "1"
                    ? <BottomNavigationBarItem>[
                        BottomNavigationBarItem(
                          icon: Icon(Icons.person_2_outlined),
                          label: "ملفي",
                        ),
                        BottomNavigationBarItem(
                          icon: Icon(Icons.category_outlined),
                          label: "التصنيفات",
                        ),
                        BottomNavigationBarItem(
                          icon: Icon(Icons.home_outlined),
                          label: "الرئيسية",
                        ),
                        BottomNavigationBarItem(
                          icon: Icon(Icons.favorite_border),
                          label: "المفضلة",
                        ),
                        BottomNavigationBarItem(
                          icon: Icon(CupertinoIcons.list_bullet),
                          label: "المزيد",
                        ),
                      ]
                    : <BottomNavigationBarItem>[
                        BottomNavigationBarItem(
                          icon: Icon(Icons.category_outlined),
                          label: "التصنيفات",
                        ),
                        BottomNavigationBarItem(
                          icon: Icon(Icons.home_outlined),
                          label: "الرئيسية",
                        ),
                        BottomNavigationBarItem(
                          icon: Icon(Icons.favorite_border),
                          label: "المفضلة",
                        ),
                        BottomNavigationBarItem(
                          icon: Icon(CupertinoIcons.list_bullet),
                          label: "المزيد",
                        ),
                      ],
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: arguments == "1"
          ? Visibility(
              visible: current_index == 2,
              child: ElevatedButton(
                child: Icon(Icons.add),
                onPressed: () {
                  Get.to(() => AddService());
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color(0xffFED235),
                  shape: CircleBorder(),
                  minimumSize: Size(52.w, 52.h),
                ),
              ),
            )
          : SizedBox(),
    );
  }
}

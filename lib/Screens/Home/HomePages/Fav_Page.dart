import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:kawait/Shared%20preferences/shared_preferences.dart';
import 'package:kawait/utils/helpers.dart';

class FavPage extends StatefulWidget {
  const FavPage({super.key});

  @override
  State<FavPage> createState() => _FavPageState();
}

class _FavPageState extends State<FavPage> with Helpers {
  Future<List<Map<String, dynamic>>> getFavorites() async {
    final userId = AppSettingsPreferences().user().id;
    final snapshot = await FirebaseFirestore.instance
        .collection('users')
        .doc(userId)
        .collection('favorites')
        .get();

    List<Map<String, dynamic>> favorites = [];
    snapshot.docs.forEach((doc) {
      Map<String, dynamic> favoriteData = doc.data();
      favoriteData['id'] = doc.id; // Add the document ID to the map
      favorites.add(favoriteData);
    });

    return favorites;
  }

  Widget buildFavoritesList(List<Map<String, dynamic>> favorites) {
    if (favorites.isEmpty) {
      return Container(
        margin: EdgeInsets.symmetric(
          horizontal: 15.w,
          vertical: 15.h,
        ),
        height: 151.h,
        width: double.infinity,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8.0.r),
          color: Color(0xffF8F8F7),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5), // Shadow color
              spreadRadius: 2, // How far the shadow spreads
              blurRadius: 10, // Soften the shadow
              offset: Offset(2, 2), // Offset in the X and Y direction
            ),
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.warning,
              size: 80.r,
              color: const Color.fromARGB(255, 201, 8, 8),
            ),
            SizedBox(
              width: 15.w,
            ),
            Text(
              'لا يوجد عناصر في المفضلة',
              style: GoogleFonts.tajawal(
                fontSize: 16.sp,
                color: const Color.fromARGB(255, 201, 8, 8),
                fontWeight: FontWeight.bold,
              ),
            )
          ],
        ),
      );
    } else {
      return ListView.builder(
        itemCount: favorites.length,
        itemBuilder: (context, index) {
          final favoriteItem = favorites[index];
          // Use the favoriteItem to display your UI components
          // For example, you can use ListTile or any other widgets
          // to display the favorite item's details.
          List<String> imageUrls =
              List.castFrom<dynamic, String>(favoriteItem['imageUrls'] ?? []);
          return Stack(
            children: [
              Container(
                decoration: BoxDecoration(color: Color(0xffF9F9F9)),
                margin: EdgeInsets.only(right: 15.w, left: 15.w, bottom: 10.h),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    imageUrls.length == 0
                        ? Image.asset(
                            "images/buoyant-successful-handyman-posing-against-white-wall.png",
                          )
                        : SizedBox(
                            width: 125.w,
                            height: 95.h,
                            child: ClipRRect(
                              borderRadius: BorderRadius.only(
                                topRight: Radius.circular(8.r),
                                bottomRight: Radius.circular(8.r),
                              ),
                              child: Image.network(
                                imageUrls[0],
                                width: 70.w,
                                height: 50.h,
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                    SizedBox(
                      width: 12.w,
                    ),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          SizedBox(
                            height: 18.h,
                          ),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text(
                                favoriteItem['name'],
                                style: GoogleFonts.tajawal(
                                  fontSize: 16.sp,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                              SizedBox(
                                width: 10.w,
                              ),
                              Text(
                                favoriteItem['categoryName'] == null
                                    ? ""
                                    : favoriteItem['categoryName'],
                                style: GoogleFonts.tajawal(
                                  fontSize: 9.sp,
                                  color: Color(0xff6D6D6D),
                                ),
                              )
                            ],
                          ),
                          SizedBox(
                            height: 11.h,
                          ),
                          Text(
                            favoriteItem['shortDescription'] == null
                                ? ""
                                : favoriteItem['shortDescription'],
                            style: GoogleFonts.tajawal(
                              fontSize: 10.sp,
                            ),
                          ),
                          SizedBox(
                            height: 9.h,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment
                                .start, // Move this row to the left
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Spacer(),
                              Text(
                                favoriteItem['price'] == null
                                    ? ""
                                    : favoriteItem['price'] + "د.ك",
                                style: GoogleFonts.tajawal(
                                  fontWeight: FontWeight.bold,
                                  color: Color(0xffFED235),
                                ),
                              ),
                              SizedBox(
                                width: 15.w,
                              )
                            ],
                          )
                        ],
                      ),
                    )
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.only(left: 30.w, top: 10.4.h),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Align(
                      alignment: Alignment.topLeft,
                      child: InkWell(
                        onTap: () {
                          _removeFavoriteItem(favoriteItem);
                          setState(() {
                            favorites.remove(favoriteItem);
                          });
                        },
                        child: Icon(
                          Icons.delete_forever_outlined,
                          color: Color(0XFFFF1E1E),
                        ),
                      ),
                    ),
                    Align(
                      alignment: Alignment.topLeft,
                      child: InkWell(
                        onTap: () {
                          _removeFavoriteItem(favoriteItem);
                        },
                        child: Icon(
                          Icons.favorite,
                          color: Color(0XFFFF1E1E),
                        ),
                      ),
                    ),
                  ],
                ),
              )
            ],
          );
        },
      );
    }
  }

  Future<void> removeFavorite(String favoriteId) async {
    final userId = AppSettingsPreferences().user().id;
    await FirebaseFirestore.instance
        .collection('users')
        .doc(userId)
        .collection('favorites')
        .doc(favoriteId)
        .delete();
  }

  void _removeFavoriteItem(Map<String, dynamic> favoriteItem) {
    final String favoriteId = favoriteItem[
        'id']; // Replace 'id' with the actual field name of the document ID
    removeFavorite(favoriteId)
        .then((_) => showSnackBar(context: context, message: 'تم حذفها بنجاح'))
        .catchError((error) => showSnackBar(
            context: context, message: 'خطأ في الحذف', error: true));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Color(0xffF8F8F8),
        title: Text(
          "المفضلة",
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
      body: Container(
        color: Colors.white,
        margin: EdgeInsets.only(top: 30.h),
        child: FutureBuilder<List<Map<String, dynamic>>>(
          future: getFavorites(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(
                child: CircularProgressIndicator(),
              );
            } else if (snapshot.hasError) {
              return Center(
                child: Text('Error: ${snapshot.error}'),
              );
            } else {
              List<Map<String, dynamic>> favorites = snapshot.data!;
              return buildFavoritesList(favorites);
            }
          },
        ),
      ),
    );
  }
}

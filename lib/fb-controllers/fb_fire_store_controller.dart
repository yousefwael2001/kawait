import 'dart:async';
import 'dart:core';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:kawait/Shared%20preferences/shared_preferences.dart';
import 'package:kawait/utils/helpers.dart';

class FbFireStoreController with Helpers {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // each collection implement table
  // CRUD
  // Future<bool> create({required Note note}) async {
  //   return await _firestore
  //       .collection('Notes')
  //       .doc('note')
  //       .set(note.toMap())
  //       .then((value) => true) // في حال نجحت العملية
  //       .catchError(
  //           (error) => false); // في حال فشلت العملية وهم بديلات عن ال await
  // }

  Future<bool> addtoFav(Map<String, dynamic> fav, BuildContext context) async {
    try {
      final userId = AppSettingsPreferences().user().id;
      final docRef = await _firestore
          .collection('users')
          .doc(userId)
          .collection('favorites')
          .add(fav);
      showSnackBar(context: context, message: 'تم إضافة العنصر الى المفضلة');
      return true;
    } catch (error) {
      showSnackBar(
          context: context,
          message: 'خطأ في إضافة العنصر الى المفضلة',
          error: true);
      return false;
    }
  }

  Stream<QuerySnapshot> read() async* {
    yield* _firestore.collection('categories').snapshots();
  }

  // Future<bool> update({required Note note}) async {
  //   return _firestore
  //       .collection('Notes')
  //       .doc(note.id)
  //       .update(note.toMap())
  //       .then((value) => true)
  //       .catchError((error) => false);
  // }

  // Future<bool> updatePatient({required Patient patient}) async {
  //   return _firestore
  //       .collection('Patients')
  //       .doc(patient.id.toString())
  //       .update(patient.toMap())
  //       .then((value) => true)
  //       .catchError((error) => false);
  // }

  // Future<bool> delete({required String path}) async {
  //   return _firestore
  //       .collection('Notes')
  //       .doc(path)
  //       .delete()
  //       .then((value) => true)
  //       .catchError((error) => false);
  // }
}

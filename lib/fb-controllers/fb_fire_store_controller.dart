import 'package:cloud_firestore/cloud_firestore.dart';

class FbFireStoreController {
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

  // Future<bool> registerPatient({required Patient patient}) async {
  //   return await _firestore
  //       .collection('Patients')
  //       .add(patient.toMap())
  //       .then((value) => true) // في حال نجحت العملية
  //       .catchError(
  //           (error) => false); // في حال فشلت العملية وهم بديلات عن ال await
  // }

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

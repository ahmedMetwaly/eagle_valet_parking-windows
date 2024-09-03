import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';
import '../../models/employer_model.dart';


class EmployerRepo {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future saveEmployerData(EmployerModel employer) async {
    try {
      ////print"employer id :${employer.uid}");
      await _firestore.collection('employers').doc(employer.uid).set(employer.toJson());
    } catch (error) {
     // debug////print'Error saving employer data: $error');
      throw Exception("Error while saving data to the database $error");
    }
  }

  Future getEmployerData(String employerId) async {
    try {
      final documentSnapshot =
          await _firestore.collection('employers').doc(employerId).get();
      if (documentSnapshot.exists) {
        return EmployerModel.fromJson(documentSnapshot.data() ?? {});
      } else {
        return {}; // Return empty map if employer doesn't exist
      }
    } catch (error) {
      // Handle errors appropriately
      throw Exception('Error getting employer data: $error');
      //////print'Error getting employer data: $error');
      //return {}; // Return empty map on error
    }
  }

  Future updataEmployerData(
      {required String employerId,
      required String field,
      required dynamic data}) async {
    ////print"employerId $employerId");

    try {
      //print"fire");
      await _firestore
          .collection("employers")
          .doc(employerId)
          .update({field: data}).then((value){//print"done");}). catchError((error) {
        throw Exception('Failed to update employer data');
      });
    } catch (error) {
      ////printerror);
      throw Exception('Failed to update employer data');
    }
  }

  Future<String> uploadImage(
      {required String employerId, required XFile image}) async {
    try {
      final storage = FirebaseStorage.instance;
      final imageName = '$employerId.jpg';
      final reference = storage.ref().child('profile_pictures/$imageName');
      final uploadTask = reference.putFile(File(image.path));
      final snapshot = await uploadTask.whenComplete(() => null);
      final url = await snapshot.ref.getDownloadURL();
      await updataEmployerData(employerId: employerId, field: "imageUrl", data: url);
      return url.toString();
    } catch (error) {
      ////print"error yad");
      throw Exception("Faild to Upload Image");
    }
  }


  /* Future deleteHistoryItem(String employerID, List data) async {
    try {
      await _firestore.collection("employers").doc(employerID).set(
          {"history": data}).then((value) => debug////print"delete history item"));
    } catch (error) {
      throw Exception("Faild to delete history item");
    }
  } */
}

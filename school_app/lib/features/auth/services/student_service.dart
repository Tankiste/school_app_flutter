import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:school_app/features/auth/model/student.dart';
import 'package:school_app/services/firebase_services.dart';

class StudentService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseServices _services = FirebaseServices();

  Future<String> registerStudent({
    required String name,
    required String gender,
    required String nationality,
    required String promotion,
    required String email,
    required String password,
  }) async {
    String resp = 'Some Error occured';
    try {
      if (name.isNotEmpty &&
          gender.isNotEmpty &&
          nationality.isNotEmpty &&
          promotion.isNotEmpty &&
          email.isNotEmpty &&
          password.isNotEmpty) {
        UserCredential cred = await _auth.createUserWithEmailAndPassword(
            email: email, password: password);

        StudentData studentData = StudentData(
            uid: cred.user!.uid,
            name: name,
            gender: gender,
            nationality: nationality,
            promotion: promotion,
            email: email);

        studentData.logo = "";
        studentData.bio = "";
        studentData.date = Timestamp.now();

        await _firestore
            .collection('users')
            .doc(cred.user!.uid)
            .set(studentData.toMap());

        resp = 'success';
      }
    } catch (err) {
      resp = err.toString();
    }
    return resp;
  }

  Future<String> loginStudent(
      {required String email, required String password}) async {
    String res = 'Some error occured';

    try {
      if (email.isNotEmpty && password.isNotEmpty) {
        await _auth.signInWithEmailAndPassword(
            email: email, password: password);
        res = 'success';
      } else {
        res = 'Please Enter All The Fields!';
      }
    } catch (err) {
      res = err.toString();
    }
    return res;
  }

  Future<StudentData> getStudentDetails() async {
    User currentUser = _auth.currentUser!;
    DocumentSnapshot snap =
        await _firestore.collection('users').doc(currentUser.uid).get();
    return StudentData.fromSnap(snap);
  }

  Future<StudentData> getUserDetails() async {
    User currentUser = _auth.currentUser!;
    DocumentSnapshot snap =
        await _firestore.collection('users').doc(currentUser.uid).get();
    // print('stud id: ${currentUser.uid}');
    // print('imagelink ${snap['Logolink']}');
    return StudentData.fromSnap(snap);
  }

  Future<String> updateAccount({
    String? bio,
    File? logo,
  }) async {
    String resp = 'Some Error occured';
    User currentUser = _auth.currentUser!;

    DocumentReference userDocRef =
        FirebaseFirestore.instance.collection('users').doc(currentUser.uid);

    DocumentSnapshot studentSnapshot = await userDocRef.get();

    String? currentLogo = studentSnapshot.get('Logolink');
    String? currentBio = studentSnapshot.get('Bio');

    String? updatedLogo = logo != null
        ? await _services.uploadImageToStorage('Logo', logo)
        : currentLogo;
    String? updatedBio;
    bool isBioChanged = false;
    bool isLogoChanged = false;
    if (bio != null) {
      if (bio == "") {
        updatedBio = currentBio;
      } else if (bio != currentBio) {
        updatedBio = bio;
        isBioChanged = true;
      } else if (bio == currentBio) {
        updatedBio = bio;
      }
    } else {
      updatedBio = currentBio;
    }

    if (logo != null) {
      if (updatedLogo != currentLogo) {
        isLogoChanged = true;
      }
    }

    Map<String, dynamic> updatedData = {
      'Bio': updatedBio,
      'Logolink': updatedLogo
    };

    try {
      if (isLogoChanged || isBioChanged) {
        await userDocRef.update(updatedData);
        resp = 'success';
        print('Fields successfully updated!');
      } else {
        resp = 'no_change';
        print('No changes to update');
      }
    } catch (e) {
      resp = e.toString();
      print('Error during update: $e');
    }

    return resp;
  }

  Future<String> resetPassword(String email) async {
    String resp = 'Some Error occured';
    try {
      await _auth.sendPasswordResetEmail(email: email);
      resp = 'success';
      print('Password reset email sent to $email');
    } catch (e) {
      resp = e.toString();
      print('Failed to send password reset email: $e');
    }
    return resp;
  }

  Future<void> logout() async {
    await _auth.signOut();
  }
}

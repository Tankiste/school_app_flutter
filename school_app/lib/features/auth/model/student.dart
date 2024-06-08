import 'package:cloud_firestore/cloud_firestore.dart';

class StudentData {
  String uid;
  String name;
  String? bio;
  String? logo;
  String gender;
  String nationality;
  String promotion;
  String email;
  String? password;
  Timestamp? date = Timestamp.now();

  StudentData({
    required this.uid,
    required this.name,
    this.bio,
    this.logo,
    required this.gender,
    required this.nationality,
    required this.promotion,
    required this.email,
    this.password,
    this.date,
  });

  Map<String, dynamic> toMap() {
    return {
      'uid': uid,
      'Full Name': name,
      'Bio': bio,
      'Logolink': logo,
      'Gender': gender,
      'Nationality': nationality,
      'Promotion': promotion,
      'Email': email,
      'Registration Date': date,
    };
  }

  static StudentData fromSnap(DocumentSnapshot snap) {
    var snapshot = snap.data() as Map<String, dynamic>;

    return StudentData(
        uid: snapshot['uid'],
        name: snapshot['Full Name'],
        logo: snapshot['Logolink'],
        bio: snapshot['Bio'],
        date: snapshot['Registration Date'],
        gender: snapshot['Gender'],
        nationality: snapshot['Nationality'],
        promotion: snapshot['Promotion'],
        email: snapshot['Email']);
  }
}

import 'package:flutter/material.dart';
import 'package:school_app/features/auth/model/student.dart';
import 'package:school_app/features/auth/services/student_service.dart';

class ApplicationState extends ChangeNotifier {
  bool isSwitched = false;
  bool isSellerMode = true;
  bool isSeller = false;
  bool isLiked = false;
  int currentIndex = 0;
  int totalLike = 0;
  StudentData? _user;
  final StudentService _studService = StudentService();

  StudentData? get getUser => _user;

  Future<void> refreshUser() async {
    try {
      StudentData user = await _studService.getUserDetails();
      _user = user;
    } catch (error) {
    } finally {
      notifyListeners();
    }
  }

  Future<void> logoutUser(BuildContext context) async {
    _user = null;
    notifyListeners();
  }
}

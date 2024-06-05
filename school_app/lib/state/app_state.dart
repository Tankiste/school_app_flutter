import 'package:flutter/material.dart';

class ApplicationState extends ChangeNotifier {
  bool isSwitched = false;
  bool isLiked = false;
  int currentIndex = 0;
  int totalLike = 0;
}

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../constants/text_constants.dart';

class HomeController extends GetxController {
  final List<Tab> tabs = const [
    Tab(text: TextConstants.learning, icon: Icon(Icons.school)),
    Tab(text: TextConstants.mcq, icon: Icon(Icons.quiz)),
  ];
}
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../constants/text_constants.dart';

class HomeController extends GetxController with GetSingleTickerProviderStateMixin
{
  late TabController tabController;

  final List<Tab> tabs = const [
    Tab(text: TextConstants.learning),
    Tab(text: TextConstants.mcq),
  ];

  @override
  void onInit() {
    tabController = TabController(length: tabs.length, vsync: this);
    super.onInit();
  }

  @override
  void onClose() {
    tabController.dispose();
    super.onClose();
  }

  var selectedIndex = 0.obs;

  void changeTab(int index) {
    selectedIndex.value = index;
  }
}
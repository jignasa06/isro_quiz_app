import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:isro_quiz_app/module/learning/service/api_service.dart';

import '../../../constants/text_constants.dart';
import '../model/centre_model.dart';
import '../model/customer_satellite_model.dart';
import '../model/launcher_model.dart';
import '../model/spacecraft_model.dart';

class LearningController extends GetxController
    with GetSingleTickerProviderStateMixin {
  late TabController tabController;
  var tabIndex = 0.obs;
  final List<Tab> tabs = [
    Tab(text: TextConstants.spacecrafts),
    Tab(text: TextConstants.launchers),
    Tab(text: TextConstants.satellites),
    Tab(text: TextConstants.centres),
  ];
  var spacecrafts = <Spacecraft>[].obs;
  var launchers = <Launcher>[].obs;
  var satellites = <CustomerSatellite>[].obs;
  var centres = <Centre>[].obs;
  final isLoading = false.obs;
  final ApiService _service = ApiService();

  @override
  void onInit() {
    super.onInit();
    tabController = TabController(length: tabs.length, vsync: this);
    fetchAllData();
  }

  void changeTab(int index) {
    tabIndex.value = index;
  }

  void fetchAllData() async {
    try {
      isLoading.value = true;
      spacecrafts.value = await _service.fetchSpacecrafts();
      launchers.value = await _service.fetchLaunchers();
      satellites.value = await _service.fetchCustomerSatellites();
      centres.value = await _service.fetchCentres();
    } catch (e) {
      print("${TextConstants.error}: $e");
    } finally {
      isLoading.value = false;
    }
  }

  @override
  void onClose() {
    tabController.dispose();
    super.onClose();
  }
}

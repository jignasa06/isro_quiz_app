import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:isro_quiz_app/module/learning/controller/learning_controller.dart';
import 'package:isro_quiz_app/module/learning/service/api_service.dart';
import 'package:isro_quiz_app/module/learning/view/tab/centre_tab.dart';
import 'package:isro_quiz_app/module/learning/view/tab/launcher_tab.dart';
import 'package:isro_quiz_app/module/learning/view/tab/satellite_tab.dart';
import 'package:isro_quiz_app/module/learning/view/tab/spacecraft_tab.dart';

class LearningView extends StatelessWidget {
  final LearningController controller = Get.put(LearningController());
  final ApiService service = ApiService();

  LearningView({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TabBar(
          onTap: (index) => controller.changeTab(index),
          isScrollable: true,
          labelColor: Colors.blue,
          unselectedLabelColor: Colors.grey,
          padding: EdgeInsets.zero,
          labelPadding: const EdgeInsets.symmetric(horizontal: 16.0),
          indicatorPadding: EdgeInsets.zero,
          tabAlignment: TabAlignment.start,
          tabs: controller.tabs,
          controller: controller.tabController,
        ),
        Expanded(
          child: TabBarView(
            controller: controller.tabController,
            children: [
              SpacecraftTab(),
              LauncherTab(),
              SatelliteTab(),
              CentreTab(),
            ],
          ),
        ),
      ],
    );
  }
}

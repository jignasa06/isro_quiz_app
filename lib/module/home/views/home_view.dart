import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:isro_quiz_app/constants/text_constants.dart';
import 'package:isro_quiz_app/module/home/controller/home_controller.dart';
import '../../learning/view/learning_view.dart';
import 'mcq_view.dart';

class HomeView extends StatelessWidget {
  HomeView({super.key});

  final HomeController homeController = Get.put(HomeController());

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: homeController.tabs.length,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.black,
          title: Text(
            TextConstants.appTitle,
            style: TextStyle(color: Colors.white),
          ),
          bottom: TabBar(
            labelColor: Colors.white,
            controller: homeController.tabController,
            tabs: homeController.tabs,
          ),
        ),
        body: TabBarView(
          controller: homeController.tabController,
          children: [LearningView(), McqView()],
        ),
      ),
    );
  }
}

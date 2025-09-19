import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:isro_quiz_app/constants/text_constants.dart';
import 'package:isro_quiz_app/module/home/controller/home_controller.dart';
import 'package:isro_quiz_app/module/learning/view/learning_view.dart';
import 'package:isro_quiz_app/module/home/views/mcq_view.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> with SingleTickerProviderStateMixin {
  late final TabController _tabController;
  final HomeController _homeController = Get.put(HomeController());

  @override
  void initState() {
    super.initState();
    _tabController = TabController(
      length: _homeController.tabs.length,
      vsync: this,
      initialIndex: 0,
    );
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Text(
          TextConstants.appTitle,
          style: const TextStyle(color: Colors.white),
        ),
        bottom: TabBar(
          controller: _tabController,
          labelColor: Colors.white,
          unselectedLabelColor: Colors.grey[400],
          indicatorColor: Colors.white,
          tabs: _homeController.tabs,
          onTap: (index) {
            // Handle tab change if needed
          },
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        physics: const NeverScrollableScrollPhysics(), // Disable swipe
        children: [
          LearningView(),
          McqView(),
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:isro_quiz_app/module/learning/controller/learning_controller.dart';

class LauncherTab extends StatelessWidget {
  final controller = Get.find<LearningController>();

  LauncherTab({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      if (controller.isLoading.value) {
        return Center(child: CircularProgressIndicator());
      }
      if (controller.launchers.isEmpty) {
        return Center(child: Text("No launchers found"));
      }
      return ListView.builder(
        itemCount: controller.launchers.length,
        itemBuilder: (context, index) {
          final item = controller.launchers[index];
          return ListTile(
            leading: Icon(Icons.rocket),
            title: Text(item.id),
            //subtitle: Text("ID: ${item.id}"),
          );
        },
      );
    });
  }
}

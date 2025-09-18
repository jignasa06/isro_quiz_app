import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:isro_quiz_app/module/learning/controller/learning_controller.dart';

class SpacecraftTab extends StatelessWidget {
  final controller = Get.find<LearningController>();

  SpacecraftTab({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      if (controller.isLoading.value) {
        return Center(child: CircularProgressIndicator());
      }
      if (controller.spacecrafts.isEmpty) {
        return Center(child: Text("No spacecrafts found"));
      }
      return ListView.builder(
        itemCount: controller.spacecrafts.length,
        itemBuilder: (context, index) {
          final item = controller.spacecrafts[index];
          return ListTile(
            leading: Icon(Icons.rocket_launch),
            title: Text(item.name),
            // subtitle: Text("ID: ${item.id}"),
          );
        },
      );
    });
  }
}

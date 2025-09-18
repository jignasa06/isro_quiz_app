import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:isro_quiz_app/module/learning/controller/learning_controller.dart';

class CentreTab extends StatelessWidget {
  final controller = Get.find<LearningController>();

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      if (controller.isLoading.value) {
        return Center(child: CircularProgressIndicator());
      }
      if (controller.centres.isEmpty) {
        return Center(child: Text("No centres found"));
      }
      return ListView.builder(
        itemCount: controller.centres.length,
        itemBuilder: (context, index) {
          final item = controller.centres[index];
          return ListTile(
            leading: Icon(Icons.location_city),
            title: Text(item.name),
            subtitle: Text(item.place),
          );
        },
      );
    });
  }
}

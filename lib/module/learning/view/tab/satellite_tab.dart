import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:isro_quiz_app/module/learning/controller/learning_controller.dart';

class SatelliteTab extends StatelessWidget {
  final controller = Get.find<LearningController>();

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      if (controller.isLoading.value) {
        return Center(child: CircularProgressIndicator());
      }
      if (controller.satellites.isEmpty) {
        return Center(child: Text("No satellites found"));
      }
      return ListView.builder(
        itemCount: controller.satellites.length,
        itemBuilder: (context, index) {
          final item = controller.satellites[index];
          return ListTile(
            leading: Icon(Icons.satellite),
            title: Text("Country: ${item.country}"),
            subtitle: Text("Launch Date: ${item.launchDate}"),
          );
        },
      );
    });
  }
}

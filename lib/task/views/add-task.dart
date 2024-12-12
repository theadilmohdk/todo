// ignore: file_names
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:todo_list/task/controller/addtask-controller.dart';

class AddTaskBottomSheet extends StatelessWidget {
  final AddTaskController controller = Get.put(AddTaskController());

 AddTaskBottomSheet({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.8, // Set the height to 80% of the screen
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: controller.titleController,
              decoration: const InputDecoration(labelText: 'Title'),
            ),
            TextField(
              controller: controller.descriptionController,
              decoration: const InputDecoration(labelText: 'Description'),
            ),
            TextField(
              controller: controller.deadlineController,
              decoration: const InputDecoration(labelText: 'Deadline'),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: controller.createTask,
              child: const Text('Create Task'),
            ),
            Obx(() => Text(controller.errorMessage.value, style: const TextStyle(color: Colors.red))),
          ],
        ),
      ),
    );
  }
}
void showAddTaskBottomSheet(BuildContext context) {
  showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    backgroundColor: Colors.transparent,
    builder: (context) {
      return AddTaskBottomSheet();
    },
  );
}
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:todo_list/home-page.dart';
import 'package:todo_list/model/task.dart';
import 'package:get/get.dart';
import 'package:todo_list/task/views/task_list.dart';

class AddTaskController extends GetxController {
  final titleController = TextEditingController();
  final descriptionController = TextEditingController();
  final deadlineController = TextEditingController();
  RxString errorMessage = ''.obs;

  void createTask() async {
    errorMessage.value = '';
    update();

    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('auth_token') ?? '';

    try {
      final response = await http.post(
        Uri.parse('https://erpbeta.cloudocz.com/api/app/tasks/store'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
        body: jsonEncode({
          'name': titleController.text,
          'description': descriptionController.text,
          'deadline': deadlineController.text,
        }),
      );

      if (response.statusCode == 200) {
            titleController.clear();
      descriptionController.clear();
      deadlineController.clear();

      // Navigate to the Task List page (index 1)
      Get.offAll(HomePage(), arguments: 1);
        // );
      } else {
        print('Error: ${response.body}');
        errorMessage.value =
            'Failed to create task. Status Code: ${response.statusCode}';
        update();
      }
    } catch (e) {
      errorMessage.value = 'An error occurred: $e';
      update();
    }
  }
}

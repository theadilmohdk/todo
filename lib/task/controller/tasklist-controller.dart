import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:todo_list/model/task.dart';

class TaskListController extends GetxController {
  var tasks = <Task>[].obs; // Observable list of tasks
  var filteredTasks = <Task>[].obs; // Observable list for filtered tasks
  var isLoading = false.obs; // Observable loading state
  var errorMessage = ''.obs; // Observable error message
  final searchController = TextEditingController();
  var profilePicture = ''.obs;

  @override
  void onInit() {
    super.onInit();
    fetchTasks();
    searchController.addListener(_filterTasks);
  }

  Future<void> fetchTasks() async {
    isLoading.value = true;
    errorMessage.value = '';

    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('auth_token') ?? '';

    try {
      final response = await http.get(
        Uri.parse('https://erpbeta.cloudocz.com/api/app/tasks'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        final List tasksJson = data['data'];

        tasks.value = tasksJson.map((json) => Task.fromJson(json)).toList();
        filteredTasks.value = tasks; // Initialize filteredTasks with all tasks
      } else {
        errorMessage.value = 'Failed to fetch tasks. Status Code: ${response.statusCode}';
      }
    } catch (e) {
      errorMessage.value = 'An error occurred: $e';
    } finally {
      isLoading.value = false;
    }
  }

  void _filterTasks() {
    String query = searchController.text.toLowerCase();
    filteredTasks.value = tasks.where((task) {
      return task.name.toLowerCase().contains(query);
    }).toList();
  }

  Future<void> deleteTask(String taskId) async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('auth_token') ?? '';

    try {
      final response = await http.post(
        Uri.parse('https://erpbeta.cloudocz.com/api/app/tasks/destroy/$taskId'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
      );

      if (response.statusCode == 200) {
        tasks.removeWhere((task) => task.id.toString() == taskId);
        filteredTasks.value = tasks;
      } else {
        errorMessage.value = 'Failed to delete task. Status Code: ${response.statusCode}';
      }
    } catch (e) {
      errorMessage.value = 'Error occurred while deleting task: $e';
    }
  }

  Future<void> updateTask(String taskId, String name, String description, String deadline) async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('auth_token') ?? '';

    final Map<String, dynamic> updatedTaskData = {
      'name': name,
      'description': description,
      'deadline': deadline,
    };

    try {
      final response = await http.post(
        Uri.parse('https://erpbeta.cloudocz.com/api/app/tasks/update/$taskId'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
        body: jsonEncode(updatedTaskData),
      );

      if (response.statusCode == 200) {
        await fetchTasks(); // Refresh the task list
      } else {
        errorMessage.value = 'Failed to update task. Status Code: ${response.statusCode}';
      }
    } catch (e) {
      errorMessage.value = 'Error occurred while updating task: $e';
    }
  }

  Future<void> fetchUserProfile() async {
    final prefs = await SharedPreferences.getInstance();
    profilePicture.value = prefs.getString('profile_picture') ?? 'no image';
  }

  @override
  void onClose() {
    searchController.dispose(); // Dispose the controller
    super.onClose();
  }
}
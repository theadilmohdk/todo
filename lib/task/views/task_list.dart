import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:todo_list/login/widgets/login-textfield.dart';
import 'package:todo_list/task/controller/tasklist-controller.dart';
import 'package:todo_list/task/widgets/popup-menu.dart';

class TaskListScreen extends StatelessWidget {
  final TaskListController controller = Get.put(TaskListController());

  TaskListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: const Center(child: Text('Task List')),
        leading: const Icon(Icons.filter_alt_outlined),
        actions: [
          CircleAvatar(
            radius: 30,
            backgroundImage: AssetImage('assets/profile (1).png'),
          ),
        ],
        backgroundColor: Colors.black,
      ),
      body: Column(
        children: [
          const SizedBox(height: 50),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              LoginTextField(
                controller: controller.searchController,
                hintText: '   Search your tasks......',
                obsecuretext: false,
              ),
            ],
          ),
          const SizedBox(height: 30),
          Obx(() {
            if (controller.isLoading.value) {
              return const Center(child: CircularProgressIndicator());
            } else if (controller.errorMessage.isNotEmpty) {
              return Center(child: Text(controller.errorMessage.value));
            } else if (controller.filteredTasks.isEmpty) {
              return const Center(child: Text('No tasks available.'));
            } else {
              return Expanded(
                child: ListView.builder(
                  shrinkWrap: true,
                  itemCount: controller.filteredTasks.length,
                  itemBuilder: (context, index) {
                    final task = controller.filteredTasks[index];
                    return Card(
                      color: Colors.grey[800],
                      child: ListTile(
                        title: Text(task.name,
                            style: const TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 21)),
                        subtitle: Text(
                          ' ${task.status}',
                          style: const TextStyle(color: Colors.red),
                        ),
                        trailing: TaskPopupMenu(
                          task: task,
                          onUpdate: (id, name, description, deadline) {
                            controller.updateTask(
                                id, name, description, deadline);
                          },
                          onDelete: (taskId) {
                            controller.deleteTask(taskId);
                          },
                        ),
                      ),
                    );
                  },
                ),
              );
            }
          }),
        ],
      ),
    );
  }
}

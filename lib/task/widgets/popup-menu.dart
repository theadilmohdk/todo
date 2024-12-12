import 'package:flutter/material.dart';
import 'package:todo_list/model/task.dart';

class TaskPopupMenu extends StatelessWidget {
  final Task task;
  final Function(String, String, String, String) onUpdate;
  final Function(String) onDelete;

  TaskPopupMenu({required this.task, required this.onUpdate, required this.onDelete});

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton<String>(
      onSelected: (value) {
        if (value == 'update') {
          _showUpdateDialog(context);
        } else if (value == 'delete') {
          onDelete(task.id.toString());
        }
      },
      itemBuilder: (BuildContext context) {
        return [
          PopupMenuItem<String>(
            value: 'update',
            child: Text('Update Task'),
          ),
          PopupMenuItem<String>(
            value: 'delete',
            child: Text('Delete Task'),
          ),
        ];
      },
    );
  }

  void _showUpdateDialog(BuildContext context) {
    final TextEditingController nameController = TextEditingController(text: task.name);
    final TextEditingController descriptionController = TextEditingController(text: task.description);
    final TextEditingController deadlineController = TextEditingController(text: task.status);

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Update Task'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: nameController,
                decoration: InputDecoration(labelText: 'Task Name'),
              ),
              TextField(
                controller: descriptionController,
                decoration: InputDecoration(labelText: 'Description'),
              ),
              TextField(
                controller: deadlineController,
                decoration: InputDecoration(labelText: 'Deadline (YYYY-MM-DD)'),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                // Call the onUpdate function with the new values
                onUpdate(task.id.toString(), nameController.text, descriptionController.text, deadlineController.text);
                Navigator.of(context).pop(); // Close the dialog
              },
              child: Text('Update'),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
              },
              child: Text('Cancel'),
            ),
          ],
        );
      },
    );
  }
}
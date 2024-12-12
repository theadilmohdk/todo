import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:todo_list/home-page.dart';
import 'package:todo_list/login/views/login_page.dart';
import 'package:todo_list/task/views/add-task.dart';
import 'package:todo_list/task/views/task_list.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Task Manager',
      theme: ThemeData(primarySwatch: Colors.blue),
      initialRoute: '/login',
        debugShowCheckedModeBanner: false, 
      getPages: [
        GetPage(name: '/login', page: () => LoginPage()),
        GetPage(name: '/taskList', page: () => TaskListScreen()),
        GetPage(name: '/home', page: () => HomePage()),
      ],
    );
  }
}


// import 'package:flutter/material.dart';
// import 'package:todo_list/home-page.dart';
// import 'package:todo_list/login/views/login_page.dart';
// import 'package:todo_list/task/add-task.dart';

// void main() {
//   runApp(MyApp());
// }

// class MyApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'Task Manager',
//       theme: ThemeData(primarySwatch: Colors.blue),
//       home: LoginPage(),
//       routes: {
//         '/taskList': (context) => TaskListScreen(),
//         '/login': (context) => LoginPage(),
//       },
//     );
//   }
// }

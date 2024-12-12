import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:todo_list/api/api-serviece.dart';

class LoginController extends GetxController {
  final ApiService _apiService = ApiService();
  final _token = ''.obs;
  final _errorMessage = ''.obs;
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  String get email => emailController.text;
  String get password => passwordController.text;

  Future<void> authenticateUser() async {
    if (email.isEmpty || password.isEmpty) {
      _showAlertDialog(Get.context!, 'Invalid Credentials',
          'Please enter both email and password.');
    } else if (password.length < 6) {
      _showAlertDialog(Get.context!, 'Invalid Password',
          'Password must be at least 6 characters long.');
    } else {
      print('Authenticate user function called');
      try {
        print('Making API request...');
        final response = await _apiService.authenticateUser(email, password);
        print('API request completed');
        final data = json.decode(response);
        _token.value = data['token'];
        final prefs = await SharedPreferences.getInstance();
        await prefs.setString('auth_token', data['token']);
        await prefs.setString('username', data['name']);
        await prefs.setString('position', data['position']);
        await prefs.setString('profile_picture', data['image']);
        print('Navigating to task list...');
        print(prefs.getString('username'));
        print('ssssssssssssssssssssssssssssssss');
        Get.toNamed('/home');
      } catch (error) {
        if (error.toString().contains('401')) {
          _showAlertDialog(Get.context!, 'Invalid Credentials',
              'Invalid email or password.');
        } else {
          _showAlertDialog(Get.context!, 'Invalid Credentials',
              'Invalid email or password.');
        }
      }
    }
  }

// Future<void> authenticateUser    () async {
//   if (email.isEmpty || password.isEmpty) {
//     _showAlertDialog(Get.context!,
//     'Invalid Credentials',
//     'Please enter both email and password.');
//   } else if (password.length < 6) {
//     _showAlertDialog(Get.context!,'Invalid Password','Password must be at least 6 characters long.');
//   } else {
//     print('Authenticate user function called');
//     try {
//       print('Making API request...');
//       final token = await _apiService.authenticateUser    (email, password);
//       print('API request completed');
//       _token.value = token;
//       print('Navigating to task list...');
//       Get.toNamed('/home');
//     } catch (error) {
//       if (error.toString().contains('401')) {
//         _showAlertDialog(Get.context!,'Invalid Credentials','Invalid email or password.');
//       } else {
//         _showAlertDialog(Get.context!,'Invalid Credentials','Invalid email or password.');
//       }
//     }
//   }
// }

  void _showAlertDialog(BuildContext context, String title, String content) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(title),
          content: Text(content),
          actions: <Widget>[
            // TextButton(
            //   child: const Text('Cancel'),
            //   onPressed: () {
            //     Navigator.of(context).pop();
            //   },
            // ),
            TextButton(
              child: const Text('Ok'),
              onPressed: () {
                Navigator.of(context).pop();
                // Handle the confirm action
              },
            ),
          ],
        );
      },
    );
  }
}

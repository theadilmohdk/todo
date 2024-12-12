import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:todo_list/login/controller/login-controller.dart';
import 'package:todo_list/login/widgets/login-button.dart';
import 'package:todo_list/login/widgets/login-textfield.dart';

class LoginPage extends StatelessWidget {
  LoginPage({super.key});
  final LoginController _loginController = Get.put(LoginController());

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: Colors.black,
      resizeToAvoidBottomInset: true,
      body: SingleChildScrollView(
        child: Column(
          children: [
            Row(
              children: [
                Container(
                  width: width,
                  height: height / 2,
                  //  decoration: const BoxDecoration(
                  //       color: Colors.white,
                  //       image: DecorationImage(
                  //         image: AssetImage('assets/task.png'),
                  //         fit: BoxFit.contain,
                  //       )),
                  child: Padding(
                    padding: const EdgeInsets.all(10),
                    child: Column(
                      children: [
                        SizedBox(
                          height: 40,
                        ),
                        SizedBox(
                          height: height / 4,
                          width: width / 2,
                          child: Image(
                              image: const AssetImage(
                            'assets/task.png',
                          )),
                        ),
                        SizedBox(
                          height: 30,
                        ),
                        Text(
                          'Manage your tasks',
                          style: TextStyle(
                              fontSize: 32,
                              fontWeight: FontWeight.bold,
                              color: Colors.white),
                        ),
                        SizedBox(
                            width: width / 1.5,
                            child: Text(
                                'You can easily manage all of your daily tasks in DoMe for free',
                                style: TextStyle(
                                    fontSize: 18, color: Colors.white)))
                      ],
                    ),
                  ),
                )
              ],
            ),
            Row(
              children: [
                Container(
                  width: width,
                  height: height / 2,
                  decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(20),
                        topRight: Radius.circular(20),
                      )),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(
                        height: 60,
                        width: width / 1.5,
                        child: const Text(
                          'Welcome Back, Youhave been missed!',
                          style: TextStyle(
                              fontSize: 21, fontWeight: FontWeight.bold),
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      LoginTextField(
                          controller: _loginController.emailController,
                          hintText: '  Email',
                          obsecuretext: false),
                      LoginTextField(
                          controller: _loginController.passwordController,
                          hintText: '  Password',
                          obsecuretext: false),
                      const SizedBox(
                        height: 15,
                      ),
                      LoginButton(
                          ontap: () {
                            print('tapped');
                            print(_loginController.email);
                            print(_loginController.password);
                            _loginController.authenticateUser(
                              // _loginController.email,
                              // _loginController.password,
                            );
                            // Navigator.push(
                            //     context,
                            //     MaterialPageRoute(
                            //       builder: (context) => const HomePage(),
                            //     ));
                          },
                          title: 'Login'),
                      const SizedBox(
                        height: 15,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text(
                            'Dont have an account?  ',
                            style: TextStyle(color: Colors.black),
                          ),
                          GestureDetector(
                            onTap: () {
                              // Navigator.push(
                              //     context,
                              //     MaterialPageRoute(
                              //       builder: (context) => CreateAccount(),
                              //     ));
                            },
                            child: const Text(
                              'Register Now',
                              style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold),
                            ),
                          )
                        ],
                      )
                    ],
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}


// import 'dart:convert';
// import 'package:flutter/material.dart';
// import 'package:http/http.dart' as http;
// import 'package:shared_preferences/shared_preferences.dart';

// class LoginScreen extends StatefulWidget {
//   const LoginScreen({super.key});

//   @override
//   _LoginScreenState createState() => _LoginScreenState();
// }

// class _LoginScreenState extends State<LoginScreen> {
//   final _usernameController = TextEditingController();
//   final _passwordController = TextEditingController();
//   String _errorMessage = '';

// Future<void> _authenticateUser  () async {
//   try {
//     final url = Uri.parse("https://erpbeta.cloudocz.com/api/auth/login");
//     final headers = {
//       "Content-Type": "application/json",
//     "Accept": "*/*",
//       "Accept-Encoding": "gzip, deflate, br",
//       "Connection": "keep-alive",


//     };
//     final body = json.encode({
//       "email": _usernameController.text.trim(),
//       "password": _passwordController.text.trim(),
//     });

//     print('Request URL: $url');
//     print('Request Headers: $headers');
//     print('Request Body: $body');

//     final response = await http.post(
//       url,
//       headers: headers,
//       body: body,
//     );

//     print('Response Status Code: ${response.statusCode}');
//     print('Response Body: ${response.body}');

//     if (response.statusCode == 200) {
//       final data = json.decode(response.body);
//       final token = data['token'];

//       final prefs = await SharedPreferences.getInstance();
//       await prefs.setString('auth_token', token);

//       Navigator.pushReplacementNamed(context, '/taskList');
//     } else if (response.statusCode == 401) {
//       setState(() {
//         _errorMessage = "Invalid email or password";
//       });
//     } else {
//       setState(() {
//         _errorMessage = "An error occurred. Please try again.";
//       });
//     }
//   } catch (error) {
//     print('Error: $error');
//     setState(() {
//       _errorMessage = "An error occurred. Please try again.";
//     });
//   }
// }


//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: const Text("Login")),
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             TextField(
//               controller: _usernameController,
//               decoration: const InputDecoration(labelText: 'Username'),
//             ),
//             TextField(
//               controller: _passwordController,
//               obscureText: true,
//               decoration: const InputDecoration(labelText: 'Password'),
//             ),
//             const SizedBox(height: 20),
//             ElevatedButton(
//               onPressed: () {
//                 _authenticateUser(
//                   // _usernameController,
//                   // _passwordController.text,
//                 );
//               },
//               child: const Text('Login'),
//             ),
//             if (_errorMessage.isNotEmpty) ...[
//               const SizedBox(height: 10),
//               Text(_errorMessage, style: const TextStyle(color: Colors.red)),
//             ]
//           ],
//         ),
//       ),
//     );
//   }
// }

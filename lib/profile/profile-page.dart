// import 'dart:js';

// ignore_for_file: use_super_parameters, unused_element, prefer_const_constructors, avoid_print

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
// import 'package:my_quizapp/profile/profile.dart';
import 'package:todo_list/profile/widgets/settings.dart';

class MyProfilePage extends StatefulWidget {
  const MyProfilePage({Key? key}) : super(key: key);

  @override
  State<MyProfilePage> createState() => _MyProfilePageState();
}

class _MyProfilePageState extends State<MyProfilePage> {

    String _username = '';
  String _position = '';
  String _profilePicture = '';

  @override
  void initState() {
    super.initState();
    _fetchUserProfile();
  }

  Future<void> _fetchUserProfile() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      _username = prefs.getString('username') ?? 'no name';
      _position = prefs.getString('position') ?? 'no postion';
      _profilePicture = prefs.getString('profile_picture') ?? 'no image';
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      resizeToAvoidBottomInset: false,
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              SizedBox(height: 60,),
              Row(
                children: [
                  CircleAvatar(
                    radius: 35,
                    // Display profile photo
                     backgroundImage:NetworkImage(_profilePicture)
                    //     NetworkImage(),
                  ),
                 const SizedBox(width: 10),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                       _username,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.white
                        ),
                      ),
                      SizedBox(height: 5),
                      Text(_position,style: TextStyle(
                        color: Colors.white
                      ),),
                    ],
                  ),
                 const Spacer(),
                  ElevatedButton(
                    onPressed: editAction,
                    child: Text('Edit'),
                  ),
                ],
              ),
             const SizedBox(height: 35),
               const SizedBox(height: 20,),
              SettingsContainer()
            ],
          ),
        ),
      ),
    );
  }

  void editAction() {
    // Add your edit action logic here
    print('Edit button pressed');
  }
}

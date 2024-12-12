import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:todo_list/profile/profile-page.dart';
import 'package:todo_list/task/views/add-task.dart';
import 'package:todo_list/task/views/task_list.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 1; 
  final PageController _pageController = PageController(initialPage: 1); 
  String _profilePicture = '';

   Future<void> _fetchUserProfile() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      _profilePicture = prefs.getString('profile_picture') ?? 'no image';
    });
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

 void _onItemTapped(int index) {
  if (index == 0) {
    showAddTaskBottomSheet(Get.context!);
  } else {
    setState(() {
      _selectedIndex = index;
      _pageController.animateToPage(index, 
          duration: const Duration(milliseconds: 300), curve: Curves.easeInOut);
    });
  }
}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: CurvedNavigationBar(
        backgroundColor: Colors.black,
        color: Colors.white,
        items: const [
          Icon(Icons.add),
          Icon(Icons.home), // Center item
          Icon(Icons.person),
        ],
        index: _selectedIndex, // Ensure the selected index matches the home page
        onTap: _onItemTapped,
      ),
      body: PageView(
        controller: _pageController,
        onPageChanged: (index) {
          setState(() {
            _selectedIndex = index;
          });
        },
        children: [
          AddTaskBottomSheet(), 
          // Home Page  
          //hhhh
          TaskListScreen(),
          // profile
     MyProfilePage()
        ],
      ),
    );
  }
}


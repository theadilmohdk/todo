// ignore_for_file: use_key_in_widget_constructors

import 'package:flutter/material.dart';// Import the About Us page

class SettingsContainer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;

    final containerHeight = screenHeight; // Adjust height percentage as needed
    final containerWidth =
        screenWidth * 0.5; // Adjust width percentage as needed

    return Container(
      height: 500,
      padding: const EdgeInsets.all(10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text('Settings',
         style: TextStyle(
          color:  Colors.white, fontSize: 20
         ),
                      ),
            ],
          ),
          const SizedBox(height: 20),
          buildOptionRow(context, 'Premium', Icons.star, 30,
              screenWidth), // Navigate to Subscription Plans
          const SizedBox(height: 30),
          buildOptionRow(context, 'Customer Service', Icons.headset_mic, 30,
              screenWidth), // Increased icon size
          const SizedBox(height: 30),
          buildOptionRow(context, 'Invite Others', Icons.person_add, 30,
              screenWidth), // Increased icon size
          const SizedBox(height: 30),
          buildOptionRow(context, 'About Us', Icons.info, 30,
              screenWidth), // Increased icon size
          const SizedBox(height: 30),
          buildOptionRow(context, 'Logout', Icons.logout, 30, screenWidth),
        ],
      ),
    );
  }

  Widget buildOptionRow(BuildContext context, String title, IconData icon,
      double iconSize, double screenWidth) {
    return GestureDetector(
      onTap: () {
        if (title == 'About Us') {
          // Navigator.push(
          //   context,
          //   MaterialPageRoute(
          //       builder: (context) =>
          //           AboutUsPage()), // Navigate to the About Us page
          // );
        } else if (title == 'Premium') {
          // Navigator.push(
          //   context,
          //   MaterialPageRoute(
          //       builder: (context) =>
          //           SubscriptionScreen()), // Navigate to the Subscription Plans page
          // );
        } else if (title == 'Logout') {
          _showDeleteDialog(context, 'Delete Match',
              'Are you sure you want to delete this match?');
        }
        // Add navigation for other options as needed
      },
      child: Container(
        height: 40,
        width: screenWidth * 0.7,
        
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Icon(icon,
                    color: title == 'Logout'
                        ? Color.fromARGB(255, 230, 101, 101)
                        : const Color.fromARGB(255, 148, 164, 243),
                    size: iconSize), // Increased icon size
                const SizedBox(
                    width: 12), // Increased spacing between icon and text
                Text(
                  title,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 20, // Increased font size
                  ),
                ),
              ],
            ),
            // const Icon(Icons.arrow_forward_ios, color: Color.fromARGB(255, 82, 82, 83)),
          ],
        ),
      ),
    );
  }

  void _showDeleteDialog(
      BuildContext context, String heading, String subHeading) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(
            'Logout',
            // style: AppTextStyles.poppinsBold(
            //   color: Color.fromARGB(255, 9, 8, 9),
            //   fontSize: 18,
            // ),
          ),
          content: Text(
            'Are you sure you want to logout',
            // style: AppTextStyles.poppinsRegular(
            //   color: Colors.black,
            //   fontSize: 12,
            // ),
          ),
          actions: [
            TextButton(
              child: Text(
                'no',
                // style: AppTextStyles.poppinsBold(
                //   color: Color(0xFFB6ACC5),
                //   fontSize: 12,
                // ),
              ),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: Text(
                'yes',
                // style: AppTextStyles.poppinsBold(
                //   color: const Color.fromARGB(255, 117, 16, 9),
                //   fontSize: 12,
                // ),
              ),
              onPressed: () {
               // logout(context);
                // Provider.of<Matingselectionprovider>(context, listen: false).deleteMatch(delete);
                // Navigator.of(context).pop(); // Close the dialog
              },
            ),
          ],
        );
      },
    );
  }

}

import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              'Your Profile',
              style: Get.textTheme.titleMedium,
            ),
            SizedBox(height: 20),
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: <Widget>[
                    CircleAvatar(
                      radius: 50,
                      backgroundImage: AssetImage('assets/images/profile.jpg'),
                    ),
                    SizedBox(height: 10),
                    Text(
                      'Alex Johnson',
                      style: Get.textTheme.titleMedium,
                    ),
                    Text(
                      '@alexj',
                      style: Get.textTheme.titleMedium,
                    ),
                    SizedBox(height: 20),
                    ListTile(
                      leading: Icon(Icons.email),
                      title: Text('alex@example.com'),
                    ),
                    ListTile(
                      leading: Icon(Icons.bar_chart),
                      title: Text('Level 15'),
                    ),
                    ListTile(
                      leading: Icon(Icons.star),
                      title: Text('7500 XP'),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

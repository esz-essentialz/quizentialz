import 'package:flutter/material.dart';
import 'package:get/get.dart';

class RecommendedPlaylists extends StatelessWidget {
  const RecommendedPlaylists({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              'Recommended Playlists',
              style: Get.textTheme.titleSmall,
            ),
            SizedBox(height: 10),
            ListTile(
              leading: Image.asset('assets/images/javascript.jpg'),
              title: Text('Advanced JavaScript Concepts'),
              subtitle: Text('12 videos • 2.5 hours'),
            ),
            ListTile(
              leading: Image.asset('assets/images/machine_learning.jpg'),
              title: Text('Machine Learning Basics'),
              subtitle: Text('15 videos • 3 hours'),
            ),
          ],
        ),
      ),
    );
  }
}

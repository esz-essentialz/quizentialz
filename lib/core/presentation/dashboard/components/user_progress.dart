import 'package:flutter/material.dart';
import 'package:get/get.dart';

class UserProgress extends StatelessWidget {
  const UserProgress({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              'Your Progress',
              style: Get.textTheme.titleSmall,
            ),
            SizedBox(height: 10),
            LinearProgressIndicator(
              value: 0.75,
              backgroundColor: Colors.grey[300],
              valueColor: AlwaysStoppedAnimation<Color>(Colors.blue),
            ),
            SizedBox(height: 5),
            Text('75% Complete'),
          ],
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AchievementCard extends StatelessWidget {
  final Map<String, dynamic> achievement;

  const AchievementCard({super.key, required this.achievement});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Row(
              children: [
                Text(
                  achievement['icon'],
                  style: TextStyle(fontSize: 24),
                ),
                SizedBox(width: 8),
                Text(
                  achievement['title'],
                  style: Get.textTheme.titleSmall,
                ),
              ],
            ),
            SizedBox(height: 8),
            Text(
              achievement['description'],
              style: Get.textTheme.labelMedium,
            ),
            SizedBox(height: 8),
            LinearProgressIndicator(
              value: achievement['progress'] / 100,
              backgroundColor: Colors.grey[300],
              valueColor: AlwaysStoppedAnimation<Color>(Colors.blue),
            ),
            SizedBox(height: 4),
            Text('${achievement['progress']}% Complete'),
          ],
        ),
      ),
    );
  }
}

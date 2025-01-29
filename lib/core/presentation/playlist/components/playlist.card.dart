import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PlaylistCard extends StatelessWidget {
  final Map<String, dynamic> playlist;

  const PlaylistCard({Key? key, required this.playlist}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Image.asset(
            playlist['thumbnail'],
            height: 120,
            width: double.infinity,
            fit: BoxFit.cover,
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  playlist['title'],
                  style: Get.textTheme.titleSmall,
                ),
                SizedBox(height: 4),
                Text(
                  '${playlist['videos']} videos • ${playlist['duration']}',
                  style: Get.textTheme.labelMedium,
                ),
                SizedBox(height: 8),
                ElevatedButton(
                  onPressed: () {},
                  child: Text('Start Learning'),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

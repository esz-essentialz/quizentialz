import 'dart:convert';

class PlaylistModel {
  String title;
  String id;
  int videosCount;
  double hrs;
  String thumbnail;

  PlaylistModel({
    required this.title,
    required this.id,
    required this.videosCount,
    required this.hrs,
    required this.thumbnail,
  });

  PlaylistModel copyWith({
    String? title,
    String? id,
    int? videosCount,
    double? hrs,
    String? thumbnail,
  }) {
    return PlaylistModel(
      title: title ?? this.title,
      id: id ?? this.id,
      videosCount: videosCount ?? this.videosCount,
      hrs: hrs ?? this.hrs,
      thumbnail: thumbnail ?? this.thumbnail,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'titles': title,
      '\$id': id,
      'videoCount': videosCount,
      'hours': hrs,
      'thumbnail': thumbnail,
    };
  }

  factory PlaylistModel.fromMap(Map<String, dynamic> map) {
    return PlaylistModel(
      title: map['titles'] ?? '',
      id: map['\$id'] ?? '',
      videosCount: map['videoCount']?.toInt() ?? 0,
      hrs: map['hours']?.toInt() ?? 0,
      thumbnail: map['thumbnail'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory PlaylistModel.fromJson(String source) => PlaylistModel.fromMap(json.decode(source));

  @override
  String toString() {
    return 'PlaylistModel(title: $title, id: $id, videosCount: $videosCount, hrs: $hrs, thumbnail: $thumbnail)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is PlaylistModel && other.title == title && other.id == id && other.videosCount == videosCount && other.hrs == hrs && other.thumbnail == thumbnail;
  }

  @override
  int get hashCode {
    return title.hashCode ^ id.hashCode ^ videosCount.hashCode ^ hrs.hashCode ^ thumbnail.hashCode;
  }
}

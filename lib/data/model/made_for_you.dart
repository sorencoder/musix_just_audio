// ignore_for_file: non_constant_identifier_names

import 'package:cloud_firestore/cloud_firestore.dart';

class MadeForYou {
  String id;
  String title;
  String artist;
  String thumbnail_url;
  String song_url;
  String songId;
  MadeForYou(
      {required this.id,
      required this.title,
      required this.artist,
      required this.thumbnail_url,
      required this.song_url,
      required this.songId});

  MadeForYou copyWith(
      {String? id,
      String? title,
      String? artist,
      String? thumbnail_url,
      String? song_url,
      String? songId}) {
    return MadeForYou(
        id: id ?? this.id,
        title: title ?? this.title,
        artist: artist ?? this.artist,
        thumbnail_url: thumbnail_url ?? this.thumbnail_url,
        song_url: song_url ?? this.song_url,
        songId: songId ?? this.songId);
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'title': title,
      'artist': artist,
      'thumnail_url': thumbnail_url,
      'song_url': song_url,
      'songId': songId
    };
  }

  factory MadeForYou.fromDocument(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
    return MadeForYou(
        id: doc.id,
        title: data['title'] ?? '',
        artist: data['artist'] ?? '',
        thumbnail_url: data['thumnail_url'] ?? '',
        song_url: data['url'] ?? '',
        songId: data['songId']);
  }
}

import 'package:cloud_firestore/cloud_firestore.dart';

class PlaylistRepo {
  final firestore = FirebaseFirestore.instance;
  void fetchPlaylist() async {
    try {
      await firestore
          .collection('users')
          .doc()
          .collection('playlist_for_you')
          .where("playCount", isGreaterThan: 5)
          .get();
    } catch (e) {
      rethrow;
    }
  }
}

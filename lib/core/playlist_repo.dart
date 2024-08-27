import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:musix/data/model/songs_model.dart';
import 'package:musix/services/firebase_service.dart';

class PlaylistRepo {
//instance of firestore
  final firestore = FirebaseService.firestore;

  /// Fetches a list of playlists for a specific user that have a play count greater than 5.
  ///
  /// Parameters:
  /// - [userId]: The ID of the user whose playlists are to be fetched.
  ///
  /// Returns:
  /// - A [Future] that resolves to a list of [PlaylistModel].
  Future<List<SongModel>> fetchSongs(String userId) async {
    try {
      // Fetch playlists for the specific user with play count greater than 5
      QuerySnapshot snapshot = await firestore
          .collection('users')
          .doc(userId)
          .collection('playlistForYou')
          .orderBy('playCount')
          .limit(10)
          .get();

      // Convert fetched documents to a list of PlaylistModel
      return snapshot.docs.map((doc) => SongModel.fromDocument(doc)).toList();
    } catch (e) {
      // Log the error or handle it as needed
      print('Error fetching playlists: $e');
      rethrow;
    }
  }
}

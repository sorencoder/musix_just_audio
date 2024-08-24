import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:musix/data/model/songs_model.dart';

class SongsRepository {
  final firestore = FirebaseFirestore.instance;
  Future<List<SongModel>> fetchSongs() async {
    try {
      QuerySnapshot snapshot = await firestore.collection('songs').get();
      return snapshot.docs.map((doc) => SongModel.fromDocument(doc)).toList();
    } catch (e) {
      rethrow;
    }
  }

  // Future<void> addSong() async {
  //   Map<String, dynamic> newsong = {
  //     'id': id,
  //   };
  //   try {
  //     await firestore.collection('songs').doc('uuid').set(newsong);
  //   } catch (e) {
  //     rethrow;
  //   }
  // }
}

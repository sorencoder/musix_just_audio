import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:musix/data/model/made_for_you.dart';

class MadeForYouRepo {
  final firestore = FirebaseFirestore.instance;
  Future<List<MadeForYou>> fetchSongs() async {
    try {
      QuerySnapshot snapshot = await firestore
          .collection('users')
          .doc('BQQ4LpCTPDUlayCVhhYc3UTwMkU2')
          .collection('made_for_you')
          .where('playCount', isGreaterThan: 5)
          .get();
      List<MadeForYou> data =
          snapshot.docs.map((doc) => MadeForYou.fromDocument(doc)).toList();
      return data;
    } catch (e) {
      rethrow;
    }
  }
}

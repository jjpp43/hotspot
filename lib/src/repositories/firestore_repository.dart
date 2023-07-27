import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hotspot/src/models/info_model.dart';

class FirestoreRepository {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  //Get info
  // static Future<List<InfoModel>> getInfoLists({int limit = 20}) async {
  //   try {
  //     final data = await FirebaseFirestore.instance
  //         .collection('info')
  //         .limit(limit)
  //         .get();
  //     for (var info in data.docs) {
  //       infoList.add(InfoModel.fromMap(info.data()));
  //     }
  //     return infoList;
  //   } catch (e) {
  //     throw (Exception(e.toString()));
  //   }
  // }
  Future<QuerySnapshot<Map<String, dynamic>>> getInfoLists(
      {int limit = 10}) async {
    try {
      return await _firestore
          .collection('info')
          .limit(limit)
          .orderBy('details')
          .get();
    } catch (e) {
      throw (Exception(e.toString()));
    }
  }

  Future<QuerySnapshot<Map<String, dynamic>>> getMoreInfoLists(
      InfoModel lastInfo,
      {int limit = 10}) async {
    try {
      return await _firestore
          .collection('info')
          .limit(limit)
          .orderBy('details')
          .startAfter([lastInfo.details]).get();
    } catch (e) {
      throw (Exception(e.toString()));
    }
  }

  static Future<void> addToFavorites() async {
    try {} catch (e) {}
  }
}

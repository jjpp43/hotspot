import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hotspot/src/models/info_model.dart';

class FirestoreRepository {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  //Get info
  static List<InfoModel> infoList = [];
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
  static Future<QuerySnapshot<Map<String, dynamic>>> getInfoLists(
      {int limit = 20}) async {
    try {
      return await FirebaseFirestore.instance
          .collection('info')
          .limit(limit)
          .get();
    } catch (e) {
      throw (Exception(e.toString()));
    }
  }

  // static Future<QuerySnapshot<Map<String, dynamic>>> getInfoLists() async {
  //   return FirebaseFirestore.instance
  //       .collection('info')
  //       .limit(10)
  //       .orderBy('timestamp', descending: true)
  //       .get();
  // }

  static Future<QuerySnapshot<Map<String, dynamic>>> getMoreInfoLists(
      {required InfoModel? lastInfo, int limit = 20}) async {
    try {
      return await FirebaseFirestore.instance
          .collection('info')
          .startAfter([lastInfo!.toMap()])
          .limit(limit)
          .get();
    } catch (e) {
      throw (Exception(e.toString()));
    }
  }

  static Future<void> addToFavorites() async {
    try {} catch (e) {}
  }
}

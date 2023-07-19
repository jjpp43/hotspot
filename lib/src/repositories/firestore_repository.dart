import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hotspot/src/models/info_model.dart';

class FirestoreRepository {
  //Get info
  static Future<List<InfoModel>> getInfoLists() async {
    List<InfoModel> infoList = [];

    try {
      final data =
          await FirebaseFirestore.instance.collection('info').limit(16).get();
      for (var info in data.docs) {
        infoList.add(InfoModel.fromMap(info.data()));
      }
      return infoList;
    } catch (e) {
      throw (Exception(e.toString()));
    }
  }

  static Future<void> addToFavorites() async {
    try {} catch (e) {}
  }
}

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:hotspot/src/models/info_model.dart';
import 'package:hotspot/src/repositories/auth_repository.dart';

class FirestoreRepository {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  /// Default initial query
  Future<QuerySnapshot<Map<String, dynamic>>> getInfoLists(
      {int limit = 20}) async {
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

  /// Default fetching more query
  Future<QuerySnapshot<Map<String, dynamic>>> getMoreInfoLists(
      InfoModel lastInfo,
      {int limit = 20}) async {
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

  /// By region query
  Future<QuerySnapshot<Map<String, dynamic>>> getInfoListsByRegionSeoul(
      {int limit = 20}) async {
    try {
      // Adjust the query using where() to filter the documents based on 'address'
      // Get the documents with the first two letters of the address field match the region
      return await _firestore
          .collection('info')
          .where('address', isGreaterThanOrEqualTo: '서울\u0000')
          .where('address', isLessThan: '서울\uFFFF')
          .limit(limit)
          .orderBy('address')
          .get();
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  /// Fetching more region based query
  Future<QuerySnapshot<Map<String, dynamic>>> getMoreInfoListsByRegionSeoul(
      InfoModel lastInfo,
      {int limit = 20}) async {
    try {
      return await _firestore
          .collection('info')
          .where('address', isGreaterThanOrEqualTo: '서울\u0000')
          .where('address', isLessThan: '서울\uFFFF')
          .limit(limit)
          .orderBy('address')
          .startAfter([lastInfo.details]).get();
    } catch (e) {
      throw (Exception(e.toString()));
    }
  }

  Future<void> addToFavorites(BuildContext context, String infoId) async {
    try {
      String? userId = AuthRepository().getUserId();
      if (userId != null) {
        return;
      }
      final favoritesCollection =
          _firestore.collection('users').doc(userId).collection('favorites');
      final favoritesDoc = favoritesCollection.doc(infoId);
      final favoritesSnapshot = await favoritesDoc.get();

      if (!favoritesSnapshot.exists) {
        favoritesDoc.set({
          'userId': userId,
          /**여기에 정보 넣기
        final userCollection = _firestore.collection('users');
      final userDoc = userCollection.doc(user.uid);
      final userSnapshot = await userDoc.get();

      if (!userSnapshot.exists) {
        userDoc.set({
          'createdAt': DateTime.now(),
          'userId': user.uid,
          'username': user.displayName,
          'email': user.email,
          'photoUrl': user.photoURL,
        });
      }
         */
        });
      }
    } catch (e) {}
  }
}

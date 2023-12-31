// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';

class InfoModel extends Equatable {
  final int id;
  final String media_type;
  final String title;
  final String name;
  final String location_type;
  final String details;
  final String workhours;
  final String off;
  final String address;
  final String contact;
  final Timestamp? last_update;
  // final int viewCount;
  // bool? isFavorite;
  const InfoModel({
    required this.id,
    required this.media_type,
    required this.title,
    required this.name,
    required this.location_type,
    required this.details,
    required this.workhours,
    required this.off,
    required this.address,
    required this.contact,
    this.last_update,
    // required this.viewCount,
    // this.isFavorite,
  });
  // {
  //   isFavorite = isFavorite ?? false;
  // }

  InfoModel copyWith({
    int? id,
    String? media_type,
    String? title,
    String? name,
    String? location_type,
    String? details,
    String? workhours,
    String? off,
    String? address,
    String? contact,
    Timestamp? last_update,
    // int? viewCount,
    // bool? isFavorite,
  }) {
    return InfoModel(
      id: id ?? this.id,
      media_type: media_type ?? this.media_type,
      title: title ?? this.title,
      name: name ?? this.name,
      location_type: location_type ?? this.location_type,
      details: details ?? this.details,
      workhours: workhours ?? this.workhours,
      off: off ?? this.off,
      address: address ?? this.address,
      contact: contact ?? this.contact,

      last_update: last_update ?? this.last_update,
      // viewCount: viewCount ?? this.viewCount,
      // isFavorite: isFavorite ?? this.isFavorite,
    );
  }

  /*---------------------------------------------
   * Converts the PostModel object to a map, 
   * which can be used to save the PostModel in Firestore.
   */

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'media_type': media_type,
      'title': title,
      'name': name,
      'location_type': location_type,
      'details': details,
      'workhours': workhours,
      'off': off,
      'address': address,
      'contact': contact,
      'last_update': last_update,
      // 'viewCount': viewCount,
      // 'isFavorite': isFavorite,
    };
  }

  /*--------------------------------------------------------------------
   * The fromSnapshot factory constructor is used to create a InfoModel instance
   * from a DocumentSnapshot retrieved from Firestore.
   */

  factory InfoModel.fromSnapshot(Map<String, dynamic> map) {
    return InfoModel(
      id: map['id'],
      media_type: map['media_type'],
      title: map['title'],
      name: map['name'],
      location_type: map['location_type'],
      details: map['details'],
      workhours: map['workhours'],
      off: map['off'],
      address: map['address'],
      contact: map['contact'],
      last_update:
          map['last_update'] != null ? map['last_update'] as Timestamp : null,
      //     viewCount: map['viewCount'] as int,
      // isFavorite: map['isFavorite'] != null ? map['isFavorite'] as bool : null,
    );
  }

  @override
  List<Object?> get props => [
        id,
        media_type,
        title,
        name,
        location_type,
        details,
        workhours,
        off,
        address,
        contact,
        last_update,
        //    viewCount,
        // isFavorite,
      ];
}

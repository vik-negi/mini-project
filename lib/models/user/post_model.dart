// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:geolocator/geolocator.dart';

class PostModel {
  String? creatorUserId;
  PostData? data;
  int? status;
  String? message;
  String? accountType;

  PostModel({
    this.creatorUserId,
    this.data,
    this.status,
    this.message,
    this.accountType,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'creatorUserId': creatorUserId,
      'data': data?.toMap(),
      'status': status,
      'message': message,
      'accountType': accountType,
    };
  }

  factory PostModel.fromMap(Map<String, dynamic> map) {
    return PostModel(
      creatorUserId:
          map['creatorUserId'] != null ? map['creatorUserId'] as String : null,
      data: map['data'] != null
          ? PostData.fromMap(map['data'] as Map<String, dynamic>)
          : null,
      status: map['status'] != null ? map['status'] as int : null,
      message: map['message'] != null ? map['message'] as String : null,
      accountType:
          map['accountType'] != null ? map['accountType'] as String : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory PostModel.fromJson(String source) =>
      PostModel.fromMap(json.decode(source) as Map<String, dynamic>);
}

class PostData {
  final String? createdAt;
  final String? id;

  final String? description;
  final String? eventCategory;
  final String? eventEndAt;

  final String? eventId;
  final EventLocation? eventLocation;
  final String? eventStartAt;
  final List<dynamic>? image;
  final int? likes;
  final int noOfComments;
  final String? organizerType = "Individual";
  final String? postLink;
  final List<dynamic>? tags;
  // final List<dynamic>? likedUsers = [];
  // final List<Comment>? comments;
  final String? title;
  final String? updatedAt;
  final String? username;
  final String? userId;
  final String? name;
  final String? profileImage;
  final List<dynamic>? registration;
  final bool? registrationRequired;

  PostData({
    this.registrationRequired,
    this.registration,
    this.name,
    this.profileImage,
    this.createdAt,
    this.description,
    this.eventCategory,
    this.eventEndAt,
    this.eventId,
    this.eventLocation,
    this.eventStartAt,
    this.image,
    this.likes,
    this.postLink,
    this.tags,
    this.title,
    this.updatedAt,
    this.username,
    this.userId,
    this.noOfComments = 0,
    this.id,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'registrationRequired': registrationRequired,
      'registration': registration,
      'name': name,
      'profileImage': profileImage,
      'createdAt': createdAt,
      'description': description,
      'eventCategory': eventCategory,
      'eventEndAt': eventEndAt,
      'eventId': eventId,
      'eventLocation': eventLocation,
      'eventStartAt': eventStartAt,
      'image': image,
      'likes': likes,
      'postLink': postLink,
      'tags': tags,
      'title': title,
      'updatedAt': updatedAt,
      'username': username,
      'userId': userId,
      'noOfComments': noOfComments,
      '_id': id,
    };
  }

  factory PostData.fromMap(Map<String, dynamic> map) {
    return PostData(
      registrationRequired: map['registrationRequired'] != null
          ? map['registrationRequired'] as bool
          : false,
      registration: map['registration'] != null ? map['registration'] : [],
      createdAt: map['createdAt'] != null ? map['createdAt'] as String : "null",
      description:
          map['description'] != null ? map['description'] as String : "null",
      eventCategory: map['eventCategory'] != null
          ? map['eventCategory'] as String
          : "null",
      eventEndAt:
          map['eventEndAt'] != null ? map['eventEndAt'] as String : "null",
      eventId: map['eventId'] != null ? map['eventId'] as String : "null",
      // eventLocation: map['eventLocation'] != null
      //     ? EventLocation.fromMap(map['eventLocation'] as Map<String, dynamic>)
      //     : null,

      eventStartAt:
          map['eventStartAt'] != null ? map['eventStartAt'] as String : "null",
      image: map['image'] != null
          ? List<dynamic>.from((map['image'] as List<dynamic>))
          : [],
      likes: map['likes'] != null ? map['likes'] as int : null,
      postLink: map['postLink'] != null ? map['postLink'] as String : "null",
      tags: map['tags'] != null
          ? List<dynamic>.from((map['tags'] as List<dynamic>))
          : [],
      title: map['title'] != null ? map['title'] as String : "null",
      updatedAt: map['updatedAt'] != null ? map['updatedAt'] as String : "null",
      username: map['username'] != null ? map['username'] as String : "null",
      profileImage: map['profileImage'] != null
          ? map['profileImage']['url'] as String
          : "null",
      name: map['name'] != null ? map['name'] as String : "null",
      userId: map['userId'] != null ? map['userId'] as String : "null",
      noOfComments:
          map['noOfComments'] != null ? map['noOfComments'] as int : 0,
      id: map['_id'] != null ? map['_id'] as String : "null",
    );
  }

  String toJson() => json.encode(toMap());

  factory PostData.fromJson(String source) =>
      PostData.fromMap(json.decode(source) as Map<String, dynamic>);
}

List<PostData> parsePhotos(String responseBody) {
  final parsed = jsonDecode(responseBody).cast<Map<String, dynamic>>();
  return parsed.map<PostData>((json) => PostData.fromJson(json)).toList();
}

class Comment {
  final String username; //
  final String userImage;
  final String name; //
  final String userId; //
  final String id; //
  final List? replies; //
  bool isEdited; //
  final String text; //
  final List? images; //
  final DateTime createdAt; //
  final DateTime? updatedAt;
  final List? likes; //

  Comment({
    required this.userId,
    this.replies,
    this.likes,
    required this.username, //
    required this.id,
    required this.userImage, //
    required this.name, //
    required this.isEdited,
    required this.text,
    this.images,
    required this.createdAt,
    this.updatedAt,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'username': username,
      'isEdited': isEdited,
      'text': text,
      'images': images,
      'createdAt': createdAt.millisecondsSinceEpoch,
      'updatedAt': updatedAt!.millisecondsSinceEpoch,
      '_id': id,
      'userId': userId,
      'name': name,
      'userImage': userImage,
    };
  }

  factory Comment.fromMap(Map<String, dynamic> map) {
    return Comment(
      username: map['username'] as String,
      isEdited: map['isEdited'] as bool,
      text: map['text'] as String,
      images: map['image'] != null && map['image'] != []
          ? List<dynamic>.from((map['image'] as List<dynamic>))
          : [],
      createdAt: DateTime.parse(map['createdAt']),
      updatedAt:
          map['updatedAt'] != null ? DateTime.parse(map['updatedAt']) : null,
      id: map['_id'] as String,
      name: map['name'] as String,
      userImage: map['userImage']["url"] as String,
      replies: map['image'] != null && map['replies'] != []
          ? List<String>.from((map['replies'] as List))
          : [],
      likes: map['image'] != null && map['likes'] != []
          ? List<String>.from((map['likes'] as List))
          : [],
      userId: map['userId'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory Comment.fromJson(String source) =>
      Comment.fromMap(json.decode(source) as Map<String, dynamic>);
}

class Reply {
  final String user;
  bool isEdited;
  final String text;
  final DateTime createdAt;
  final DateTime updatedAt;
  Reply({
    required this.user,
    required this.isEdited,
    required this.text,
    required this.createdAt,
    required this.updatedAt,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'user': user,
      'isEdited': isEdited,
      'text': text,
      'createdAt': createdAt.millisecondsSinceEpoch,
      'updatedAt': updatedAt.millisecondsSinceEpoch,
    };
  }

  factory Reply.fromMap(Map<String, dynamic> map) {
    return Reply(
      user: map['user'] as String,
      isEdited: map['isEdited'] as bool,
      text: map['text'] as String,
      createdAt: DateTime.fromMillisecondsSinceEpoch(map['createdAt'] as int),
      updatedAt: DateTime.fromMillisecondsSinceEpoch(map['updatedAt'] as int),
    );
  }

  String toJson() => json.encode(toMap());

  factory Reply.fromJson(String source) =>
      Reply.fromMap(json.decode(source) as Map<String, dynamic>);
}

//  eventLocation: {
//     type: {
//       type: String,
//       enum: ["Point"],
//     },
//     coordinates: {
//       type: [Number],
//       // required: true,
//     },
//   }
class EventLocation {
  final String type;
  final List<double> coordinates;

  EventLocation({
    required this.type,
    required this.coordinates,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'type': type,
      'coordinates': coordinates,
    };
  }

  factory EventLocation.fromMap(Map<String, dynamic> map) {
    return EventLocation(
      type: map['type'] as String,
      coordinates: List<double>.from(map['coordinates'] as List),
    );
  }

  String toJson() => json.encode(toMap());

  factory EventLocation.fromJson(String source) =>
      EventLocation.fromMap(json.decode(source) as Map<String, dynamic>);
}

class Address {
  final String? address1;
  final String? city;
  final String state;
  final String country;
  final String zipcode;
  final List<double> coordinates;

  Address({
    this.address1,
    this.city,
    required this.state,
    required this.country,
    required this.zipcode,
    required this.coordinates,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'address1': address1,
      'city': city,
      'state': state,
      'country': country,
      'zipcode': zipcode,
      'coordinates': coordinates,
    };
  }

  factory Address.fromMap(Map<String, dynamic> map) {
    return Address(
      address1: map['address1'] as String,
      city: map['city'] as String,
      state: map['state'] as String,
      country: map['country'] as String,
      zipcode: map['zipcode'] as String,
      coordinates: List<double>.from(map['coordinates'] as List),
    );
  }

  String toJson() => json.encode(toMap());

  factory Address.fromJson(String source) =>
      Address.fromMap(json.decode(source) as Map<String, dynamic>);
}

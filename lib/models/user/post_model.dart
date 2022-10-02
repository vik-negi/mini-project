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

  final String? description;
  final String? eventCategory;
  final String? eventEndAt;
  final String? eventId;
  final String? eventLocation;
  final String? eventStartAt;
  final List<dynamic>? image;
  final int? likes;
  final int noOfComments;
  final String? organizerType = "Individual";
  final String? postLink;
  final List<dynamic>? tags;
  // final List<dynamic>? likedUsers = [];
  // final List<dynamic>? comments = [];
  final String? title;
  final String? updatedAt;
  final String? username;
  final String? userId;
  PostData({
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
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
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
    };
  }

  factory PostData.fromMap(Map<String, dynamic> map) {
    return PostData(
      createdAt: map['createdAt'] != null ? map['createdAt'] as String : "null",
      description:
          map['description'] != null ? map['description'] as String : "null",
      eventCategory: map['eventCategory'] != null
          ? map['eventCategory'] as String
          : "null",
      eventEndAt:
          map['eventEndAt'] != null ? map['eventEndAt'] as String : "null",
      eventId: map['eventId'] != null ? map['eventId'] as String : "null",
      eventLocation: map['eventLocation'] != null
          ? map['eventLocation'] as String
          : "null",
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
      userId: map['userId'] != null ? map['userId'] as String : "null",
      noOfComments:
          map['noOfComments'] != null ? map['noOfComments'] as int : 0,
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

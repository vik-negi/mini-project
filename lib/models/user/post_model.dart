import 'dart:convert';

import 'package:geolocator/geolocator.dart';

class PostModel {
  String? creatorUserId;
  Data? data;
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
}

class Data {
  DateTime? createdAt;
  String? description;
  String? eventCategory;
  DateTime? eventEndAt;
  String? eventId;
  Position? eventLocation;
  DateTime? eventStartAt;
  List<String?>? image;
  int? likes;
  String? organizerType;
  String? postLink;
  List<String?>? tags;
  String? title;
  DateTime? updatedAt;
  String? username;
  String? userId;
  List<String>? likedUsers = [];

  Data({
    this.createdAt,
    this.description,
    this.eventCategory,
    this.eventEndAt,
    this.eventId,
    this.eventLocation,
    this.eventStartAt,
    this.image,
    this.likes,
    this.organizerType,
    this.postLink,
    this.tags,
    this.title,
    this.updatedAt,
    this.username,
    this.userId,
    this.likedUsers,
  });

  Map<String, dynamic> toMap() {
    return {
      'createdAt': createdAt,
      'description': description,
      'eventCategory': eventCategory,
      'eventEndAt': eventEndAt,
      'eventId': eventId,
      'eventLocation': eventLocation,
      'eventStartAt': eventStartAt,
      'image': image,
      'likes': likes,
      'organizerType': organizerType,
      'postLink': postLink,
      'tags': tags,
      'title': title,
      'updatedAt': updatedAt,
      'username': username,
      'userId': userId,
      'likedUsers': likedUsers,
    };
  }

  factory Data.fromMap(Map<String, dynamic> map) {
    return Data(
      createdAt:
          map['createdAt'] != null ? DateTime.parse(map['createdAt']) : null,
      description: map['description'] ? map['description'] : null,
      eventCategory: map['eventCategory'] ? map['eventCategory'] : null,
      eventEndAt: map['eventEndAt'] ? map['eventEndAt'] : null,
      eventId: map['eventId'] ? map['eventId'] : null,
      eventLocation: map['eventLocation'] ? map['eventLocation'] : null,
      eventStartAt: map['eventStartAt'] ? map['eventStartAt'] : null,
      image: map['image'] ? List<String>.from(map['image']) : null,
      likes: map['likes'] ? map['likes'] : 0,
      organizerType: map['organizerType'] ? map['organizerType'] : null,
      postLink: map['postLink'] ? map['postLink'] : null,
      tags: map['tags'] ? List<String>.from(map['tags']) : null,
      title: map['title'] ? map['title'] : null,
      updatedAt: map['updatedAt'] ? map['updatedAt'] : null,
      username: map['username'] ? map['username'] : null,
      userId: map['userId'] ? map['userId'] : null,
      likedUsers: map['likedUsers'] ? map['likedUsers'] : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory Data.fromJson(String source) =>
      Data.fromMap(json.decode(source) as Map<String, dynamic>);
}

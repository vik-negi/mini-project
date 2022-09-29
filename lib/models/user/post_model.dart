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
  List<String?>? imageUrl;
  int? likes;
  String? organizerType;
  String? postLink;
  List<String?>? tags;
  String? title;
  DateTime? updatedAt;
  String? username;

  Data({
    this.createdAt,
    this.description,
    this.eventCategory,
    this.eventEndAt,
    this.eventId,
    this.eventLocation,
    this.eventStartAt,
    this.imageUrl,
    this.likes,
    this.organizerType,
    this.postLink,
    this.tags,
    this.title,
    this.updatedAt,
    this.username,
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
      'imageUrl': imageUrl,
      'likes': likes,
      'organizerType': organizerType,
      'postLink': postLink,
      'tags': tags,
      'title': title,
      'updatedAt': updatedAt,
      'username': username,
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
      imageUrl: map['imageUrl'] ? List<String>.from(map['imageUrl']) : null,
      likes: map['likes'] ? map['likes'] : 0,
      organizerType: map['organizerType'] ? map['organizerType'] : null,
      postLink: map['postLink'] ? map['postLink'] : null,
      tags: map['tags'] ? List<String>.from(map['tags']) : null,
      title: map['title'] ? map['title'] : null,
      updatedAt: map['updatedAt'] ? map['updatedAt'] : null,
      username: map['username'] ? map['username'] : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory Data.fromJson(String source) =>
      Data.fromMap(json.decode(source) as Map<String, dynamic>);
}

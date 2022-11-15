// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class ChatUsers {
  final String receiverId;
  final String username;
  final String name;
  final String profilePic;
  final String lastMessage;
  final String lastMessageTime;
  final String lastMessageBy;
  ChatUsers({
    required this.receiverId,
    required this.username,
    required this.name,
    required this.profilePic,
    required this.lastMessage,
    required this.lastMessageTime,
    required this.lastMessageBy,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'receiverId': receiverId,
      'username': username,
      'name': name,
      'profilePic': profilePic,
      'lastMessage': lastMessage,
      'lastMessageTime': lastMessageTime,
      'lastMessageBy': lastMessageBy,
    };
  }

  factory ChatUsers.fromMap(Map<String, dynamic> map) {
    return ChatUsers(
      receiverId: map['receiverId'] as String,
      username: map['username'] as String,
      name: map['name'] as String,
      profilePic: map['profilePic'] as String,
      lastMessage: map['lastMessage'] as String,
      lastMessageTime: map['lastMessageTime'] as String,
      lastMessageBy: map['lastMessageBy'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory ChatUsers.fromJson(String source) =>
      ChatUsers.fromMap(json.decode(source) as Map<String, dynamic>);
}

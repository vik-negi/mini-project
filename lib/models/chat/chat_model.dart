import 'dart:convert';

// ignore_for_file: public_member_api_docs, sort_constructors_first
class ChatModel {
  final String id;
  final String sendBy;
  final String recieveBy;
  final String message;
  final String createdAt;
  final bool isSent;
  final bool isRead;
  final bool isDeleted;
  final bool isReceived;
  final String messageType;
  final bool isPinned;
  final String receiverUserId;
  final String senderUserId;
  ChatModel({
    required this.id,
    required this.sendBy,
    required this.recieveBy,
    required this.message,
    required this.createdAt,
    required this.isSent,
    required this.isRead,
    required this.isDeleted,
    required this.isReceived,
    required this.messageType,
    required this.isPinned,
    required this.receiverUserId,
    required this.senderUserId,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'sendBy': sendBy,
      'recieveBy': recieveBy,
      'message': message,
      'createdAt': createdAt,
      'isSent': isSent,
      'isRead': isRead,
      'isDeleted': isDeleted,
      'isReceived': isReceived,
      'messageType': messageType,
      'isPinned': isPinned,
      'receiverUserId': receiverUserId,
      'senderUserId': senderUserId,
    };
  }

  factory ChatModel.fromMap(Map<String, dynamic> map) {
    return ChatModel(
      id: map['_id'] as String,
      sendBy: map['sendBy'] as String,
      recieveBy: map['recieveBy'] as String,
      message: map['message'] as String,
      createdAt: map['timestamp'] as String,
      isSent: map['isSent'] as bool,
      isRead: map['isRead'] as bool,
      isDeleted: map['isDeleted'] as bool,
      isReceived: map['isReceived'] as bool,
      messageType: map['messageType'] as String,
      isPinned: map['isPinned'] as bool,
      receiverUserId: map['receiverUserId'] as String,
      senderUserId: map['senderUserId'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory ChatModel.fromJson(String source) =>
      ChatModel.fromMap(json.decode(source) as Map<String, dynamic>);
}

import 'package:cloud_firestore/cloud_firestore.dart';

class MessageModel {
  String? messageId;
  String? sender;
  String? text;
  bool? seen;
  Timestamp? createdOn;

  MessageModel(
      {this.sender, this.text, this.seen, this.createdOn, this.messageId});

  static MessageModel fromMap(Map<String, dynamic> map) {
    return MessageModel(
        messageId: map['messageId'],
        sender: map['sender'],
        text: map['text'],
        seen: map['seen'],
        createdOn: map['createdOn']);
  }

  Map<String, dynamic> toMap() {
    return {
      'messageId': messageId,
      'sender': sender,
      'text': text,
      'seen': seen,
      'createdOn': createdOn
    };
  }
}

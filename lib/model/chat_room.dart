class ChatRoomModel {
  String? chatRoomId;
  Map<String,dynamic>? participants;
  String? lastMessage;

  ChatRoomModel({this.chatRoomId, this.participants, this.lastMessage});

  static ChatRoomModel fromMap(Map<String, dynamic> map) {
   return ChatRoomModel(
      chatRoomId: map['chatRoomId'],
      participants: map['participants'],
      lastMessage: map['lastMessage'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'chatRoomId': chatRoomId,
      'participants': participants,
      'lastMessage': lastMessage,
    };
  }
}

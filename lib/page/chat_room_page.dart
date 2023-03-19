import 'dart:developer';

import 'package:chat/model/chat_room_model.dart';
import 'package:chat/model/message_model.dart';
import 'package:chat/model/user_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../main.dart';

class ChatRoomPage extends StatefulWidget {
  final UserModel targetUser;
  final UserModel currentUser;
  final ChatRoomModel chatRoom;
  final User firebaseUser;

  const ChatRoomPage(
      {super.key,
      required this.targetUser,
      required this.currentUser,
      required this.chatRoom,
      required this.firebaseUser});

  @override
  ChatRoomPageState createState() => ChatRoomPageState();
}

class ChatRoomPageState extends State<ChatRoomPage> {

  final TextEditingController _messageController = TextEditingController();

  sendMessage() async {
    MessageModel newMessage = MessageModel(
        messageId: uuid.v1(),
        sender: widget.currentUser.uid,
        text: _messageController.text,
        seen: false,
        createdOn: Timestamp.now());
    FirebaseFirestore.instance
        .collection('chatrooms')
        .doc(widget.chatRoom.chatRoomId)
        .collection('messages')
        .doc(newMessage.messageId)
        .set(newMessage.toMap());
    ChatRoomModel chatRoomModel = ChatRoomModel(
        chatRoomId: widget.chatRoom.chatRoomId,
        lastMessage: _messageController.text,
        participants: {
          widget.currentUser.uid.toString(): true,
          widget.targetUser.uid.toString(): true,
        });
    FirebaseFirestore.instance
        .collection('chatrooms')
        .doc(widget.chatRoom.chatRoomId)
        .set(chatRoomModel.toMap());
    _messageController.clear();
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            widget.targetUser.profilePic != null
                ? CircleAvatar(
                    backgroundImage:
                        NetworkImage(widget.targetUser.profilePic.toString()),
                  )
                : const Icon(Icons.person),
            SizedBox(
              width: 10,
            ),
            Text(widget.targetUser.name ?? "")
          ],
        ),
      ),
      body: Column(
        children: [
          Expanded(
              child: StreamBuilder(
            stream: FirebaseFirestore.instance
                .collection('chatrooms')
                .doc(widget.chatRoom.chatRoomId)
                .collection("messages")
                .snapshots(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.active) {
                if (snapshot.hasData) {
                  QuerySnapshot? data = snapshot.data;
                  if (data!.docs.isNotEmpty) {
                    return ListView.builder(
                        itemCount: data.docs.length,
                        itemBuilder: (context, int index) {
                          MessageModel message = MessageModel.fromMap(
                              data.docs[index].data() as Map<String, dynamic>);
                          return MessageBubble(
                              message: message.text.toString(),
                              senderId: message.sender.toString(),
                              currentUserId: widget.currentUser.uid!);
                        });
                  } else {
                    return const Center(child: Text('no message'));
                  }
                } else if (snapshot.hasError) {
                  return const Center(child: Text('something went wrong'));
                } else {
                  return const Center(child: Text('no messages'));
                }
              } else {
                return const Center(child: Text("no dat found"));
              }
            },
          )),

          /// search widget
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10.0),
            decoration: const BoxDecoration(
              border: Border(
                top: BorderSide(color: Colors.grey),
              ),
            ),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _messageController,
                    decoration: const InputDecoration(
                      hintText: 'Type your message...',
                    ),
                  ),
                ),
                const SizedBox(width: 10.0),
                ElevatedButton(
                  onPressed: () {
                    if (_messageController.text.isNotEmpty) {
                      sendMessage();
                    }
                  },
                  child: const Text('Send'),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class MessageBubble extends StatelessWidget {
  final String senderId;
  final String message;
  final String currentUserId;

  const MessageBubble(
      {super.key,
      required this.message,
      required this.senderId,
      required this.currentUserId});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5.0, horizontal: 10.0),
      child: Row(
        mainAxisAlignment: currentUserId == senderId
            ? MainAxisAlignment.end
            : MainAxisAlignment.start,
        children: [
          Container(
            padding:
                const EdgeInsets.symmetric(horizontal: 10.0, vertical: 5.0),
            decoration: BoxDecoration(
              color: currentUserId == senderId ? Colors.blue : Colors.grey[300],
              borderRadius: BorderRadius.only(
                topLeft: const Radius.circular(10.0),
                topRight: const Radius.circular(10.0),
                bottomLeft: currentUserId == senderId
                    ? const Radius.circular(10.0)
                    : const Radius.circular(0.0),
                bottomRight: currentUserId == senderId
                    ? const Radius.circular(0.0)
                    : const Radius.circular(10.0),
              ),
            ),
            child: Text(message,
                style: TextStyle(
                    color: currentUserId == senderId
                        ? Colors.white
                        : Colors.green)),
          )
        ],
      ),
    );
  }
}

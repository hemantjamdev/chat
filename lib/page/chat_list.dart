import 'package:chat/constants/firebase_helper.dart';
import 'package:chat/model/chat_room.dart';
import 'package:chat/model/user.dart';
import 'package:chat/page/chat_room.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ChatListPage extends StatelessWidget {
  final UserModel currentUser;
  final User firebaseUser;

  const ChatListPage(
      {super.key, required this.currentUser, required this.firebaseUser});

  @override
  Widget build(BuildContext context) {
    return Material(
        child: StreamBuilder(
      stream: FirebaseFirestore.instance
          .collection('chatrooms')
          .where('participants.${currentUser.uid}', isEqualTo: true)
          .snapshots(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.active) {
          if (snapshot.hasData) {
            QuerySnapshot data = snapshot.data as QuerySnapshot;
            // if(data.data().){}
            return ListView.builder(
                itemCount: data.docs.length,
                itemBuilder: (context, int index) {
                  ChatRoomModel chatRoomModel = ChatRoomModel.fromMap(
                      data.docs[index].data() as Map<String, dynamic>);
                  Map<String, dynamic> participants =
                      chatRoomModel.participants!;
                  List<String> keys = participants.keys.toList();
                  keys.remove(currentUser.uid);
                  return FutureBuilder(
                      future: FirebaseHelper.getUserById(keys.first),
                      builder: (context, futureSnapshot) {
                        if (futureSnapshot.connectionState ==
                            ConnectionState.done) {
                          UserModel? user = futureSnapshot.data;
                          if (user != null) {
                            return ListTile(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => ChatRoomPage(
                                            targetUser: user,
                                            currentUser: currentUser,
                                            chatRoom: chatRoomModel,
                                            firebaseUser: firebaseUser)));
                              },
                              leading: CircleAvatar(
                                backgroundImage:
                                    NetworkImage(user.profilePic.toString()),
                              ),
                              title: Text(user.name.toString()),
                              subtitle: (Text(chatRoomModel.lastMessage
                                      .toString()
                                      .isNotEmpty
                                  ? chatRoomModel.lastMessage.toString()
                                  : "say hi to your friend !")),
                            );
                          } else {
                            return Container();
                          }
                        } else {
                          return Container();
                        }
                      });
                });
          } else if (snapshot.hasError) {
            return const Center(
              child: Text('error ! something went wrong'),
            );
          } else {
            return const Center(
              child: Text('your chats will be display here!'),
            );
          }
        } else {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
      },
    ));
  }
}

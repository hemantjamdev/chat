import 'dart:developer';

import 'package:chat/model/chat_room.dart';
import 'package:chat/model/user.dart';
import 'package:chat/page/chat_room.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../main.dart';

class SearchPage extends StatefulWidget {
  final UserModel currentUser;
  final User firebaseUser;

  const SearchPage(
      {super.key, required this.currentUser, required this.firebaseUser});

  @override
  SearchPageState createState() => SearchPageState();
}

class SearchPageState extends State<SearchPage> {
  final TextEditingController _searchController = TextEditingController();

  Future<ChatRoomModel?> getChatRoom(UserModel targetUser) async {
    ChatRoomModel? existingChatRoom;
    QuerySnapshot snapshot = await FirebaseFirestore.instance
        .collection("chatrooms")
        .where("participants.${widget.currentUser.uid}", isEqualTo: true)
        .where("participants.${targetUser.uid}", isEqualTo: true)
        .get();
    if (snapshot.docs.isNotEmpty) {
      //fetch existing one
      log('chat rooom exist');
      var data = snapshot.docs[0].data();
      existingChatRoom = ChatRoomModel.fromMap(data as Map<String, dynamic>);

      log(data.toString());
    } else {
      //create new
      log("no chatroom found");
      ChatRoomModel newChatRoom =
      ChatRoomModel(chatRoomId: uuid.v1(), lastMessage: "", participants: {
        widget.currentUser.uid.toString(): true,
        targetUser.uid.toString(): true,
      });
      await FirebaseFirestore.instance
          .collection("chatrooms")
          .doc(newChatRoom.chatRoomId)
          .set(newChatRoom.toMap());
      log("new chat room created");
      existingChatRoom = newChatRoom;
    }
    return existingChatRoom;
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Search Bar')),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: _searchController,
              decoration: const InputDecoration(
                hintText: 'Enter User Name',
                border: OutlineInputBorder(),
              ),
            ),
          ),
          ElevatedButton(
              onPressed: () {
                setState(() {});
              },
              child: const Text("Search")),
          Expanded(
            child: StreamBuilder(
                stream: FirebaseFirestore.instance
                    .collection('users')
                    .where('email', isEqualTo: _searchController.text)
                    .where('email', isNotEqualTo: widget.currentUser.email)
                    .snapshots(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.active) {
                    if (snapshot.hasData) {
                      QuerySnapshot doc = snapshot.data as QuerySnapshot;
                      if (doc.docs.isNotEmpty) {
                        return ListView.builder(
                            itemCount: doc.size,
                            itemBuilder: (context, int index) {
                              Map<String, dynamic> userData = doc.docs[index]
                                  .data() as Map<String, dynamic>;

                              UserModel searchedUser =
                              UserModel.fromMap(userData);
                              return ListTile(
                                leading: searchedUser.profilePic.toString() !=
                                    ""
                                    ? CircleAvatar(
                                  backgroundImage: NetworkImage(
                                      searchedUser.profilePic.toString()),
                                )
                                    : const CircleAvatar(
                                    child: Icon(Icons.person)),
                                title: Text(searchedUser.name.toString()),
                                subtitle: Text(searchedUser.email.toString()),
                                trailing:
                                const Icon(Icons.keyboard_arrow_right),
                                onTap: () async {
                                  /* ChatRoomModel chatRoomModel = ChatRoomModel(
                                      chatRoomId: "", participants: {});*/
                                  ChatRoomModel? chatRoom =
                                  await getChatRoom(searchedUser);
                                  if (chatRoom != null) {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (_) => ChatRoomPage(
                                            currentUser: widget.currentUser,
                                            targetUser: searchedUser,
                                            chatRoom: chatRoom,
                                            firebaseUser: widget.firebaseUser),
                                      ),
                                    );
                                  }
                                },
                              );
                            });
                      } else {
                        return const Center(child: Text("no result found"));
                      }
                    } else {
                      return const Center(child: Text("no result found"));
                    }
                  } else {
                    return const Center(child: CircularProgressIndicator());
                  }
                }),
          )
        ],
      ),
    );
  }
}

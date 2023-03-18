import 'package:chat/model/chat_room.dart';
import 'package:chat/model/user.dart';
import 'package:chat/page/profile_page.dart';
import 'package:chat/page/chat_list.dart';
import 'package:chat/page/sign_up.dart';
import 'package:chat/page/search_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ChatHomePage extends StatefulWidget {
  final UserModel currentUser;
  final User firebaseUser;
  final ChatRoomModel? chatRoomModel;

  const ChatHomePage(
      {super.key,
      required this.currentUser,
      required this.firebaseUser,
      this.chatRoomModel});

  @override
  ChatHomePageState createState() => ChatHomePageState();
}

class ChatHomePageState extends State<ChatHomePage>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this, initialIndex: 1);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.pushReplacement(
                context, MaterialPageRoute(builder: (_) => SignUpPage()));
          },
          icon: Icon(Icons.add),
        ),
        title: ListTile(
          title: Text(widget.currentUser.name ?? "not found"),
          subtitle: Text(widget.currentUser.email ?? "not found"),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () {},
          ),
          IconButton(
            icon: const Icon(Icons.more_vert),
            onPressed: () {},
          ),
        ],
        bottom: TabBar(
          controller: _tabController,
          tabs: const [
            Tab(icon: Icon(Icons.person)),
            Tab(text: 'CHATS'),
            Tab(text: 'SEARCH'),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          ProfilePage(
            currentUser: widget.currentUser,
          ),
          ChatListPage(
            currentUser: widget.currentUser,
            firebaseUser: widget.firebaseUser,
          ),
          SearchPage(
              currentUser: widget.currentUser,
              firebaseUser: widget.firebaseUser),
        ],
      ),
      /*floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (_) => SearchPage(
                      currentUser: widget.currentUser,
                      firebaseUser: widget.firebaseUser)));
        },
        child: const Icon(Icons.chat),
      ),*/
    );
  }
}

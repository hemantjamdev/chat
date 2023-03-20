import 'package:chat/model/user_model.dart';
import 'package:chat/page/profile_page.dart';
import 'package:chat/page/chat_list_page.dart';
import 'package:chat/page/search_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ChatHomePage extends StatefulWidget {
  final UserModel currentUser;
  final User firebaseUser;


  const ChatHomePage({
    super.key,
    required this.currentUser,
    required this.firebaseUser,
  });

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

  Future<bool> _onWillPop() async {
    return await showDialog(
          barrierDismissible: false,
          context: context,
          builder: (context) => AlertDialog(
            title: const Text('Are you sure?'),
            content: const Text('Do you want to exit the app'),
            actions: <Widget>[
              ElevatedButton(
                onPressed: () => Navigator.of(context).pop(false),
                child: const Text('No'),
              ),
              ElevatedButton(
                onPressed: () => Navigator.of(context).pop(true),
                child: const Text('Yes'),
              ),
            ],
          ),
        ) ??
        false;
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _onWillPop,
      child: Scaffold(
        appBar: AppBar(
automaticallyImplyLeading: false,
          title: const ListTile(
            title: Text('Chat App')
          ),

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

      ),
    );
  }
}

import 'package:chat/model/user.dart';
import 'package:chat/page/camera_page.dart';
import 'package:chat/page/chat_list.dart';
import 'package:chat/page/status_page.dart';
import 'package:flutter/material.dart';

class ChatHomePage extends StatefulWidget {
  final UserModel userModel;

  const ChatHomePage({super.key, required this.userModel});

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
        title: const Text('WhatsApp'),
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
        children: const [
          CameraPage(),
          ChatListPage(),
          StatusPage(),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},

        child: const Icon(Icons.chat),
      ),
    );
  }
}

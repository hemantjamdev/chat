import 'package:flutter/material.dart';

class ChatListPage extends StatelessWidget {
  const ChatListPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Material(child: StreamBuilder(
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.active) {
          if (snapshot.hasData) {
            return const SingleChildScrollView(
              child: Center(child: Text("you have data....")),
            );
          } else if (snapshot.hasError) {
            return const Center(
              child: Text('something went wrong'),
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

import 'package:chat/model/user.dart';
import 'package:chat/page/chat_home_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  final UserModel currentUser;
  final User firebaseUser;

  const HomePage(
      {Key? key, required this.currentUser, required this.firebaseUser})
      : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return ChatHomePage(
        currentUser: widget.currentUser, firebaseUser: widget.firebaseUser);
  }
}

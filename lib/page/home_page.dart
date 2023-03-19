
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../model/user_model.dart';
import 'chat_home_page.dart';

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

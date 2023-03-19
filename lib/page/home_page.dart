import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../model/user_model.dart';
import 'chat_home_page.dart';

class HomePage extends StatelessWidget {
  final UserModel currentUser;
  final User firebaseUser;

  const HomePage({
    Key? key,
    required this.currentUser,
    required this.firebaseUser,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChatHomePage(
      currentUser: currentUser,
      firebaseUser: firebaseUser,
    );
  }
}

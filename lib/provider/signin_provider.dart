import 'package:chat/model/user.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class SignInProvider extends ChangeNotifier {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final FocusNode emailFocus = FocusNode();
  final FocusNode passFocus = FocusNode();
  bool isLoading = false;

  signIn(
      {
      required BuildContext context}) async {

    if (emailController.text.isNotEmpty &&
        passwordController.text.isNotEmpty) {





   // UserCredential? credential;
    isLoading = true;
    try {
       await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: emailController.text, password: passwordController.text)
          .then((value) {
        if (value.user != null) {
          //UserModel.fromMap(value.user as Map<String, dynamic>);
          Navigator.pushNamed(context, '/chat_list');
          print("${UserModel().uid.toString()}-----------------");
          print("${UserModel().name.toString()}-----------------");
        }
        return null;
      });
    } on FirebaseAuthException catch (e) {
      print("this is pass${passwordController.text}-----------------");
      Fluttertoast.showToast(msg: e.code);
    }
    isLoading = false;
    notifyListeners();
  }}
}

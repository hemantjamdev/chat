import 'package:chat/model/user_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class SignInProvider extends ChangeNotifier {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final FocusNode emailFocus = FocusNode();

  final FocusNode passFocus = FocusNode();
  bool isLoading = false;
  bool obSecure = true;
  UserModel userModel = UserModel();
  UserCredential? credential;

  void changeObSecure() {
    obSecure = !obSecure;
    notifyListeners();
  }

  void loading(bool load) {
    isLoading = load;
    notifyListeners();
  }

  Future<bool?> signIn({required BuildContext context}) async {
    FocusScope.of(context).unfocus();
    loading(true);
    if (emailController.text.isNotEmpty && passwordController.text.isNotEmpty) {
      try {
        credential = await FirebaseAuth.instance.signInWithEmailAndPassword(
            email: emailController.text, password: passwordController.text);
        Fluttertoast.showToast(msg: 'Sign In successful');
        DocumentSnapshot userData = await FirebaseFirestore.instance
            .collection("users")
            .doc(credential!.user!.uid)
            .get();
        DocumentSnapshot snap = userData;
        userModel = UserModel.fromMap(snap.data() as Map<String, dynamic>);
        loading(false);
        return true;
      } on FirebaseAuthException catch (e) {
        Fluttertoast.showToast(msg: e.code);
        loading(false);
        return false;
      }
    }
    loading(false);
    return false;
  }

  @override
  void dispose() {
    emailController.dispose();
    emailFocus.dispose();
    passwordController.dispose();
    passFocus.dispose();
    super.dispose();
  }
}

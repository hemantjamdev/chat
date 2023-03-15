import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:fluttertoast/fluttertoast.dart';

class SignUpProvider extends ChangeNotifier {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController cPasswordController = TextEditingController();
  final FocusNode emailFocus = FocusNode();
  final FocusNode passFocus = FocusNode();
  final FocusNode confirmPasswordFocus = FocusNode();
  bool isLoading = false;

  void signUp(
      {required String email,
      required String pass,
      required BuildContext context}) async {
    UserCredential? credential;
    try {
      isLoading = true;
      credential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: pass);
      Fluttertoast.showToast(
          msg: 'sign up successful ');

      print("----------${credential.user!.uid}-----------");
      if (credential.user != null) {
        Navigator.pushNamed(context, '/sign_in');
      }
      //   notifyListeners();
    } on FirebaseAuthException catch (e) {
      Fluttertoast.showToast(msg: '---------${e.code}---------');
      print('---------${e.code}---------');
    }
    isLoading = false;
    notifyListeners();
  }
}

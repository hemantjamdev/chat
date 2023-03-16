
import 'package:chat/model/user.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:fluttertoast/fluttertoast.dart';

class SignUpProvider extends ChangeNotifier {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController cPasswordController = TextEditingController();

  final FocusNode passFocus = FocusNode();
  final FocusNode cPasswordFocus = FocusNode();
  UserModel newUser = UserModel();
  bool obSecure = true;
  bool cobSecure = true;
  bool isLoading = false;
void loading(bool load){
  isLoading=load;
  notifyListeners();
}
  void changeObSecure() {
    obSecure = !obSecure;
    notifyListeners();
  }

  void changeCObSecure() {
    cobSecure = !cobSecure;
    notifyListeners();
  }

  Future<bool?> signUp({required BuildContext context}) async {
    UserCredential? credential;
    loading(true);
    if (emailController.text.isNotEmpty &&
        passwordController.text.isNotEmpty &&
        passwordController.text.trim() == cPasswordController.text.trim()) {
      try {
        //isLoading = true;
        credential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
            email: emailController.text.trim(),
            password: passwordController.text.trim());
        if (credential.user != null) {
          await uploadData(credential);
        } else {
          Fluttertoast.showToast(msg: 'something went wrong !');
        }
        return true;
      } on FirebaseAuthException catch (e) {
        Fluttertoast.showToast(msg: e.code);
      }
    } else {
      Fluttertoast.showToast(msg: 'pass not match went wrong !');
    }
    loading(false);
    notifyListeners();
    return false;
  }

  Future<void> uploadData(UserCredential credential) async {
    String uid = credential.user!.uid;
    newUser = UserModel(
        uid: uid, name: "", email: emailController.text.trim(), profilePic: "");
    await FirebaseFirestore.instance
        .collection('users')
        .doc(uid)
        .set(newUser.toMap());

  //  isLoading = false;
    Fluttertoast.showToast(msg: 'SignUp successful');
   // notifyListeners();
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    cPasswordController.dispose();

    passFocus.dispose();
    cPasswordFocus.dispose();
    super.dispose();
  }
}

import 'dart:async';
import 'package:chat/constants/firebase_helper.dart';
import 'package:chat/page/home_page.dart';
import 'package:chat/page/sign_in_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../model/user_model.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  SplashPageState createState() => SplashPageState();
}

class SplashPageState extends State<SplashPage>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();

    // Set the status bar color to match the background color of the splash page
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: Colors.blue[900],
    ));

    // Create the animation controller and animation
    _animationController = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    )..forward();
    _animation = Tween<double>(
      begin: 0,
      end: 1,
    ).animate(_animationController);

    // Wait for the animation to complete before navigating to the home page
    Timer(const Duration(seconds: 3), () {
      handleNavigate();
    });
  }

  handleNavigate() async {
    try {
      User? user = FirebaseAuth.instance.currentUser;
      if (user != null) {
        UserModel? userModel = await FirebaseHelper.getUserById(user.uid);
        if (userModel != null) {
          // ignore: use_build_context_synchronously
          Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                  builder: (_) => HomePage(
                        currentUser: userModel,
                        firebaseUser: user,
                      )));
        }else{
          Navigator.pushReplacement(
              context, MaterialPageRoute(builder: (_) =>  SignInPage()));
        }
      } else {
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (_) =>  SignInPage()));
      }
    } catch (e) {
      Fluttertoast.showToast(msg: e.toString());
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (_) =>  SignInPage()));
    }
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue[900],
      body: Center(
        child: FadeTransition(
          opacity: _animation,
          child: const Text(
            'Chat App',
            style: TextStyle(
              fontSize: 48,
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }
}

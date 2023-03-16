import 'package:chat/model/user.dart';
import 'package:chat/page/chat_home_page.dart';
import 'package:chat/page/chat_room.dart';
import 'package:chat/page/complete_profile.dart';
import 'package:chat/page/error_page.dart';
import 'package:chat/page/home.dart';
import 'package:chat/page/sign_in.dart';
import 'package:chat/page/sign_up.dart';
import 'package:chat/page/splash.dart';
import 'package:flutter/material.dart';

class Routes {
  static Route? onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case '/':
        return MaterialPageRoute(builder: (context) => const SplashPage());
      case '/home':
        return MaterialPageRoute(builder: (context) => const HomePage());
      case '/sign_up':
        return MaterialPageRoute(builder: (context) => const SignUpPage());
      case '/sign_in':
        return MaterialPageRoute(builder: (context) => const SignInPage());
      case '/complete_profile':
        return MaterialPageRoute(
            builder: (context) => CompleteProfilePage(
                userModel: settings.arguments as UserModel));
      case '/chat_room':
        return MaterialPageRoute(builder: (context) => const ChatRoomPage());
      case '/chat_home_page':
        return MaterialPageRoute(
            builder: (context) =>
                ChatHomePage(userModel: settings.arguments as UserModel));
      default:
        return MaterialPageRoute(builder: (context) => const ErrorPage());
    }
  }
}

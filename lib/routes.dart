/*
import 'package:chat/model/user.dart';
import 'package:chat/page/chat_home_page.dart';
import 'package:chat/page/chat_room.dart';
import 'package:chat/page/complete_profile.dart';
import 'package:chat/page/error_page.dart';
import 'package:chat/page/home.dart';
import 'package:chat/page/search.dart';
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
        return MaterialPageRoute(
            builder: (context) =>
                HomePage(data: settings.arguments as Map<String, dynamic>));
      case '/sign_up':
        return MaterialPageRoute(builder: (context) => const SignUpPage());
      case '/sign_in':
        return MaterialPageRoute(builder: (context) => const SignInPage());
      case '/complete_profile':
        return MaterialPageRoute(
            builder: (context) => CompleteProfilePage(
                data: settings.arguments as Map<String, dynamic>));
      case '/chat_room':
        return MaterialPageRoute(
            builder: (context) =>
                ChatRoomPage(data: settings.arguments as Map<String, dynamic>));
      case '/chat_home_page':
        return MaterialPageRoute(
            builder: (context) =>
                ChatHomePage(data: settings.arguments as Map<String, dynamic>));
      case '/search':
        return MaterialPageRoute(
            builder: (context) =>
                SearchPage(data: settings.arguments as Map<String, dynamic>));
      default:
        return MaterialPageRoute(builder: (context) => const ErrorPage());
    }
  }
}
*/

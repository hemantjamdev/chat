import 'package:chat/provider/signin_provider.dart';
import 'package:chat/provider/signup_provider.dart';
import 'package:chat/routes.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const ChatApp());
}

class ChatApp extends StatelessWidget {
  const ChatApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<SignInProvider>(
          create: (context) => SignInProvider(),
        ),
        ChangeNotifierProvider<SignUpProvider>(
          create: (context) => SignUpProvider(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(useMaterial3: false,primaryColor: Color(0xFF075E54),
          accentColor: Color(0xFF25D366),),
        onGenerateRoute: Routes.onGenerateRoute,
      ),
    );
  }
}

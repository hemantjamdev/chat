import 'package:chat/provider/signup_provider.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  SignUpPageState createState() => SignUpPageState();
}

class SignUpPageState extends State<SignUpPage> {
  SignUpProvider signUpProvider = SignUpProvider();
  @override
  void dispose() {
    signUpProvider.emailController.dispose();
    signUpProvider.passwordController.dispose();
    signUpProvider.cPasswordController.dispose();
    signUpProvider.emailFocus.dispose();
    signUpProvider.emailFocus.dispose();
    signUpProvider.emailFocus.dispose();
    signUpProvider.passFocus.dispose();
    signUpProvider.confirmPasswordFocus.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Sign Up'),
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child:
                Consumer<SignUpProvider>(builder: (context, provider, child) {
              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  TextField(
                    focusNode: signUpProvider.emailFocus,
                    controller: signUpProvider.emailController,
                    decoration: const InputDecoration(
                      labelText: 'Email',
                      border: OutlineInputBorder(),
                    ),
                    onSubmitted: (String text) {
                      signUpProvider.emailFocus.unfocus();
                      FocusScope.of(context)
                          .requestFocus(signUpProvider.passFocus);
                    },
                    textInputAction: TextInputAction.next,
                  ),
                  const SizedBox(height: 16.0),
                  TextField(
                    focusNode: signUpProvider.passFocus,
                    controller: signUpProvider.passwordController,
                   // obscureText: true,
                    decoration: const InputDecoration(
                      labelText: 'Password',
                      border: OutlineInputBorder(),
                    ),
                    onSubmitted: (String text) {
                      signUpProvider.passFocus.unfocus();
                      FocusScope.of(context)
                          .requestFocus(signUpProvider.confirmPasswordFocus);
                    },
                    textInputAction: TextInputAction.next,
                  ),
                  const SizedBox(height: 16.0),
                  TextField(
                    focusNode: signUpProvider.confirmPasswordFocus,
                    controller: signUpProvider.cPasswordController,
                   // obscureText: true,
                    decoration: const InputDecoration(
                      labelText: 'Confirm Password',
                      border: OutlineInputBorder(),
                    ),
                    textInputAction: TextInputAction.done,
                    onSubmitted: (String text) {
                      text == signUpProvider.passwordController.text
                          ? print("done")
                          : Fluttertoast.showToast(
                              msg: "enter same pass for both");
                    },
                  ),
                  const SizedBox(height: 16.0),
                  ElevatedButton(
                    onPressed: () {
                      if (signUpProvider.emailController.text.isNotEmpty &&
                          signUpProvider.passwordController.text.isNotEmpty) {
                        signUpProvider.signUp(
                            email: signUpProvider.emailController.text,
                            pass: signUpProvider.passwordController.text,
                            context: context);
                      } else {
                        Fluttertoast.showToast(
                            msg: "enter email and passs both");
                      } // Navigator.pushNamed(context, '/complete_profile');
                    },
                    child: const Text('Sign Up'),
                  ),
                  const SizedBox(height: 16.0),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text("Already have an account ? "),
                        GestureDetector(
                            onTap: () =>
                                Navigator.pushNamed(context, '/sign_in'),
                            child: const Text(
                              'Sign Ip',
                              style: TextStyle(color: Colors.blue),
                            ))
                      ],
                    ),
                  )
                ],
              );
            }),
          ),
        ),
      ),
    );
  }
}

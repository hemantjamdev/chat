import 'package:chat/page/chat_home_page.dart';
import 'package:chat/page/complete_profile_page.dart';
import 'package:chat/provider/signup_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  SignUpPageState createState() => SignUpPageState();
}

class SignUpPageState extends State<SignUpPage> {
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
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
              return Form(
                key: _formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    TextFormField(
                      focusNode: provider.emailFocus,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Please enter your email';
                        }
                        const pattern = r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$';
                        final regExp = RegExp(pattern);
                        if (!regExp.hasMatch(value)) {
                          return 'Please enter a valid email address';
                        }
                        return null;
                      },
                      controller: provider.emailController,
                      decoration: const InputDecoration(
                        labelText: 'Email',
                        border: OutlineInputBorder(),
                      ),
                      onFieldSubmitted: (String email) {
                        FocusScope.of(context).requestFocus(provider.passFocus);
                      },
                      textInputAction: TextInputAction.next,
                      keyboardType: TextInputType.emailAddress,
                    ),
                    const SizedBox(height: 16.0),
                    TextFormField(
                      obscureText: provider.obSecure,
                      focusNode: provider.passFocus,
                      controller: provider.passwordController,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Password cannot be empty';
                        } else if (value.length < 8) {
                          return 'Password must be at least 8 characters long';
                        }
                        return null; // return null if the input is valid
                      },
                      decoration: InputDecoration(
                          labelText: 'Password',
                          border: const OutlineInputBorder(),
                          suffixIcon: IconButton(
                              onPressed: () {
                                provider.changeObSecure();
                              },
                              icon: Icon(provider.obSecure
                                  ? Icons.visibility
                                  : Icons.visibility_off))),
                      textInputAction: TextInputAction.next,
                      onFieldSubmitted: (String email) {
                        FocusScope.of(context)
                            .requestFocus(provider.cPasswordFocus);
                      },
                    ),
                    const SizedBox(height: 16.0),
                    TextFormField(
                      obscureText: provider.cobSecure,
                      focusNode: provider.cPasswordFocus,
                      controller: provider.cPasswordController,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Password cannot be empty';
                        } else if (value.length < 8) {
                          return 'Password must be at least 8 characters long';
                        } else if (value !=
                            provider.passwordController.text.trim()) {
                          return 'Password not match';
                        }
                        return null; // return null if the input is valid
                      },
                      decoration: InputDecoration(
                          labelText: 'Confirm Password',
                          border: const OutlineInputBorder(),
                          suffixIcon: IconButton(
                              onPressed: () {
                                provider.changeCObSecure();
                              },
                              icon: Icon(provider.cobSecure
                                  ? Icons.visibility
                                  : Icons.visibility_off))),
                      textInputAction: TextInputAction.done,
                      onFieldSubmitted: (String email) {
                        FocusScope.of(context).unfocus();
                      },
                    ),
                    const SizedBox(height: 16.0),
                    ElevatedButton(
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          provider.signUp(context: context).then(
                            (value) {
                              if (value!) {
                                showDialog(
                                    context: context,
                                    builder: (context) {
                                      return AlertDialog(
                                        actions: [
                                          ElevatedButton(
                                              onPressed: () {
                                                Navigator.pop(context);
                                                Navigator.pushReplacement(
                                                  context,
                                                  MaterialPageRoute(
                                                    builder: (_) =>
                                                        ChatHomePage(
                                                            firebaseUser:
                                                                provider
                                                                    .credential!
                                                                    .user!,
                                                            currentUser:
                                                                provider
                                                                    .newUser),
                                                  ),
                                                );
                                              },
                                              child: const Text("Skip for now")),
                                          ElevatedButton(
                                              onPressed: () {
                                                Navigator.pop(context);
                                                Navigator.pushReplacement(
                                                  context,
                                                  MaterialPageRoute(
                                                    builder: (_) =>
                                                        CompleteProfilePage(
                                                            firebaseUser:
                                                                provider
                                                                    .credential!
                                                                    .user!,
                                                            currentUser:
                                                                provider
                                                                    .newUser),
                                                  ),
                                                );
                                              },
                                              child: const Text("continue"))
                                        ],
                                        content: const Text(
                                            "Account Created ! Want to complete profile ?"),
                                      );
                                    });
                              }
                            },
                          );
                        }
                      },
                      child: provider.isLoading
                          ? const SizedBox(child: CircularProgressIndicator())
                          : const Text('Sign Up'),
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
                                  Navigator.pop(context,),
                              child: const Text(
                                'Sign in',
                                style: TextStyle(color: Colors.blue),
                              ))
                        ],
                      ),
                    )
                  ],
                ),
              );
            }),
          ),
        ),
      ),
    );
  }
}

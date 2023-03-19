import 'package:chat/page/chat_home_page.dart';
import 'package:chat/page/sign_up_page.dart';
import 'package:chat/provider/signin_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SignInPage extends StatefulWidget {
  const SignInPage({super.key});

  @override
  SignInPageState createState() => SignInPageState();
}

class SignInPageState extends State<SignInPage> {
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
    return Scaffold(
      appBar: AppBar(title: const Text('Sign In')),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Consumer<SignInProvider>(builder: (context, provider, child) {
            return SingleChildScrollView(
              child: Form(
                key: _formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    TextFormField(
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
                      textInputAction: TextInputAction.done,
                      onFieldSubmitted: (String email) {
                        FocusScope.of(context).unfocus();
                      },
                    ),
                    const SizedBox(height: 16.0),
                    ElevatedButton(
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          provider.signIn(context: context).then((value) {
                            if (value!) {
                              Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                      builder: (_) => ChatHomePage(
                                          currentUser: provider.userModel,
                                          firebaseUser:
                                              provider.credential!.user!)));
                            }
                          });
                        }
                      },
                      child: provider.isLoading
                          ? const SizedBox(child: CircularProgressIndicator())
                          : const Text('Sign In'),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text("Don't have an account ? "),
                          GestureDetector(
                            onTap: () => Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (_) => const SignUpPage())),
                            child: const Text(
                              'Sign Up',
                              style: TextStyle(color: Colors.blue),
                            ),
                          )
                        ],
                      ),
                    )
                  ],
                ),
              ),
            );
          }),
        ),
      ),
    );
  }
}

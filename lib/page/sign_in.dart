import 'package:chat/provider/signin_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SignInPage extends StatefulWidget {
  const SignInPage({super.key});

  @override
  SignInPageState createState() => SignInPageState();
}

class SignInPageState extends State<SignInPage> {
  final SignInProvider sProvider = SignInProvider();

  @override
  void dispose() {
    sProvider.emailController.dispose();
    sProvider.passwordController.dispose();
    sProvider.emailFocus.dispose();
    sProvider.passFocus.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Sign In'),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Consumer<SignInProvider>(builder: (context, sProvider, child) {
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                TextField(
                  focusNode: sProvider.emailFocus,
                  controller: sProvider.emailController,
                  decoration: const InputDecoration(
                    labelText: 'Email',
                    border: OutlineInputBorder(),
                  ),
                  onSubmitted: (String email) {
                    FocusScope.of(context).requestFocus(sProvider.passFocus);
                  },
                  textInputAction: TextInputAction.next,
                  keyboardType: TextInputType.emailAddress,
                ),
                const SizedBox(height: 16.0),
                TextField(
                  focusNode: sProvider.passFocus,
                  controller: sProvider.passwordController,
                 // obscureText: true,
                  decoration: const InputDecoration(
                    labelText: 'Password',
                    border: OutlineInputBorder(),
                  ),
                  textInputAction: TextInputAction.done,
                  onSubmitted: (String email){
                    sProvider.signIn(context: context);
                  },
                ),
                const SizedBox(height: 16.0),
                ElevatedButton(
                  onPressed: () {
                   sProvider.signIn(context: context);
                  },
                  child: sProvider.isLoading
                      ? SizedBox(child: CircularProgressIndicator())
                      : Text('Sign In'),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text("Don't have an account ? "),
                      GestureDetector(
                        onTap: () => Navigator.pushNamed(context, '/sign_up'),
                        child: const Text(
                          'Sign Up',
                          style: TextStyle(color: Colors.blue),
                        ),
                      )
                    ],
                  ),
                )
              ],
            );
          }),
        ),
      ),
    );
  }
}

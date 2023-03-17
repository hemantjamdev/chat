import 'package:chat/model/user.dart';
import 'package:chat/page/chat_home_page.dart';
import 'package:chat/provider/complete_profile_provider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CompleteProfilePage extends StatefulWidget {
  final User firebaseUser;
  final UserModel currentUser;

  const CompleteProfilePage(
      {super.key, required this.firebaseUser, required this.currentUser});

  @override
  CompleteProfilePageState createState() => CompleteProfilePageState();
}

class CompleteProfilePageState extends State<CompleteProfilePage> {
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
      appBar: AppBar(
        title: const Text('Complete Profile'),
      ),
      body: Consumer<CompleteProfileProvider>(
        builder: (context, provider, child) {
          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                GestureDetector(
                  onTap: () {
                    provider.showPickOption(context);
                  },
                  child: CircleAvatar(
                    radius: 50.0,
                    backgroundImage: provider.imageFile != null
                        ? FileImage(provider.imageFile!)
                        : null,
                    child: provider.imageFile != null
                        ? null
                        : const Icon(Icons.person),
                  ),
                ),
                const SizedBox(height: 16.0),
                Form(
                  key: _formKey,
                  child: TextFormField(
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Please enter your Name';
                      }
                      return null;
                    },
                    controller: provider.fullNameController,
                    decoration: const InputDecoration(
                      labelText: 'Full Name',
                      border: OutlineInputBorder(),
                    ),
                    onFieldSubmitted: (String email) {
                      FocusScope.of(context).unfocus();
                    },
                    textInputAction: TextInputAction.done,
                  ),
                ),
                ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      provider
                          .uploadData(userModel: widget.currentUser)
                          .then(
                        (value) {
                          if (value!) {
                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                builder: (_) => ChatHomePage(
                                    currentUser: provider.currentUser,
                                    firebaseUser: widget.firebaseUser),
                              ),
                            );
                          }
                        },
                      );
                    }
                  },
                  child: provider.isLoading
                      ? const SizedBox(
                          child: CircularProgressIndicator(),
                        )
                      : const Text('SUBMIT'),
                )
              ],
            ),
          );
        },
      ),
    );
  }
}

import 'package:chat/model/user.dart';
import 'package:chat/page/sign_in.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ProfilePage extends StatelessWidget {
  final UserModel currentUser;

  const ProfilePage({super.key, required this.currentUser});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            CircleAvatar(
              radius: 102,
              backgroundColor: Colors.blue,
              child: CircleAvatar(
                radius: 100,
                backgroundImage: NetworkImage(currentUser.profilePic.toString()),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            ListTile(
              leading: Icon(Icons.person),
              tileColor: Colors.black12,
              title: Text(currentUser.name.toString()),
              trailing: IconButton(
                onPressed: (){},
                icon: Icon(Icons.edit),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            ListTile( tileColor: Colors.black12,
              leading: Icon(Icons.email_outlined),
              title: Text(currentUser.email.toString()),
              trailing: IconButton(
                onPressed: (){},
                icon: Icon(Icons.edit),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            ElevatedButton(
              onPressed: () async{
               await  FirebaseAuth.instance.signOut();
               Navigator.pushReplacement(context,
    MaterialPageRoute(builder: (_) => SignInPage()));},
              child: Row(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Icon(Icons.logout),
                  Text('LOGOUT'),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';


class ChatListPage extends StatelessWidget {
  const ChatListPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Material(
      child: ListView.builder(
        itemCount: 5,
        itemBuilder: (BuildContext context, int index) {
          return Column(
            children: [
              ListTile(
                leading: const CircleAvatar(
                  radius: 28.0,
                  //backgroundImage: NetworkImage(chatData[index].imageUrl),
                ),
                title: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: const [
                    Text(
                      'chaex].name',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      'chat].time',
                      style: TextStyle(
                        color: Colors.grey,
                        fontSize: 12.0,
                      ),
                    ),
                  ],
                ),
                subtitle: Container(
                  padding: const EdgeInsets.only(top: 5.0),
                  child: const Text(
                    ' chatessage',
                    style: TextStyle(
                      color: Colors.grey,
                      fontSize: 15.0,
                    ),
                  ),
                ),
                onTap: () {},
              ),
              const Divider(
                height: 10.0,
              ),
            ],
          );
        },
      ),
    );
  }
}

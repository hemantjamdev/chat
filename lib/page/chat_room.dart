import 'package:flutter/material.dart';

class ChatRoomPage extends StatefulWidget {
  const ChatRoomPage({super.key});

  @override
  ChatRoomPageState createState() => ChatRoomPageState();
}

class ChatRoomPageState extends State<ChatRoomPage> {
  final List<Message> _messages = [
    Message(sender: 'John', text: 'Hi there!', isMe: false),
    Message(sender: 'Jane', text: 'Hey!', isMe: true),
    Message(sender: 'John', text: 'How are you?', isMe: false),
    Message(
        sender: 'Jane', text: 'I\'m good, thanks. How about you?', isMe: true),
    Message(sender: 'John', text: 'Doing well, thanks!', isMe: false),
  ];
  final TextEditingController _messageController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Chatroom'),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: _messages.length,
              itemBuilder: (BuildContext context, int index) {
                return MessageBubble(
                  message: _messages[index],
                );
              },
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10.0),
            decoration: const BoxDecoration(
              border: Border(
                top: BorderSide(color: Colors.grey),
              ),
            ),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _messageController,
                    decoration: const InputDecoration(
                      hintText: 'Type your message...',
                    ),
                  ),
                ),
                const SizedBox(width: 10.0),
                ElevatedButton(
                  onPressed: () {
                    String text = _messageController.text.trim();
                    if (text.isNotEmpty) {
                      setState(() {
                        _messages.add(
                            Message(sender: 'You', text: text, isMe: true));
                        _messageController.clear();
                      });
                    }
                  },
                  child: const Text('Send'),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class Message {
  final String sender;
  final String text;
  final bool isMe;

  Message({
    required this.sender,
    required this.text,
    required this.isMe,
  });
}

class MessageBubble extends StatelessWidget {
  final Message message;

  const MessageBubble({super.key, required this.message});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5.0, horizontal: 10.0),
      child: Row(
        mainAxisAlignment:
            message.isMe ? MainAxisAlignment.end : MainAxisAlignment.start,
        children: [
          if (!message.isMe)
            Padding(
              padding: const EdgeInsets.only(right: 10.0),
              child: Text(
                message.sender,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          Container(
            padding:
                const EdgeInsets.symmetric(horizontal: 10.0, vertical: 5.0),
            decoration: BoxDecoration(
              color: message.isMe ? Colors.blue : Colors.grey[300],
              borderRadius: BorderRadius.only(
                topLeft: const Radius.circular(10.0),
                topRight: const Radius.circular(10.0),
                bottomLeft: message.isMe
                    ? const Radius.circular(10.0)
                    : const Radius.circular(0.0),
                bottomRight: message.isMe
                    ? const Radius.circular(0.0)
                    : const Radius.circular(10.0),
              ),
            ),
            child: Text(message.text,
                style:
                    TextStyle(color: message.isMe ? Colors.white : Colors.green)),
          )
        ],
      ),
    );
  }
}

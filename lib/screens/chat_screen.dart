import 'package:flutter/material.dart';
import 'package:flutter_chat_app/models/chat_element.dart';
import 'package:flutter_chat_app/screens/auth_screen.dart';
import 'package:flutter_chat_app/widgets/message_bubble.dart';

class ChatScreen extends StatefulWidget {
  static const String routeName = '/chat';

  final String userName;

  const ChatScreen({
    super.key,
    required this.userName,
  });

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  // Todo: Connect to socket
  // ws://your_ip:8080

  // textfied controller (we use it to get message
  // and invalidate message from button
  // and also clear textfield )
  late final TextEditingController _textEditingController;


  @override
  void initState() {
    //Todo: Connect to socket.
    _textEditingController = TextEditingController();
    super.initState();
  }

// Todo: Close socket connection on dispose
  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    final List<ChatElement> messages = [];

    return Scaffold(
      appBar: AppBar(
        leading: const Icon(Icons.stream),
        actions: [
          IconButton(
            onPressed: () {
              // Todo: Add Socket Disconnect
              // Go back to authPage
              Navigator.pushReplacementNamed(context, AuthScreen.routeName);
            },
            icon: const Icon(Icons.logout),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Expanded(
              child: messages.isEmpty
                  ? ListView.builder(
                      itemCount: messages.length,
                      itemBuilder: (context, index) {
                        final user = messages[index].userName;
                        final message = messages[index].message;

                        return MessageBubble(
                          isCurrentUser: widget.userName == user,
                          userName: user,
                          message: message,
                        );
                      },
                    )
                  : const Text('No messages...'),
            ),
            TextField(
              controller: _textEditingController,
              decoration: const InputDecoration(
                prefixIcon: Icon(Icons.messenger),
                labelText: 'send message',
                border: OutlineInputBorder(),
              ),
            ),
            TextButton(
              onPressed: () {
                // Todo: Send message
                _textEditingController.clear();
              },
              child: const Text('Send message'),
            ),
          ],
        ),
      ),
    );
  }
}

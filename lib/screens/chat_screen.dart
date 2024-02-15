import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_chat_app/models/chat_element.dart';
import 'package:flutter_chat_app/screens/auth_screen.dart';
import 'package:flutter_chat_app/widgets/message_bubble.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

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
  // 1. Connect to socket
  // ws://your_ip:8080
  //
  final wsUrl = Uri.parse('ws://191.153.11.10:8080');
  late final WebSocketChannel _channel;

  // textfied controller (we use it to get message
  // and invalidate message from button
  // and also clear textfield )
  late final TextEditingController _textEditingController;

  // With Scroll controller we can scroll programmatically
  // For example when we receive new message.
  late final ScrollController _scrollController;

  @override
  void initState() {
    // Connect to socket.
    _channel = WebSocketChannel.connect(wsUrl);

    _scrollController = ScrollController();
    _textEditingController = TextEditingController();
    super.initState();
  }

// Close connection on dispose
  @override
  void dispose() {
    _channel.sink.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const Icon(Icons.stream),
        actions: [
          IconButton(
            onPressed: () {
              // Disconnect and go to AuthPage
              _channel.sink.close();
              Navigator.pushNamed(context, AuthScreen.routeName);
            },
            icon: const Icon(Icons.logout),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: StreamBuilder<List<ChatElement>>(
          // Here we listen to stream in stream Builder
          // We also need to transform stream with stream.transform
          stream: _channel.stream.transform(
            // We need to transform stream, because we receive Json from socket server(dynamic),
            // we need to parse it to List<String>
            StreamTransformer<dynamic, List<ChatElement>>.fromHandlers(
              handleData: (data, sink) {
                final decodedData = jsonDecode(data) as List<dynamic>;

                final elements = List<ChatElement>.from(
                  decodedData.map((model) {
                    return ChatElement.fromJson(model as Map<String, dynamic>);
                  }),
                );
                sink.add(elements);

                // addPostFrameCallback ensures
                // we call action inside the callback after widget is build!
                // Otherwise _scrollController will throw error.
                WidgetsBinding.instance.addPostFrameCallback((_) {
                  _scrollController.animateTo(
                    _scrollController.position.maxScrollExtent,
                    curve: Curves.easeOut,
                    duration: const Duration(milliseconds: 300),
                  );
                });
              },
            ),
          ),
          builder: (BuildContext context,
              AsyncSnapshot<List<ChatElement>> snapshot) {
            if (snapshot.hasError) {
              return const Text('Oops, error has occurred');
            } else {
              switch (snapshot.connectionState) {
                case ConnectionState.none:
                  return const Text('No connection...');
                case ConnectionState.waiting:
                  return const Text('Waiting...');
                case ConnectionState.active:
                case ConnectionState.done:
                  return Column(
                    children: [
                      Expanded(
                        child: snapshot.hasData
                            ? ListView.builder(
                                controller: _scrollController,
                                itemCount: snapshot.data!.length,
                                itemBuilder: (context, index) {
                                  final user = snapshot.data![index].userName;
                                  final message = snapshot.data![index].message;

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
                          _channel.sink.add(
                            jsonEncode(
                                // Encode with map
                                // https://docs.flutter.dev/data-and-backend/serialization/json
                                {
                                  'userName': widget.userName,
                                  'message': _textEditingController.text,
                                }),
                          );
                          _textEditingController.clear();
                        },
                        child: const Text('Send message'),
                      ),
                    ],
                  );
              }
            }
          },
        ),
      ),
    );
  }
}

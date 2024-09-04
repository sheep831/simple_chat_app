import 'package:flutter/material.dart';
import 'package:chat_app/widgets/chat_message.dart';
import 'package:chat_app/widgets/new_message.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:firebase_auth/firebase_auth.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  void setupNotifications() async {
    // ask user for permission to push notifications
    final fcm = FirebaseMessaging.instance;
    await fcm.requestPermission();
    final token = await fcm.getToken(); // yields the address of the device

    fcm.subscribeToTopic(
        'chat'); // subscribe to the topic 'chat' so it can broadcast to all users
  }

  @override
  void initState() {
    // never turn it to async
    super.initState();

    setupNotifications();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Chat'),
          actions: [
            IconButton(
              onPressed: () => FirebaseAuth.instance.signOut(),
              icon: Icon(
                Icons.exit_to_app,
                color: Theme.of(context).colorScheme.primary,
              ),
            )
          ],
        ),
        body: const Column(
          children: [
            Expanded(child: ChatMessages()),
            NewMessage(),
          ],
        ));
  }
}

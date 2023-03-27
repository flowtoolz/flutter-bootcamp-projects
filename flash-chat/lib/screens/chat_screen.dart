import 'package:flash_chat_new/initialize_firebase.dart';
import 'package:flutter/material.dart';
import 'package:flash_chat_new/components/constants.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ChatScreen extends StatefulWidget {

  static const id = 'chat';

  const ChatScreen({super.key});

  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: null,
        actions: <Widget>[
          IconButton(
              icon: const Icon(Icons.close),
              onPressed: () {
                logout();
              }),
        ],
        title: const Text('⚡️Chat'),
        backgroundColor: Colors.lightBlueAccent,
      ),
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            const MessageStream(),
            Container(
              decoration: kMessageContainerDecoration,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Expanded(
                    child: TextField(
                      controller: editingController,
                      onChanged: (value) {
                        message = value;
                      },
                      decoration: kMessageTextFieldDecoration,
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      send();
                      editingController.clear();
                    },
                    child: const Text(
                      'Send',
                      style: kSendButtonTextStyle,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  logout() async {
    try {
      await ensureFirebaseIsInitialized();
      await FirebaseAuth.instance.signOut();
      Navigator.pop(context);
    } catch (exception) {
      print(exception);
    }
  }

  send() async {
    if (message.isEmpty) return;

    try {
      await ensureFirebaseIsInitialized();

      final email = getUserEmail();

      if (email == null) { 
        print('Could not retrieve user email');
        return;
      }

      final messageCollection = FirebaseFirestore.instance.collection('messages');

      messageCollection.add({
        'text': message,
        'author': email,
      });

    } catch (exception) {
      print(exception);
    }
  }

  final editingController = TextEditingController();

  String message = '';
}


class MessageStream extends StatelessWidget {
  const MessageStream({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: FirebaseFirestore.instance.collection('messages').snapshots(),
      builder: buildMessageColumn,
    );
  }

  Widget buildMessageColumn(
    BuildContext context,
    AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>> asyncSnapShot
  ) {
    final messageDocs = asyncSnapShot.data?.docs ?? [];



    if (messageDocs.isEmpty) {
      return const Center(
        child: CircularProgressIndicator(
          backgroundColor: Colors.lightBlueAccent,
        )
      );
    }

    final email = getUserEmail() ?? '';

    List<MessageBubble> messageWidgets = [];

    for (final messageDoc in messageDocs) {
      final message = messageDoc.data();
      final author = message['author'];
      messageWidgets.add(MessageBubble(
        author: author, 
        text: message['text'],
        authorIsUser: author == email,
      ));
    }

    return Expanded(
      child: ListView(
        reverse: true,
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
        children: messageWidgets,
      )
    );
  }
}

class MessageBubble extends StatelessWidget {
  
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Column(
        crossAxisAlignment: authorIsUser ? CrossAxisAlignment.end : CrossAxisAlignment.start,
        children: [
          Text(
            author,
            style: const TextStyle(
              color: Colors.black54,
              fontSize: 12,
            ),
          ),
          Material(
            elevation: 5,
            borderRadius: BorderRadius.only(
              topLeft: authorIsUser ? const Radius.circular(30) : Radius.zero,
              topRight: !authorIsUser ? const Radius.circular(30) : Radius.zero,
              bottomLeft: const Radius.circular(30),
              bottomRight: const Radius.circular(30),
            ),
            color: authorIsUser ? Colors.lightBlueAccent : Colors.white,
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
              child: Text(
                text,
                style: TextStyle(
                  fontSize: 15,
                  color: authorIsUser ? Colors.white : Colors.black54,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  const MessageBubble({
    super.key, 
    required this.text, 
    required this.author,
    required this.authorIsUser,
  });

  final String text;
  final String author;
  final bool authorIsUser;
}

String? getUserEmail() {
  return FirebaseAuth.instance.currentUser?.email;
}
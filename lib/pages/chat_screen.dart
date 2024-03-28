import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/widgets.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({Key? key}) : super(key: key);

  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final _firestore = FirebaseFirestore.instance;
  final _auth = FirebaseAuth.instance;
  late User signInUser;
  late String messageText;
  final messageTextController = TextEditingController();

  @override
  void initState() {
    super.initState();
    getCurrentUser();
  }

  void getCurrentUser() {
    try {
      final user = _auth.currentUser;
      if (user != null) {
        signInUser = user;
        print(signInUser);
      }
    } catch (e) {
      print(e);
    }
  }

  void messagesStreams() async {
    await for (var snapshot in _firestore.collection('messages').snapshots()) {
      for (var message in snapshot.docs) {
        print(message.data());
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFF24786D),
        centerTitle: true,
        title: Row(
          children: [
            Text('ChatBox',style: TextStyle(color: Colors.white),),
          ],
        ),
        actions: [
          IconButton(
            onPressed: () {
              _auth.signOut();
              Navigator.pop(context);
            },
            icon: Icon(Icons.logout,color: Colors.white,),
          ),
        ],
      ),
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            StreamBuilder(
              stream: _firestore.collection('messages').orderBy('time').snapshots(),
              builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                if (!snapshot.hasData) {
                  return Center(
                    child: CircularProgressIndicator(),
                  ); // Placeholder for loading state
                }
                final messages = snapshot.data!.docs;
                List<Widget> messagesWidgets = [];
                for (var message in messages) {
                  final messageText = message['message'];
                  final messageSender = message['sender'];
                  final isMe = signInUser.email == messageSender;
                  final messageWidget = Padding(
                    padding: EdgeInsets.all(15),
                    child: Column(
                      crossAxisAlignment: isMe ? CrossAxisAlignment.end : CrossAxisAlignment.start,
                      children: [
                        Text(
                          messageSender,
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Material(
                          elevation: 5,
                          borderRadius: BorderRadius.only(
                            topLeft: isMe ? Radius.circular(30) : Radius.circular(0),
                            topRight: isMe ? Radius.circular(0) : Radius.circular(30),
                            bottomLeft: Radius.circular(30),
                            bottomRight: Radius.circular(30),
                          ),
                          color: isMe ? Colors.blue : Colors.red,
                          child: Padding(
                            padding: EdgeInsets.symmetric(
                              vertical: 10,
                              horizontal: 20,
                            ),
                            child: Text(
                              '$messageText',
                              style: TextStyle(
                                fontSize: 15,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  );
                  messagesWidgets.add(messageWidget);
                }
                return Expanded(
                  child: ListView(
                    reverse: true,
                    children: messagesWidgets.reversed.toList(),
                  ),
                );
              },
            ),
            Container(
              decoration: BoxDecoration(
                border: Border(
                  top: BorderSide(
                    color: Colors.orange,
                    width: 2,
                  ),
                ),
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Expanded(
                    child: TextField(
                      controller: messageTextController,
                      onChanged: (value) {
                        messageText = value;
                      },
                      decoration: InputDecoration(
                        contentPadding: EdgeInsets.symmetric(
                          vertical: 10,
                          horizontal: 20,
                        ),
                        hintText: 'Write your message here...',
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                  TextButton(
                    onPressed: () async {
                      try {
                        messageTextController.clear();
                        await _firestore.collection("messages").add({
                          'message': messageText,
                          'sender': signInUser.email,
                          'time':FieldValue.serverTimestamp()
                        });
                      } catch (e) {
                        print(e);
                      }
                    },
                    child: Text(
                      'Send',
                      style: TextStyle(
                        color: Colors.blue[800],
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

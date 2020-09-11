import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:quick_chat/util/constants.dart';
import 'package:quick_chat/widgets/custom_text_field.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:quick_chat/widgets/message_bubble.dart';

class ChatScreen extends StatefulWidget {
  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final messageTextController = TextEditingController();
  final _auth = FirebaseAuth.instance;
  final _firestore = FirebaseFirestore.instance;
  User loggedInUser;
  String messageText;

  @override
  void initState() {
    super.initState();
    getCurrentUser();
  }

  void getCurrentUser() async {
    try {
      final user = _auth.currentUser;
      if (user != null) {
        loggedInUser = user;
      }
    } catch (e) {
      print(e);
    }
    print(loggedInUser.email);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kBackgroundColor,
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 24),
        child: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  GestureDetector(
                    child: Icon(
                      Icons.arrow_back_ios,
                    ),
                    onTap: () {
                      Navigator.pop(context);
                      _auth.signOut();
                    },
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 4.0),
                    child: Text(
                      'Chat',
                      style: kTitleText,
                      textAlign: TextAlign.center,
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.pop(context);
                      _auth.signOut();
                    },
                    child: Container(
                      width: 30,
                      child: Text(
                        'Log Out',
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 10,
              ),
              Container(
                height: 1,
                width: double.infinity,
                color: kDarkColor,
              ),
              Expanded(
                flex: 9,
                child: Column(
                  children: <Widget>[
                    StreamBuilder<QuerySnapshot>(
                      stream: _firestore.collection('messages').snapshots(),
                      builder: (context, snapshot) {
                        if (snapshot.hasData) {
                          final messages = snapshot.data.docs;
                          List<MessageBubble> messageWidgets = [];
                          for (var message in messages) {
                            final messageText = message.get('text');
                            final messageSender = message.get('sender');
                            final currentUser = loggedInUser.email;
                            final messageWidget = MessageBubble(
                              sender: messageSender,
                              text: messageText,
                              isMe: currentUser == messageSender,
                            );
                            messageWidgets.add(messageWidget);
                          }
                          return Expanded(
                            child: ListView(
                              reverse: true,
                              padding: EdgeInsets.symmetric(
                                  horizontal: 10, vertical: 20),
                              children: messageWidgets,
                            ),
                          );
                        } else {
                          return Center(
                            child: CircularProgressIndicator(
                              backgroundColor: kLightColor,
                            ),
                          );
                        }
                      },
                    ),
                  ],
                ),
              ),
              Container(
                width: double.infinity,
                height: 1,
                color: kDarkColor,
              ),
              SizedBox(
                height: 10,
              ),
              Expanded(
                flex: 1,
                child: Row(
                  children: [
                    Expanded(
                      flex: 5,
                      child: CustomTextField(
                        messageTextController: messageTextController,
                        hint: 'Enter a message...',
                        type: TextInputType.multiline,
                        onChanged: (value) {
                          messageText = value;
                        },
                      ),
                    ),
                    Expanded(
                      flex: 1,
                      child: GestureDetector(
                        onTap: () {
                          var now =
                              DateTime.parse(new DateTime.now().toString());
                          messageTextController.clear();
                          _firestore.collection('messages').add({
                            'sender': loggedInUser.email,
                            'text': messageText,
                            'time': now,
                          });
                          messageText = '';
                        },
                        child: Icon(
                          Icons.add,
                          color: kLightColor,
                          size: 40,
                        ),
                      ),
                    )
                  ],
                ),
              ),
              SizedBox(
                height: 40,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

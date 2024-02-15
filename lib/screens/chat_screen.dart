// ignore_for_file: prefer_const_constructors, unused_import

import 'package:chat_me/screens/welcome_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';


final _fireStore= FirebaseFirestore.instance;
late User signedInUser;

class ChatScreen extends StatefulWidget {

  static const String screenRoute='chat_screen';//the route to call the screen
  const ChatScreen({super.key});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final messageTextController= TextEditingController();//we use it to cleare the field after sending the message
  final _auth = FirebaseAuth.instance;
  // this is the user email to be used and displayed
  String? messageText;// this is the message text to be sent
  @override
  void initState() {
    
    super.initState();
    getCurrentUser();
  }

  void getCurrentUser(){
    try {
    final user = _auth.currentUser;
    if(user != null){
      signedInUser=user;
      print(signedInUser.email);
    }
    } catch (e) {
      print(e);
    }
  }

  /*void getMessages() async {
  this method gets the messages while pressing the button only
    final messages = await _fireStore.collection('messages').get();
    for(var message in messages.docs){
      print(message.data());
    }}*/

    /*void messagesStream() async {
      //this method is way better then the previous one because it updates 
      //the messages automatically
      await for(var snapshot in _fireStore.collection('messages').snapshots()){
        for (var message in snapshot.docs){
          print(message.data());
        }
      }
    }*/
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
     // backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.amber,
        title: Row(
          
          children: [
            Image.asset('images/chat-icon.png',height: 25,),
            SizedBox(width: 10),
            Text('ChatMe'),
          ],
        ),
        actions: [//the button on the right in the app bar
          IconButton(
            onPressed: (){
              //Implement here the function to close the chat
              _auth.signOut();
              Navigator.pop(context);
              Navigator.pushNamed(context, WelcomeScreen.screenRoute);
              //messagesStream();
            }, 
            icon: Icon(Icons.logout),),
        ],
      ),
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            MessageStreamBuilder(),//the class that recieves and organizes the msgs
            Container(
              decoration: BoxDecoration(
                border: Border(
                  top: BorderSide(
                    color: Colors.amber,
                    width: 2,
                    ),
                  ),
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Expanded(
                    child: TextField(onChanged:(value) {
                      messageText=value;//storing the textField content in a string value
                  },
                  controller: messageTextController,
                     decoration: InputDecoration(
                      contentPadding: EdgeInsets.symmetric(
                        vertical: 10,
                        horizontal: 20,
                      ),
                      hintText: 'Your message',
                      border: InputBorder.none,
                     ),
                     ),
                    ),
                    TextButton(
                      onPressed:() {
                        messageTextController.clear();
                        _fireStore.collection('messages').add({
                          'text': messageText,
                          'sender': signedInUser.email,
                          'time' : FieldValue.serverTimestamp(),
                        });
                      }, 
                      child: Text(
                        'send',
                        style: TextStyle(
                          color: Color.fromARGB(255, 13, 82, 185),
                          fontWeight: FontWeight.bold,
                          fontSize: 19,
                        ),
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
}

class MessageStreamBuilder extends StatelessWidget {
  const MessageStreamBuilder({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
              stream: _fireStore.collection('messages').orderBy('time').snapshots(), 
              builder: (context, snapshot){
                List<MessageCard> MessageWidgets=[];//it will contain the message widgets as a widget(message and sender)
                if (!snapshot.hasData){
                  return Center(
                    child: CircularProgressIndicator(
                      backgroundColor: Color.fromARGB(255, 13, 82, 185),
                      ),
                  );
                }
                final messages =snapshot.data!.docs.reversed;

                for(var message in messages){
                  final messageText = message.get('text');
                  final messageSender = message.get('sender');
                  final currentUser = signedInUser.email;

                  
                  final messageWidget = MessageCard(
                  text: messageText, sender: messageSender,amItheSender: currentUser==messageSender,);
                  MessageWidgets.add(messageWidget);
                }

                return Expanded(
                  child: ListView(
                    reverse: true,
                    padding: EdgeInsets.symmetric(horizontal: 10,vertical: 15),
                    children: MessageWidgets,
                    ),
                );
              }
              );
  }
}

class MessageCard extends StatelessWidget {//the design of the message block
  const MessageCard({this.sender,this.text, required this.amItheSender,super.key});
  final String? text;
  final String? sender;
  final bool amItheSender;//to make the app separate between the user and other chatters

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment:amItheSender?  CrossAxisAlignment.end :CrossAxisAlignment.start,
        children: [
          Text('$sender',style: TextStyle(color: Colors.black45,fontSize: 12),),
          Material(
            borderRadius: amItheSender?  BorderRadius.only(
              topLeft: Radius.circular(40),
              bottomLeft: Radius.circular(40),
              bottomRight: Radius.circular(40),
            ) : BorderRadius.only(
              topRight: Radius.circular(40),
              bottomLeft: Radius.circular(40),
              bottomRight: Radius.circular(40),
            ),
            color:amItheSender ? Colors.purple[800]: Color.fromARGB(255, 13, 82, 185),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15,vertical: 10),
              child: Text(
                '$text',
                 style: TextStyle(fontSize: 15,color: Colors.white),),
            ),
          ),
        ],
      ),
    );
  }
}
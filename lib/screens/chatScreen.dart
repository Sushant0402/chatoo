import 'package:chatoo/widgets/chat/enterMessage.dart';
import 'package:chatoo/widgets/chat/messages.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({Key? key}) : super(key: key);

  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  @override
  void initState() {
    // TODO: implement initState



    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Chatoo"),
        actions: [
          IconButton(onPressed: (){
            showDialog(context: context, builder:(ctx) => AlertDialog(
              content:Text("Do you want to Logout"),
              actions: [
                TextButton(onPressed: (){
                  Navigator.pop(context);
                }, child: Text("Cancel")),
                TextButton(onPressed: (){
                  Navigator.pop(context);
                  FirebaseAuth.instance.signOut();
                }, child: Text("Ok"))
              ],
            ));
          }, icon: Icon(Icons.exit_to_app)),
        ],
      ),
      body: Container(
        child: Column(
          children: [
            Expanded(child: Messages()),
            EnterNewMessage()
          ],
        ),
      ),
    );
  }
}

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class EnterNewMessage extends StatefulWidget {
  const EnterNewMessage({Key? key}) : super(key: key);

  @override
  _EnterNewMessageState createState() => _EnterNewMessageState();
}

class _EnterNewMessageState extends State<EnterNewMessage>{
  final _inputController = TextEditingController();

  void _sendMessage() async {

    final user = FirebaseAuth.instance.currentUser;
    final userData = await FirebaseFirestore.instance.collection("users").doc(user!.uid).get();
    FirebaseFirestore.instance.collection("chat").add({
      "text": _inputController.text,
      "createdAt": Timestamp.now(),
      "userId": user.uid,
      "username": userData["username"],
      "imageUrl":userData["imageUrl"]
    });

    _inputController.clear();
  }


  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              style: TextStyle(
                color: Colors.white,
              ),
              decoration: InputDecoration(
                hintStyle: TextStyle(
                  color: Colors.grey,
                ),
                contentPadding: EdgeInsets.only(top: 10, bottom: 10, left: 20, right: 10),
                fillColor: Theme.of(context).accentColor.withOpacity(0.5),
                hintText: "Enter a message",
                filled: true,
                border: InputBorder.none,
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              controller: _inputController,
              maxLines: null,
              cursorColor: Theme.of(context).accentColor,
            ),
          ),
          SizedBox(width: 10,),
          Container(
            height: 45,
            width: 45,
            decoration: BoxDecoration(
              color: Theme.of(context).accentColor,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Center(
              child: IconButton(
                  icon: Icon(
                    Icons.send,
                    color: Theme.of(context).primaryColor.withOpacity(0.7),
                    size: 30,
                  ),
                onPressed: (){
                    print(_inputController.text.isEmpty);
                    FocusScope.of(context).unfocus();
                    if(_inputController.text.isEmpty == false){
                        _sendMessage();
                    }
                }
              ),
            ),
          ),
        ],
      ),
    );
  }
}

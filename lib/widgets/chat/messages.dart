import 'package:chatoo/widgets/chat/messageBubble.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Messages extends StatelessWidget {
  const Messages({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      //this is a snapshot builder and used to create widget on basis of snapshot it is getting

      //it need a stream parameter which will listen to coming snapshot and create widget according to that.
      //we can create a particular collection snapshot present in firebase database.
      stream: FirebaseFirestore.instance
          .collection("chat")
          .orderBy("createdAt", descending: true)
          .snapshots(),
      builder: (ctx, snapshot) {
        //now StreamBuilder take a have a builder method that give current snapshot of collection on basis of that we can render our widget.
        if (snapshot.connectionState == ConnectionState.waiting) {
          //if there is nothing in snapshot show circular progress bar indicator.
          return Center(
            child: CircularProgressIndicator(),
          );
        }
        final documents = snapshot.data as QuerySnapshot<
            Map<String, dynamic>>; //converting snapshot.data as querySnapshot
        //so we can access the docs which is a list that contains all the documents in which our text message is stored.
        final docs = documents.docs;
        //creating a list view on basis of data we get.
        final user = FirebaseAuth.instance.currentUser;
        return ListView.builder(
          reverse: true,
          itemBuilder: (ctx, index) => Container(
            padding: EdgeInsets.all(10),
            child: MessageBubble(
              docs[index]["text"],
              docs[index]["userId"] == user!.uid,
              docs[index]["username"],
              docs[index]["imageUrl"],
              key: ValueKey(docs[index].id),
            ),
          ),
          itemCount: docs.length,
        );
      },
    );
  }
}

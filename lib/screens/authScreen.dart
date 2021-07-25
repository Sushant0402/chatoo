import 'package:chatoo/widgets/auth/authentication_form.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';

class AuthScreen extends StatefulWidget {
  const AuthScreen({Key? key}) : super(key: key);

  @override
  _AuthScreenState createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  final _auth = FirebaseAuth.instance;
  bool _isLoading = false;

  void _submitAuthForm(
      String email, String userName, String password, bool isLogin, BuildContext ctx, File? image) async {
    var authResult;

    try {
      setState(() {
        _isLoading = true;
      });
      if (isLogin) {
        authResult = await _auth.signInWithEmailAndPassword(
            email: email, password: password);
      } else {
        authResult = await _auth.createUserWithEmailAndPassword(
            email: email, password: password);

        final ref = FirebaseStorage.instance.ref().child("user_image").child(authResult.user.uid+'.jpg');
        //here using firebaseStorage package to upload user image to cloud.
        await ref.putFile(image!).whenComplete(() => {});

        final imageUrl = await ref.getDownloadURL();

        await FirebaseFirestore.instance.collection('users').doc(authResult.user.uid).set({
          "username":userName,
          "email":email,
          "imageUrl": imageUrl,
        });

        print("passed");
      }
      setState(() {
        _isLoading = false;
      });
    } on FirebaseAuthException catch (e) {

      var message = "An error occurred, Please check your credentials";

      if (e.message != null) {
        message = e.message!;
      }

      ScaffoldMessenger.of(ctx).showSnackBar(
        SnackBar(
          content: Text(message),
          backgroundColor: Theme.of(ctx).errorColor,
        ),
      );
      //show an snack bar if error occurred.

      setState(() {
        _isLoading = false;
      });

    } catch (error){
      print(error);

      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Theme.of(context).primaryColor,
        body: AuthForm(_submitAuthForm, _isLoading));
  }
}

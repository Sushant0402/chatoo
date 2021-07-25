import 'package:chatoo/widgets/picker/imagePicker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:io';

class AuthForm extends StatefulWidget {
  final Function submitAuthForm;
  final bool isLoading;
  AuthForm(this.submitAuthForm, this.isLoading);

  @override
  _AuthFormState createState() => _AuthFormState();
}

class _AuthFormState extends State<AuthForm> {
  final _formKey = GlobalKey<FormState>();

  bool _isLoginFrom = true;
  String _userEmail = "";
  String _userName = "";
  String _userPassword = "";
  File? _pickedImage;

  void _pickImage(File pickedImage) {
    _pickedImage = pickedImage;
  }

  void _trySubmit() {
    final isValid = _formKey.currentState!.validate();
    FocusScope.of(context).unfocus(); //this will close any keyboard there.

    if (_pickedImage == null && _isLoginFrom == false) {
      //if we are not in log in form and image is null then show error
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("Please choose an image"),
          backgroundColor: Theme.of(context).errorColor,
        ),
      );
      return;
    }

    if (isValid) {
      _formKey.currentState!.save();
    }
    // print(_userEmail);
    // print(_userName);
    // print(_userPassword);
    print("done");
    print(_isLoginFrom);
    widget.submitAuthForm(_userEmail.trim(), _userName.trim(),
        _userPassword.trim(), _isLoginFrom, context, _pickedImage);
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Card(
        margin: EdgeInsets.all(20),
        child: SingleChildScrollView(
          padding: EdgeInsets.all(16),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisSize:
                  MainAxisSize.min, //column take only child size height
              children: [
                if (!_isLoginFrom) ImagePickerWidget(_pickImage),
                TextFormField(
                  decoration: InputDecoration(
                    labelStyle: TextStyle(color: Color(0xff7368e4)),
                    labelText: "Email",
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Color(0xff7368e4),
                        width: 1,
                      ),
                    ),
                  ),
                  key: ValueKey(
                      "email"), //these key will tell flutter which TextFromField is shown on the screen.
                  validator: (value) {
                    if (value!.isEmpty || !value.contains('@')) {
                      return "Enter a valid email address";
                    }
                    return null;
                  },
                  keyboardType: TextInputType.emailAddress,
                  onSaved: (value) {
                    _userEmail = value!;
                  },
                ),
                SizedBox(
                  height: 5,
                ),
                if (!_isLoginFrom)
                  TextFormField(
                    decoration: InputDecoration(
                      labelText: "Username",
                      labelStyle: TextStyle(color: Color(0xff7368e4)),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Color(0xff7368e4),
                          width: 1,
                        ),
                      ),
                    ),
                    key: ValueKey("username"),
                    validator: (value) {
                      if (value!.isEmpty || value.length <= 4) {
                        return "Enter a name of atleast 5 character long";
                      }
                      return null;
                    },
                    onSaved: (value) {
                      _userName = value!;
                    },
                  ),
                SizedBox(
                  height: 5,
                ),
                TextFormField(
                  key: ValueKey("password"),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "Enter a password";
                    }
                    return null;
                  },
                  obscureText: true,
                  onSaved: (value) {
                    _userPassword = value!;
                  },
                  decoration: InputDecoration(
                    labelStyle: TextStyle(color: Color(0xff7368e4)),
                    labelText: "Password",
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Color(0xff7368e4),
                        width: 1,
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 15,
                ),
                if (widget.isLoading) CircularProgressIndicator(),
                if (!widget.isLoading)
                  ElevatedButton(
                    onPressed: _trySubmit,
                    child: Text(_isLoginFrom ? "Login" : "SignUp"),
                  ),
                SizedBox(
                  height: 10,
                ),
                if (!widget.isLoading)
                  OutlinedButton(
                    onPressed: () {
                      setState(() {
                        _isLoginFrom = !_isLoginFrom;
                      });
                    },
                    child: Text(
                      _isLoginFrom
                          ? "Create an account"
                          : "I already have an account",
                    ),
                  )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

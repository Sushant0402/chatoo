import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

class ImagePickerWidget extends StatefulWidget {
  final Function imagePickFn;

  ImagePickerWidget(this.imagePickFn);

  @override
  _ImagePickerWidgetState createState() => _ImagePickerWidgetState();
}

class _ImagePickerWidgetState extends State<ImagePickerWidget> {

  File ? _pickedImage;
  void _pickImage() async {

    final pickedImageFile = await ImagePicker().pickImage(source: ImageSource.gallery, imageQuality: 50, maxWidth: 150);


    setState(() {
      _pickedImage = File(pickedImageFile!.path);
    });

    widget.imagePickFn(_pickedImage);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CircleAvatar(
          radius: 40,
          backgroundColor: Color(0xff7368e4),
          backgroundImage: _pickedImage == null ? null : FileImage(_pickedImage!),
        ),
        SizedBox(height: 10,),
        OutlinedButton.icon(onPressed: _pickImage, icon: Icon(Icons.camera), label: Text("Choose image"))
      ],
    );
  }
}

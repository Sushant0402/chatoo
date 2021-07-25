import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MessageBubble extends StatelessWidget {
  final String message;
  final bool isMe;
  final Key key;
  final String userName;
  final String imageUrl;
  const MessageBubble(this.message, this.isMe, this.userName, this.imageUrl,
      {required this.key});


  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Row(
          mainAxisAlignment:
              isMe ? MainAxisAlignment.end : MainAxisAlignment.start,
          children: [
            Container(
              constraints: BoxConstraints(
                maxWidth: 240,
              ),
              padding: EdgeInsets.symmetric(
                vertical: 15,
                horizontal: 16,
              ),
              decoration: BoxDecoration(
                color: isMe ? Color(0xff7368e4) : Color(0xffebb5e5),
                borderRadius: BorderRadius.only(
                  topLeft: isMe ? Radius.circular(20) : Radius.circular(0),
                  topRight: isMe ? Radius.circular(0) : Radius.circular(20),
                  bottomLeft: Radius.circular(20),
                  bottomRight: Radius.circular(20),
                ),
              ),
              child: Column(
                crossAxisAlignment:
                    isMe ? CrossAxisAlignment.end : CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      CircleAvatar(
                        radius: 14,
                        backgroundImage: NetworkImage(imageUrl),
                      ),
                      SizedBox(width: 5,),
                      Text(
                        userName,
                        style: TextStyle(
                            color: isMe ? Colors.white : Colors.black,
                            fontSize: 10,
                            fontWeight: FontWeight.w300),
                      ),
                    ],
                  ),
                  SizedBox(height: 3,),
                  Text(
                    message,
                    style: TextStyle(
                        color: isMe ? Colors.white : Colors.black,
                        fontSize: 16),
                  ),
                ],
              ),
            ),
          ],
        ),
      ],
    );
  }
}

import 'package:chat_app/models/message.dart';
import 'package:chat_app/pges/constants.dart';
import 'package:flutter/material.dart';

class ChatBuble extends StatelessWidget {
  const ChatBuble({super.key, required this.message});
  final Message message;
  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Container(
        //alignment: Alignment.centerLeft,
        padding: EdgeInsets.only(left: 16, top: 32, bottom: 32, right: 32),

        margin: EdgeInsets.symmetric(vertical: 15, horizontal: 15),

        //height: 30,width: 40,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(45),
            topRight: Radius.circular(45),
            bottomRight: Radius.circular(45),
          ),
          color: kPrimaryColor,
        ),

        child: Text(message.message, style: TextStyle(color: Colors.white)),
      ),
    );
  }
}

class ChatBubleForFriend extends StatelessWidget {
  const ChatBubleForFriend({super.key, required this.message});
  final Message message;
  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerRight,
      child: Container(
        //alignment: Alignment.centerLeft,
        padding: EdgeInsets.only(left: 16, top: 32, bottom: 32, right: 32),

        margin: EdgeInsets.symmetric(vertical: 15, horizontal: 15),
        //height: 70,width: 155,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(45),
            topRight: Radius.circular(45),
            bottomLeft: Radius.circular(45),
          ),
          color: Color(0xff006D84),
        ),

        child: Text(message.message, style: TextStyle(color: Colors.white)),
      ),
    );
  }
}

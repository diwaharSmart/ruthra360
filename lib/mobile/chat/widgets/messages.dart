import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:hive/hive.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class RoomMessages extends StatefulWidget {
  // const RoomMessages({Key? key}) : super(key: key);
  List message;

  RoomMessages(this.message);
  @override
  State<RoomMessages> createState() => _RoomMessagesState();
}

class _RoomMessagesState extends State<RoomMessages> {
  // List chat = <Message>[Message(text: "6")].reversed.toList();
  // @override
  // void initState() {
  //   super.initState();
  //   print("Init state ran");
  //   setState(() {
  //     final msg = Message(text: "6");
  //     chat.add(msg);
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    print(widget.message);

    return Scaffold(
      backgroundColor: Colors.blueGrey[50],
      body: ListView(),
    );
  }
}

class Message {
  final String text;

  const Message({required this.text});
}

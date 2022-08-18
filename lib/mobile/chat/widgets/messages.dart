import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:hive/hive.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';


class RoomMessages extends StatefulWidget {
  const RoomMessages({Key? key}) : super(key: key);

  @override
  State<RoomMessages> createState() => _RoomMessagesState();
}

class _RoomMessagesState extends State<RoomMessages> {
  @override


  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:Colors.blueGrey[50],
      body: ListView(),
    );
  }
}

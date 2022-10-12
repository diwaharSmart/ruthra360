import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:getwidget/components/toast/gf_toast.dart';
import 'package:getwidget/getwidget.dart';
import 'package:ruthra360/mobile/chat/widgets/chatController.dart';
import 'package:ruthra360/mobile/chat/widgets/messages.dart';
import 'package:ruthra360/mobile/meeting/participants.dart';

class MeetingHistory extends StatefulWidget {
  final meeting;
  const MeetingHistory({Key? key,this.meeting}) : super(key: key);

  @override
  State<MeetingHistory> createState() => _MeetingHistoryState();
}

class _MeetingHistoryState extends State<MeetingHistory> {

  dynamic participant;

  Future getAppUser()
  async
  {
    Box user= await Hive.openBox("user");
    dynamic userId = user.get("user_id");
    List participants = widget.meeting["room_user"];
    final index = participants.indexWhere((element) =>
    element["participant"]["user_id"] == userId);

    setState((){
      participant = participants[index];
    });

  }

  Future startMeeting()
  async
  {
    Box box= await Hive.openBox("meetings");
    dynamic meet = box.get(widget.meeting["room_id"]);


    setState((){
      meet["status"] = "live";
      box.put(widget.meeting["room_id"], meet);

    });


  }

  Future endMeeting()
  async
  {
    Box box= await Hive.openBox("meetings");
    dynamic meet = box.get(widget.meeting["room_id"]);


    setState((){
      meet["status"] = "end";
      box.put(widget.meeting["room_id"], meet);

    });
  }

  Future joinMeeting()
  async
  {

  }

  void initState(){
    super.initState();
    getAppUser();
    // getMeetingData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        leading: IconButton(onPressed: (){Navigator.pop(context);},icon: Icon(Icons.arrow_back_ios,color: Colors.black),),
        title: Text(widget.meeting["title"]??"",style: TextStyle(color: Colors.black),),
        actions: [
          IconButton(onPressed: (){}, icon: Icon(Icons.download_rounded,color: Colors.grey)),
          IconButton(onPressed: (){
            // print(widget.meeting["participants"]);
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => Participants(participants:widget.meeting["room_user"])),
            );
          }, icon: Icon(Icons.group,color: Colors.grey)),
        ],
      ),

      body: Column(
        children: [
          (participant["admin"]==false)?
      Container(
        padding: EdgeInsets.all(8),
        height: kToolbarHeight,color: Colors.white,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Status of the meeting",style: TextStyle(color: Colors.grey,fontWeight: FontWeight.bold,),),
                Text(widget.meeting["status"],style: TextStyle(fontWeight: FontWeight.bold,fontSize: 12)),
              ],
            ),

            (widget.meeting["status"]=="live")?MaterialButton(color: Colors.blueAccent,onPressed: (){},child: Text("Join Meeting",style: TextStyle(color: Colors.white),),):SizedBox(),
          ],
        ),

      ) :
          Container(
            padding: EdgeInsets.all(8),
            height: kToolbarHeight,color: Colors.white,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                (widget.meeting["status"]=="end")?Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Status of the meeting",style: TextStyle(color: Colors.grey,fontWeight: FontWeight.bold,),),
                    Text(widget.meeting["status"],style: TextStyle(fontWeight: FontWeight.bold,fontSize: 12)),
                  ],
                ):SizedBox(),

                (widget.meeting["status"]=="live" || widget.meeting["status"]=="upcoming")? MaterialButton(color: Colors.red,onPressed: (){endMeeting();},child: Text("End Meeting",style: TextStyle(color: Colors.white),),):SizedBox(),
                SizedBox(width: 10,),

                (widget.meeting["status"]!="live" && widget.meeting["status"]!="end")?MaterialButton(color: Colors.green,onPressed: (){startMeeting();},child: Text("Start Meeting",style: TextStyle(color: Colors.white),),):SizedBox(),
                SizedBox(width: 10,),

                (widget.meeting["status"]=="live")?MaterialButton(color: Colors.blueAccent,onPressed: (){joinMeeting();},child: Text("Join Meeting",style: TextStyle(color: Colors.white),),):SizedBox(),


              ],
            ),
          
          ),
          Expanded(child: RoomMessages()),
          ChatController(),
        ],
      ),
    );

  }
}

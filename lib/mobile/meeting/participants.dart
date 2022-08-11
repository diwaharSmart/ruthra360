import 'package:flutter/material.dart';
import 'package:ruthra360/mobile/chat/chat.dart';

class Participants extends StatefulWidget {
  final participants;
  const Participants({Key? key, this.participants}) : super(key: key);

  @override
  State<Participants> createState() => _ParticipantsState();
}

class _ParticipantsState extends State<Participants> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        title: Text("Members (${widget.participants.length})",style: TextStyle(color: Colors.black),),
        leading: IconButton(
          onPressed: (){
            Navigator.pop(context);
          },
          icon: Icon(Icons.arrow_back_ios,color: Colors.black,),
        ),
      ),
      body: ListView.builder(
          itemCount: widget.participants.length,
          itemBuilder: (BuildContext context,int index){
            dynamic p = widget.participants[index];
            dynamic subname =p["participant"]["first_name"].substring(0,2);

           return ListTile(
               title: Row(
                 children: [
                   CircleAvatar(
                     backgroundColor: Colors.blueGrey,
                     child: Text(subname),
                   ),
                   SizedBox(width: 10,),
                   Expanded(
                     child: Column(
                       crossAxisAlignment: CrossAxisAlignment.start,
                       children: [
                         Text('${p["participant"]["first_name"]}',
                           style: TextStyle(fontSize: 13),),
                         Text('${p["participant"]["username"]}',
                           style: TextStyle(fontSize: 11,color: Colors.grey),),
                       ],
                     ),
                   ),
                   (p["admin"]==true)?Text("admin",style: TextStyle(color: Colors.green,fontSize: 12),):SizedBox(),

                 ],
               ),
               onTap: () async {
                 await Navigator.of(context).push(
                     MaterialPageRoute(
                         builder: (_) => ChatScreenMain()));
               }
           );
      }),
    );
  }

}

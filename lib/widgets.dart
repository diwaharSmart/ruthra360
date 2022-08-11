import 'package:flutter/material.dart';
import "dart:math";

import 'package:ruthra360/mobile/status/StatusScreen.dart';

class CreateStatus extends StatefulWidget {
  const CreateStatus({Key? key}) : super(key: key);

  @override
  _CreateStatusState createState() => _CreateStatusState();
}

class _CreateStatusState extends State<CreateStatus> with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: (){
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => StatusScreen()),
        );
      },
      child: Container(

        padding: EdgeInsets.all(10.0),
        width: 90,
        child: Column(
          children: [
            Expanded(
              child: Stack(

                children: const [
                  Center(child: CircleAvatar(radius: 30.0,
                  child: Image(image: NetworkImage("https://cdn.pixabay.com/photo/2016/05/30/14/23/detective-1424831_960_720.png"),fit: BoxFit.contain,),
                  )),
                  Align(alignment: Alignment.bottomRight,child: CircleAvatar(backgroundColor: Colors.yellow,radius: 10,child: Center(child: Icon(Icons.add,size: 14,)),)),
                ],
              ),
            ),
            Container(
              padding: EdgeInsets.all(2),
              child: Text("Your Status",style: TextStyle(fontSize: 9),maxLines: 1,),)
          ],
        ),
      ),
    );
  }
}

class ChatProfile extends StatefulWidget {
  const ChatProfile({Key? key}) : super(key: key);

  @override
  _ChatProfileState createState() => _ChatProfileState();
}

class _ChatProfileState extends State<ChatProfile> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 60,

    // width: MediaQuery.of(context).size.width/4,
      padding: EdgeInsets.only(right: 5.0,left: 5.0),
    child: Stack(
    children: [
      Center(
        child: CircleAvatar(radius: 25.0,
          child: Image(image: NetworkImage("https://cdn.pixabay.com/photo/2019/08/11/18/59/icon-4399701_960_720.png"),fit: BoxFit.cover,),

           ),
      ),
    // Align(alignment: Alignment.bottomLeft,child: CircleAvatar(backgroundColor: Colors.blue,radius: 11,)),
    ],
    ),);
  }
}


class UserStatus extends StatelessWidget {
  final id;
  final name;
  const UserStatus({Key? key , this.id,this.name}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          child: Center(
            child: CircleAvatar(radius: 30.0,

                child:CircleAvatar(radius: 28,backgroundColor: Colors.green,)),
          ),
        ),
        Container(
          padding: EdgeInsets.all(2),
          child: Text(name,style: TextStyle(fontSize: 9),maxLines: 1,),)
      ],
    );
  }
}

class ChatItem extends StatelessWidget {
  const ChatItem({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10),
      height: MediaQuery.of(context).size.height/9,
      // color: Colors.yellow,
      child: Row(
        children: [
          ChatProfile(),
          Expanded(child: Container(
            padding: EdgeInsets.only(left: 8.0,right: 8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Row(


                  children: const [
                    Expanded(child: Text("Dexter Norman",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 15),)),
                    Text("11.12pm",style: TextStyle(fontSize: 11.0,color: Colors.grey),)
                  ],),
                Row(


                  children: [
                    Expanded(child: Text("Hi There I am using Ruthra Meeting App Would you linke to use it",overflow: TextOverflow.ellipsis,style: TextStyle(fontSize: 13),)),
                    Container(child: Icon(Icons.volume_mute,size: 16.0,color: Colors.grey,)),
                    Icon(Icons.push_pin,size: 16.0,color: Colors.grey,),
                  ],)
              ],
            ),
          )
          ),
        ],
      ),
      
    );
  }
}

class GroupChatItem extends StatelessWidget {
  const GroupChatItem({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10),
      height: MediaQuery.of(context).size.height/9,
      // color: Colors.yellow,
      child: Row(
        children: [
          Container(

            // width: MediaQuery.of(context).size.width/4,
            padding: EdgeInsets.only(right: 5.0,left: 5.0),
            child: Stack(
              children: [
                Center(
                  child: CircleAvatar(radius: 25.0,
                  child: Image(image: NetworkImage("https://cdn-icons-png.flaticon.com/512/1256/1256650.png"),fit: BoxFit.cover,),),

                ),

              ],
            ),),
          Expanded(child: Container(
            padding: EdgeInsets.only(left: 8.0,right: 8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Row(


                  children: const [
                    Expanded(child: Text("Bestie Group",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 15),)),
                    Text("11.12pm",style: TextStyle(fontSize: 11.0,color: Colors.grey),)
                  ],),
                Row(


                  children: [
                    Text("Dexter Norman :",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 13),),
                    Expanded(child: Text("Hi There I am using Ruthra Meeting App Would you linke to use it",overflow: TextOverflow.ellipsis,style: TextStyle(fontSize: 13),)),
                    Container(child: Icon(Icons.volume_mute,size: 16.0,color: Colors.grey,)),
                    Icon(Icons.push_pin,size: 16.0,color: Colors.grey,),
                  ],)
              ],
            ),
          )
          ),
        ],
      ),

    );
  }
}



class LiveIndicator extends StatefulWidget {
  @override
  _LiveIndicatorState createState() => _LiveIndicatorState();
}

class _LiveIndicatorState extends State<LiveIndicator>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;

  @override
  void initState() {
    _animationController =
    new AnimationController(vsync: this, duration: Duration(seconds: 1));
    _animationController.repeat(reverse: true);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return FadeTransition(
      opacity: _animationController,
      child: Row(
        children: [
          CircleAvatar(
            radius: 5.0,
            backgroundColor: Colors.green,
          ),
          SizedBox(width: 5.0,),
          Container(
            child: Text("Live",style: TextStyle(color: Colors.green),),
          ),
          SizedBox(width: 5.0,),
        ],
      )
    );
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }
}

class UpcomingIndicator extends StatefulWidget {
  @override
  _UpcomingIndicatorState createState() => _UpcomingIndicatorState();
}

class _UpcomingIndicatorState extends State<UpcomingIndicator>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;

  @override
  void initState() {
    _animationController =
    new AnimationController(vsync: this, duration: Duration(seconds: 1));
    _animationController.repeat(reverse: true);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        CircleAvatar(
          radius: 5.0,
          backgroundColor: Colors.yellow,
        ),
        SizedBox(width: 5.0,),
        Container(
          child: Text("Upcoming",style: TextStyle(color: Colors.yellow),),
        ),
        SizedBox(width: 5.0,),
      ],
    );
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }
}


class EndIndicator extends StatefulWidget {
  @override
  _EndIndicatorState createState() => _EndIndicatorState();
}

class _EndIndicatorState extends State<EndIndicator>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;

  @override
  void initState() {
    _animationController =
    new AnimationController(vsync: this, duration: Duration(seconds: 1));
    _animationController.repeat(reverse: true);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        CircleAvatar(
          radius: 5.0,
          backgroundColor: Colors.red,
        ),
        SizedBox(width: 5.0,),
        Container(
          child: Text("Ended",style: TextStyle(color: Colors.red),),
        ),
        SizedBox(width: 5.0,),
      ],
    );
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }
}




class CallLogItem extends StatefulWidget {
  const CallLogItem({Key? key}) : super(key: key);

  @override
  _CallLogItemState createState() => _CallLogItemState();
}

class _CallLogItemState extends State<CallLogItem> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10),
      height: MediaQuery.of(context).size.height/9,
      // color: Colors.yellow,
      child: Row(
        children: [
          Container(

            // width: MediaQuery.of(context).size.width/4,
            padding: EdgeInsets.only(right: 5.0,left: 5.0),
            child: Stack(
              children: [
                Center(
                  child: CircleAvatar(radius: 25.0,
              child: Image(image: NetworkImage("https://cdn.pixabay.com/photo/2019/08/11/18/59/icon-4399701_960_720.png"),fit: BoxFit.cover,),
                  ),
                ),

              ],
            ),),
          Expanded(child: Container(
            padding: EdgeInsets.only(left: 8.0,right: 8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Row(


                  children: const [
                    Expanded(child: Text("My Colik",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 15),)),

                  ],),
                Row(


                  children: [




                    Expanded(child: Row(

                      children:  [
                        Icon(Icons.call_missed,color: Colors.red,),
                        SizedBox(width: 5.0,),
                        Text("23.01 PM",style: TextStyle(fontSize: 13),)
                      ],
                    )),


                  ],)
              ],
            ),
          )
          ),
          Container(
              width: 40.0,
            child: Center(child: Icon(Icons.call,color: Colors.blueGrey,),),
              )
        ],
      ),

    );
  }
}



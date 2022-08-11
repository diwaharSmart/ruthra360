import 'dart:async';

import 'package:flutter/material.dart';
import 'package:ruthra360/mobile/meeting/meetingHistory.dart';
import 'package:ruthra360/widgets.dart';
import 'package:hive/hive.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:getwidget/components/toast/gf_toast.dart';
import 'package:getwidget/getwidget.dart';

class MeetingList extends StatefulWidget {
  const MeetingList({Key? key}) : super(key: key);

  @override
  _MeetingListState createState() => _MeetingListState();
}

class _MeetingListState extends State<MeetingList> {
  bool _menu = false;
  dynamic _selectedIndex =[];
  dynamic item = [];
  dynamic selectedItem = [];

  @override

  Future _loadMeetings() async{
    Box box = await Hive.openBox('meetings');
    setState(() => item = box.values.toList());
  }

  fetchData()async{
    Box box = await Hive.openBox('meetings');
    Box user = await Hive.openBox('user');
    final response = await http.get(
      Uri.parse('http://217.21.78.14:8000/mz_rm/room/?room_type=meeting'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'token ${user.get("token")}'
      },
    );
    if(response.statusCode == 200){
      // print(response.body);

      dynamic data = jsonDecode(response.body);
      for(dynamic a in data) {
        box.put(a["room_id"], a);
      }
      setState(() => item = box.values.toList());
    }

    else{
      GFToast.showToast(response.statusCode.toString(), context,toastPosition: GFToastPosition.BOTTOM);


    }
  }

  @override
  void initState() {
    super.initState();
    _loadMeetings();
    fetchData();

  }



  Widget build(BuildContext context) {

    return Scaffold(
      body: Stack(
        children: [
          Container(
            color: Colors.blueGrey[50],
            child: Column(
              children: [
                (_menu == true )? ToolBar(selectedItem.length): Container(),
                Container(
                  color: Colors.white,
                  padding: EdgeInsets.all(8),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Join a Meeting",style: TextStyle(color: Colors.grey),),
                      SizedBox(height: 5,),
                      Row(
                        children: [
                          Expanded(child: TextField(
                            decoration: InputDecoration(
                              hintText: 'Enter the meeting code',
                              border: new OutlineInputBorder(
                                borderRadius: const BorderRadius.all(
                                  const Radius.circular(0.0),
                                ),
                                borderSide: new BorderSide(
                                  color: Colors.black,
                                  width: 1.0,
                                ),
                              ),
                            ),
                          )),
                          SizedBox(width: 10,),
                          FloatingActionButton(
                            heroTag: "btn2",
                            backgroundColor: Colors.redAccent,onPressed: (){
                            GFToast.showToast("Coming Soon", context,toastPosition: GFToastPosition.BOTTOM);
                          },child: Icon(Icons.navigate_next),)
                        ],
                      ),
                    ],
                  ),
                ),
                (item.length==0)?Expanded(child: Center(child: Text("No Meetings Available"),),):
                Expanded(child: ListView.builder(

                  itemCount: item.length,
                  itemBuilder: (BuildContext context,int index){
                    return InkWell(
                      onTap: (){
                        if(_menu == true){
                          if(selectedItem.contains(item[index]["id"])){
                            setState(() {
                              selectedItem.remove(item[index]["id"]);
                            });

                          }
                          else {
                            setState(() {
                              selectedItem.add(item[index]["id"]);
                            });
                          }
                        }
                        else{
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => MeetingHistory(meeting:item[index])),
                          );
                        }
                      },
                      onLongPress: (){
                        setState(() {

                          if(_menu ==true){

                          }
                          else{
                            selectedItem.add(item[index]["id"]);
                            _menu = true;
                          }
                        });
                      },child: Container(
                        color: (selectedItem.contains(item[index]["id"]))?Colors.grey[300]:Colors.transparent,
                        child: MeetingItem(title: item[index]["title"],participants: item[index]["room_user"],status: item[index]["status"],)
                    ),);
                  },


                ))
              ],
            ),
          ),


        ],
      ),
      floatingActionButton: FloatingActionButton(
        heroTag: "btn1",
        onPressed: (){
        Navigator.pushNamed(context, "create_meeting");
      },child: Icon(Icons.add),),
    );
  }
  Widget ToolBar(c){
    return Container(
      height: 50,
      color: Colors.blue,
      child: Row(
        children: [
          Expanded(child: Row(
            children: [
              IconButton(onPressed: (){
                setState(() {
                  selectedItem.clear();
                  _menu=false;
                });
              }, icon: Icon(Icons.close,color: Colors.white60)),
              Center(child: Text("${c}",style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold,color: Colors.white60),),)
            ],
          )),
          IconButton(onPressed: (){}, icon: Icon(Icons.archive,color: Colors.white60)),
          // IconButton(onPressed: (){}, icon: Icon(Icons.volume_mute,color: Colors.white60)),
          IconButton(onPressed: (){}, icon: Icon(Icons.push_pin,color: Colors.white60)),
          IconButton(onPressed: (){

            for(int i=0;i<selectedItem.length;i++){
              setState(() {
                item.removeWhere((item) => item["id"] == selectedItem[i]);


              });
            }
            setState(() {
              selectedItem.clear();
            });

          }, icon: Icon(Icons.delete,color: Colors.white60,)),



        ],
      ),
    );
  }
}

class MeetingItem extends StatelessWidget {
  final title;
  final status;
  final participants;
  const MeetingItem({Key? key,this.title,this.status,this.participants}) : super(key: key);




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
                    child: Image(image: NetworkImage("https://cdn-icons-png.flaticon.com/512/3214/3214781.png"),fit: BoxFit.cover,),
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


                  children:  [
                    Expanded(child: Text(title,style: TextStyle(fontWeight: FontWeight.bold,fontSize: 15),)),

                  ],),
                Row(


                  children: [
                    (status=='end')?EndIndicator():SizedBox(),
                    (status=='live')?LiveIndicator():SizedBox(),
                    (status=='upcoming')?UpcomingIndicator():SizedBox(),

                    Expanded(child: Text("${participants.length} members.",overflow: TextOverflow.ellipsis,style: TextStyle(fontSize: 13),)),


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
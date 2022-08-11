import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:getwidget/components/toast/gf_toast.dart';
import 'package:getwidget/getwidget.dart';
import 'package:get/get.dart';

class CreateMeeting extends StatefulWidget {
  const CreateMeeting({Key? key}) : super(key: key);

  @override
  State<CreateMeeting> createState() => _CreateMeetingState();
}

class _CreateMeetingState extends State<CreateMeeting> {
  List _contacts = [];
  List _selectedContacts = [];
  List _updatedContacts = [];
  TextEditingController controller= new TextEditingController();
  Future _loadContacts() async{
    List c = [];
    Box box = await Hive.openBox('contacts');
    setState(() => _contacts = box.values.toList());
  }

  void initState(){
    super.initState();
    _loadContacts();
  }

  createMeeting()
  async{
    Box user = await Hive.openBox('user');
    Box box = await Hive.openBox('meetings');
    for(dynamic c in _selectedContacts){
      _updatedContacts.add(
        {
          "user_id": c,
          "admin":false,
          "recieved":false
        }
      );
    }
    _updatedContacts.add({
      "user_id": user.get("user_id"),
      "admin":true,
      "recieved":true
    });

    final response = await http.post(
      Uri.parse('http://217.21.78.14:8000/mz_rm/room/'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authrorization': 'token ${user.get("token")}'
      },
      body: jsonEncode(<dynamic, dynamic>{
        "title":controller.text,
        "participants": _updatedContacts,
        "status":"upcoming",
        "image":null,
        "description":"",
        "group":false,
        "meeting":true,
        "private":false,
      }),
    );
    if(response.statusCode == 200){
      // print(response.body);
      GFToast.showToast("Meeting Created", context,toastPosition: GFToastPosition.BOTTOM);
      dynamic data = jsonDecode(response.body);
      box.put(data["room_id"], data);
      Get.back();
    }

    else{
      GFToast.showToast(response.statusCode.toString(), context);


    }


  }

  addOrRemoveParticipant(index){
    dynamic contact = _contacts[index];

    if(_selectedContacts.contains(contact["user_id"])){

      _selectedContacts.removeWhere((item) => item == contact["user_id"],);
    }
    else{
      _selectedContacts.add(contact["user_id"]);
    }
    setState((){});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        title: Text("Create New Meeting",style: TextStyle(color: Colors.black),),
        leading: IconButton(
          color: Colors.black,
          onPressed: (){
          Navigator.pop(context);
        },
        icon: Icon(Icons.close),
      ),),
          body: Container(
        child: Column(
          children: [
            Container(
              color: Colors.white,
              padding: EdgeInsets.all(8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Meeting Name",style: TextStyle(color: Colors.grey),),
                  SizedBox(height: 5,),
                  TextField(
                    controller: controller,
                    decoration: InputDecoration(
                      hintText: 'Enter the meeting name',
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
                  )
                ],
              ),
            ),
            SizedBox(height: 10,),
            Container(
              width: MediaQuery.of(context).size.width,

              padding: EdgeInsets.all(8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Select Participants",style: TextStyle(color: Colors.grey),),
                  SizedBox(height: 5,),



                ],
              ),
            ),
            (_contacts.length==0)?Container(padding: EdgeInsets.all(18),child: Center(child: Text("No Participants Available")),):
            Expanded(child: ListView.builder(

                itemCount: _contacts.length,
                itemBuilder: (context, i) {

                  return ParticipantItem(i,_contacts[i]["first_name"].substring(0,2),_contacts[i]["first_name"],_contacts[i]["username"]);
                }
            )),

            Container(
              padding: EdgeInsets.all(8),
              color: Colors.white,
              child: Row(
                children: [
                  Expanded(child: Container()),
                  RaisedButton(
                    color: Colors.redAccent,
                    onPressed: (){
                      createMeeting();

                    },child: Text("Create",style: TextStyle(color: Colors.white),),
                  )
                ],
              ),
            )


          ],
        ),
    ),

    );
  }

  Widget ParticipantItem(index,subname,first_name,username){
    return InkWell(
      onTap: (){
        addOrRemoveParticipant(index);

      },
      child: ListTile(
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
                    Text('${first_name}',
                      style: TextStyle(fontSize: 13),),
                    Text('${username}',
                      style: TextStyle(fontSize: 11,color: Colors.grey),),
                  ],
                ),
              ),
              (_selectedContacts.contains(_contacts[index]["user_id"]))?IconButton(onPressed: (){}, icon: Icon(Icons.check,color: Colors.green,)):Container(),



            ],
          ),

      ),
    );

  }
}
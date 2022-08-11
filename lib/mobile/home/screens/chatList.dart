import 'package:flutter/material.dart';
import 'package:ruthra360/mobile/chat/chat.dart';
import 'package:ruthra360/mobile/contact/contact_list.dart';
import 'package:ruthra360/mobile/home/screens/stories.dart';
import 'package:ruthra360/widgets.dart';

class ChatList extends StatefulWidget {
  const ChatList({Key? key}) : super(key: key);

  @override
  _ChatListState createState() => _ChatListState();
}

class _ChatListState extends State<ChatList> {
  @override
  bool _menu = false;
  dynamic _selectedIndex =[];
  dynamic item = [{'id':1}];
  dynamic selectedItem = [];

  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            color: Colors.blueGrey[50],
            child: Column(
              children: [
                Container(
                  // padding: EdgeInsets.only(left: 10.0),
                  height: 100,

                  decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border(bottom: BorderSide(color: Colors.black12)),
                  ),
                  child: StatusBar(),

                ),
                (_menu == true )? ToolBar(selectedItem.length): Container(),
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
                              MaterialPageRoute(builder: (context) => const ChatScreenMain()),
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
                          child: ChatItem()
                      ),);
                  },


                ))
              ],
            ),
          ),



        ],
      ),
      floatingActionButton: FloatingActionButton(onPressed: (){
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => FlutterContactsExample()),
        );
      },child: Icon(Icons.message),),
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


class StatusBar extends StatefulWidget {
  const StatusBar({Key? key}) : super(key: key);

  @override
  _StatusBarState createState() => _StatusBarState();
}

class _StatusBarState extends State<StatusBar> {
  @override
  Widget build(BuildContext context) {
    return Container(

      child: Row(
        children: [
          CreateStatus(),
          SizedBox(width: 15.0,),
          Expanded(child:

          ListView(
            scrollDirection: Axis.horizontal,
            children:  [
              InkWell(
                onTap: (){
                  Navigator.of(context).push(
                      MaterialPageRoute(builder: (context) => MoreStories()));
                },
                child: UserStatus(id:"1",name: "Merzol",),
              ),
    

            ],
          )
          )
        ],

      ),
    );

  }

}

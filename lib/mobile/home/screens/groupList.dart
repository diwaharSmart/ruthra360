import 'package:flutter/material.dart';
import 'package:ruthra360/mobile/chat/chat.dart';
import 'package:ruthra360/widgets.dart';

class GroupList extends StatefulWidget {
  const GroupList({Key? key}) : super(key: key);

  @override
  _GroupListState createState() => _GroupListState();
}

class _GroupListState extends State<GroupList> {
  bool _menu = false;
  dynamic _selectedIndex =[];
  dynamic item = [{'id':1}];
  dynamic selectedItem = [];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            color: Colors.blueGrey[50],
            child: Column(
              children: [
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
                          Navigator.of(context).push(
                              MaterialPageRoute(builder: (_) =>ChatScreenMain()));
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
                        child: GroupChatItem()
                    ),);
                  },


                ))
              ],
            ),
          ),



        ],
      ),
      floatingActionButton: FloatingActionButton(onPressed: (){},child: Icon(Icons.add),),
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
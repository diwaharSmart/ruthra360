import 'package:flutter/material.dart';
import 'package:ruthra360/mobile/contact/contact_list.dart';
import 'package:ruthra360/widgets.dart';

class CallList extends StatefulWidget {
  const CallList({Key? key}) : super(key: key);

  @override
  _CallListState createState() => _CallListState();
}

class _CallListState extends State<CallList> {
  @override
  bool _menu = false;
  dynamic _selectedIndex =[];
  dynamic item = [{'id':1},{'id':2},{'id':3},{'id':4},{'id':5}];
  dynamic selectedItem = [];


  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      body: Stack(
        children: [

          Column(
            children: [
              (_menu==true)?ToolBar(selectedItem.length):SizedBox(),
              Expanded(
                child: Container(
                  height: MediaQuery.of(context).size.height,
                  width: MediaQuery.of(context).size.width,
                  child:  Container(
                    color: Colors.grey[100],
                    child: Column(
                      children: [
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
                                child: CallLogItem()),);
                          },


                        ))
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),

        ],
      ),
      floatingActionButton: FloatingActionButton(onPressed: (){
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => FlutterContactsExample()),
        );
      },child: Icon(Icons.add_ic_call_rounded,),),
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
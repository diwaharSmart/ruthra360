import 'package:flutter/material.dart';
import 'package:extended_text_field/extended_text_field.dart';

class ChatController extends StatefulWidget {
  const ChatController({Key? key}) : super(key: key);

  @override
  State<ChatController> createState() => _ChatControllerState();
}

class _ChatControllerState extends State<ChatController> {
  bool isTyping = false;
  bool attachment = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(5),
      color: Colors.grey[100],
      child: Column(
        children: [
          (attachment==true)?Container(height: 100,
            color: Colors.grey[200],
            child: ListView(
              scrollDirection: Axis.horizontal,
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    InkWell(child:
                      CircleAvatar(radius: 30,
                        backgroundColor: Colors.orange[200],
                        child: Icon(Icons.image,color: Colors.white,),
                      )
                    ),
                    Text("Image",style: TextStyle(color: Colors.grey,fontSize: 12),)
                  ],
                ),
                SizedBox(width: 20,),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    InkWell(child:
                      CircleAvatar(radius: 30,
                        backgroundColor: Colors.green[200],
                        child: Icon(Icons.audiotrack,color: Colors.white,),
                      )
                    ),
                    Text("Audio",style: TextStyle(color: Colors.grey,fontSize: 12),)
                  ],
                ),
                SizedBox(width: 20,),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    InkWell(child:
                      CircleAvatar(
                        radius: 30,
                        backgroundColor: Colors.purple[200],
                        child: Icon(Icons.video_call,color: Colors.white,),
                      )
                    ),
                    Text("Video",style: TextStyle(color: Colors.grey,fontSize: 12),)
                  ],
                ),
                SizedBox(width: 20,),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    InkWell(
                        child: CircleAvatar(
                          radius: 30,
                          backgroundColor: Colors.yellow[200],
                          child: Icon(Icons.file_present,color: Colors.white,),
                        )
                    ),
                    Text("Document",style: TextStyle(color: Colors.grey,fontSize: 12),)
                  ],
                ),
                SizedBox(width: 20,),
              ],
            ),
          ):SizedBox(),

          Row(
            children: <Widget>[

              Expanded(child:CustomTextFeld()),
              IconButton(onPressed: (){
                if(attachment==true){
                  setState((){
                    attachment=false;
                  });
                }
                else{
                  setState((){
                    attachment=true;
                  });
                }
              },icon:Icon(Icons.attach_file,color: (attachment==true)?Colors.black:Colors.grey,)),

              IconButton(onPressed: (){
              },icon:Icon(Icons.security,color: Colors.grey)),

              (isTyping)?sendButton():
              audioRecordButton(),
            ],
          ),
        ],
      )
    );
  }



  Widget CustomTextFeld(){
    return Container(
      constraints: BoxConstraints(maxHeight: 150),
      child: TextField(
        onChanged: (val){

        },
        style: TextStyle(fontSize: 18.0),
        // controller: textFieldController,
        decoration: InputDecoration(
          border: InputBorder.none,

            hintStyle: TextStyle(color: Colors.grey[800]),
            hintText: "Type here",

            fillColor: Colors.white
        ),
        keyboardType: TextInputType.multiline,
        maxLines: null,



      ),
    );
  }
  Widget audioRecordButton(){
    return Padding(
      padding: const EdgeInsets.only(left: 10),
      child: ClipOval(

        child: Material(

          color: Colors.red, // button color
          child: InkWell(

            splashColor: Colors.red, // inkwell color
            child: const SizedBox(width: 50, height: 50, child: Icon(Icons.mic,color: Colors.white,)),
            onTap: () {

            },
          ),
        ),
      ),
    );

  }


  Widget sendButton(){
    return Padding(
      padding: const EdgeInsets.only(left: 10),
      child: ClipOval(

        child: Material(

          color: Colors.red, // button color
          child: InkWell(

            splashColor: Colors.red, // inkwell color
            child: const SizedBox(width: 50, height: 50, child: Icon(Icons.send,color: Colors.white,)),
            onTap: () {

            },
          ),
        ),
      ),
    );
  }

  Widget Upload(){
    return Container(
      height: 300,
      color: Colors.grey[100],
      child: ListView(
        children: [
          Container(height: 70,child: InkWell(child: Row(children: [
            IconButton(onPressed: (){}, icon: Icon(Icons.image)),
            Expanded(child: Text("Image"))
          ],),),),
          Container(height: 70,child: InkWell(child: Row(children: [
            IconButton(onPressed: (){}, icon: Icon(Icons.videocam)),
            Expanded(child: Text("Video"))
          ],),),),
          Container(height: 70,child: InkWell(child: Row(children: [
            IconButton(onPressed: (){}, icon: Icon(Icons.audiotrack)),
            Expanded(child: Text("Audio"))
          ],),),),
          Container(height: 70,child: InkWell(child: Row(children: [
            IconButton(onPressed: (){}, icon: Icon(Icons.file_present)),
            Expanded(child: Text("Document"))
          ],),),),

        ],

      ),
    );
  }
}

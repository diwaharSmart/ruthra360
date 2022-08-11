import 'package:flutter/material.dart';

import 'package:ruthra360/mobile/home/screens/chatList.dart';
import 'package:ruthra360/mobile/home/screens/groupList.dart';
import 'package:ruthra360/mobile/home/screens/meetlingList.dart';
import 'package:ruthra360/mobile/home/screens/callLog.dart';



class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override


  // final GlobalKey<FabCircularMenuState> fabKey = GlobalKey();


  Widget build(BuildContext context) {

    return Stack(
      children: [

        DefaultTabController(initialIndex: 1,length: 4, child: Scaffold(
          appBar: AppBar(title: Text("Merzol"),
            actions: [
              IconButton(onPressed: (){}, icon: Icon(Icons.search),splashRadius: 20.0,),
              IconButton(onPressed: (){}, icon: Icon(Icons.more_vert),splashRadius: 20.0,),
            ],
            bottom:  const TabBar(
              indicatorColor: Colors.white,

              isScrollable: true,

              tabs: <Widget>[
                // Tab(icon: Icon(Icons.camera_alt) ,),
                Tab(text: 'Chats',),
                Tab(text: 'Groups',),
                Tab(text: 'Meeting',),
                Tab(text: 'Call'),

              ],
            ),


          ),
          body:  Stack(
            children: [
              TabBarView(

                children: [
                  // Scaffold(body: Container(color: Colors.yellow,height: MediaQuery.of(context).size.height,width: MediaQuery.of(context).size.width,),),
                  // cameraload(camera:widget.camera),
                  // Container(),
                  ChatList(),
                  GroupList(),
                  MeetingList(),
                  CallList(),
                ],
              ),
            ],
          ),
          // floatingActionButton: Builder(
          //   builder: (context) => FabCircularMenu(
          //     key: fabKey,
          //     // Cannot be `Alignment.center`
          //     alignment: Alignment.bottomRight,
          //     ringColor: Colors.white.withAlpha(25),
          //     ringDiameter: 450.0,
          //     ringWidth: 150.0,
          //     fabSize: 64.0,
          //     fabElevation: 8.0,
          //     fabIconBorder: CircleBorder(),
          //     // Also can use specific color based on wether
          //     // the menu is open or not:
          //     // fabOpenColor: Colors.white
          //     // fabCloseColor: Colors.white
          //     // These properties take precedence over fabColor
          //     fabColor: Colors.white,
          //     fabOpenIcon: Icon(Icons.add),
          //     fabCloseIcon: Icon(Icons.close),
          //     fabMargin: const EdgeInsets.all(16.0),
          //     animationDuration: const Duration(milliseconds: 800),
          //     animationCurve: Curves.easeInOutCirc,
          //     onDisplayChange: (isOpen) {
          //
          //     },
          //     children: <Widget>[
          //       RawMaterialButton(
          //         fillColor: Colors.red,
          //         onPressed: () {
          //
          //         },
          //         shape: CircleBorder(),
          //         padding: const EdgeInsets.all(22.0),
          //         child: Icon(Icons.video_call, color: Colors.white),
          //       ),
          //       RawMaterialButton(
          //         fillColor: Colors.red,
          //         onPressed: () {
          //
          //         },
          //         shape: CircleBorder(),
          //         padding: const EdgeInsets.all(22.0),
          //         child: Icon(Icons.group_add, color: Colors.white),
          //       ),
          //       RawMaterialButton(
          //         fillColor: Colors.red,
          //         onPressed: () {
          //
          //         },
          //         shape: CircleBorder(),
          //         padding: const EdgeInsets.all(22.0),
          //         child: Icon(Icons.add_call, color: Colors.white),
          //       ),
          //       RawMaterialButton(
          //         fillColor: Colors.red,
          //         onPressed: () {
          //
          //         },
          //         shape: CircleBorder(),
          //         padding: const EdgeInsets.all(22.0),
          //         child: Icon(Icons.message, color: Colors.white),
          //       ),
          //     ],
          //   ),
          // ),
        )),
        // SearchBar(),


      ],
    );
  }

  Widget SearchBar()  {
    return Align(
      alignment: Alignment.topCenter,
      child: Scaffold(
        body: Container(color: Colors.white,
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).padding.top + kToolbarHeight,
          child: Column(
            children: [
              Container(height: MediaQuery.of(context).padding.top,),
              Container(
                color: Colors.white,

                child: Text("hello"),
              ),

            ],
          ),
        ),
      ),
    );
  }
  void _showSnackBar(BuildContext context, String message) {
    Scaffold.of(context).showSnackBar(
        SnackBar(
          content: Text(message),
          duration: const Duration(milliseconds: 1000),
        )
    );
  }
}




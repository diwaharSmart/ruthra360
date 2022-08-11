import 'package:getwidget/getwidget.dart';
import 'package:flutter/material.dart';
import 'dart:async';
import 'package:line_icons/line_icons.dart';
import 'package:ruthra360/mobile/home/screens/callLog.dart';
import 'package:ruthra360/mobile/home/screens/chatList.dart';
import 'package:ruthra360/mobile/home/screens/groupList.dart';
import 'package:ruthra360/mobile/home/screens/meetlingList.dart';
import 'package:ruthra360/mobile/setting/settingScreen.dart';


class HomeIndex extends StatefulWidget {
  const HomeIndex({Key? key}) : super(key: key);

  @override
  _HomeIndexState createState() => _HomeIndexState();
}

class _HomeIndexState extends State<HomeIndex> with SingleTickerProviderStateMixin {
  late TabController tabController;

  @override
  void initState() {
    super.initState();
    tabController = TabController(length: 4, vsync: this);
    setState(() {
      tabController.index=0;
    });

  }


  @override
  void dispose() {
    tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey,
      appBar: GFAppBar(
        title: const Text('MERZOL',style: TextStyle(color: Colors.redAccent,fontWeight: FontWeight.bold,fontSize: 20,fontFamily: "ACK",),),

        backgroundColor: Colors.white,
        elevation: 0,
        actions: [
          IconButton(onPressed: (){}, icon: Icon(Icons.search_rounded,color: Colors.black,)),
          IconButton(onPressed: (){
            Navigator.of(context).push(
                MaterialPageRoute(builder: (context) => SettingsScreen()));
          }, icon: Icon(Icons.more_vert,color: Colors.black,)),

        ],

      ),
      body: GFTabBarView(controller: tabController, children: <Widget>[
        // Container(color: Colors.green),
        MeetingList(),
        ChatList(),
        GroupList(),
        CallList()
      ]),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(

        ),
        child: GFTabBar(
          tabBarColor: Colors.white,
          tabBarHeight: 50,
          length: 4,
          controller: tabController,
          unselectedLabelColor: Colors.black,
          labelColor: Colors.grey,
          indicatorColor: Colors.white,

          tabs: [
            Tab(
              icon: ImageIcon(
              AssetImage("assets/MERZOL2.png"),
                color: Colors.redAccent,
              ),

            ),

            Tab(
              icon: Icon(Icons.message,),

            ),

            Tab(
              icon: Icon(Icons.group),

            ),
            Tab(
              icon: Icon(Icons.call,),

            ),
          ],
        ),
      ),
    );
  }
}

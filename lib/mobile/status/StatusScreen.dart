import 'package:flutter/material.dart';
import 'package:ruthra360/mobile/status/storyView.dart';
import 'package:getwidget/getwidget.dart';

class StatusScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: GFAppBar(
        leading: IconButton(onPressed: (){
          Navigator.pop(context);
        }, icon: Icon(Icons.arrow_back_ios,color: Colors.black,)),
        title: const Text('Your Status',style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold,fontSize: 18),),
        backgroundColor: Colors.white,
        elevation: 0,
        actions: [

          IconButton(onPressed: (){}, icon: Icon(Icons.more_vert,color: Colors.black,)),

        ],
        // bottom: PreferredSize(
        //     child: Container(
        //       color: Colors.grey[350],
        //       height: 1.0,
        //     ),
        //     preferredSize: Size.fromHeight(4.0)),

      ),
      body: Container(
        color: Color(0xfff2f2f2),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Card(
              color: Colors.white,
              elevation: 0.0,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: ListTile(
                  leading: Stack(
                    children: <Widget>[
                      CircleAvatar(
                        radius: 30,
                        backgroundImage: NetworkImage(
                            "https://s3.amazonaws.com/wll-community-production/images/no-avatar.png"),
                      ),
                      Positioned(
                        bottom: 0.0,
                        right: 1.0,
                        child: Container(
                          height: 20,
                          width: 20,
                          child: Icon(
                            Icons.add,
                            color: Colors.white,
                            size: 15,
                          ),
                          decoration: BoxDecoration(
                            color: Colors.blueGrey,
                            shape: BoxShape.circle,
                          ),
                        ),
                      )
                    ],
                  ),
                  title: Text(
                    "My Status",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  subtitle: Text("Tap to add status update"),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                "Viewed updates",
                style: TextStyle(color: Colors.grey, fontWeight: FontWeight.bold),
              ),
            ),
            Expanded(
              child: Container(
                padding: const EdgeInsets.all(8.0),
                color: Colors.white,
                child: ListView(
                  children: <Widget>[
                    ListTile(
                      leading: CircleAvatar(
                        radius: 30,
                        backgroundImage: NetworkImage(
                            "https://pbs.twimg.com/media/EClDvMXU4AAw_lt?format=jpg&name=medium"),
                      ),
                      title: Text(
                        "Pawan Kumar",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      subtitle: Text("Today, 20:16 PM"),
                      onTap: () => Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => StoryPageView())),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(onPressed: (){

      },child: Icon(Icons.edit,),),
    );
  }
}
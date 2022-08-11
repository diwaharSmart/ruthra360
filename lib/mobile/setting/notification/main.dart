import 'package:flutter/material.dart';
import 'package:getwidget/getwidget.dart';

class NotificationScreen extends StatefulWidget {
  const NotificationScreen({Key? key}) : super(key: key);

  @override
  _NotificationScreenState createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: GFAppBar(
        leading: IconButton(onPressed: (){
          Navigator.pop(context);
        }, icon: Icon(Icons.arrow_back_ios,color: Colors.black,)),
        title: const Text('Notification',style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold,fontSize: 18),),
        backgroundColor: Colors.white,
        elevation: 0,

        // bottom: PreferredSize(
        //     child: Container(
        //       color: Colors.grey[350],
        //       height: 1.0,
        //     ),
        //     preferredSize: Size.fromHeight(4.0)),

      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 18.0,right: 18,top: 10,bottom: 10),
              child: Text("Message",style: TextStyle(color: Colors.grey),),
            ),
            custom_item({"title":"Notification Tone", "selected":"tone_001"}),
            custom_item({"title":"Vibrate", "selected":"Default"}),
            custom_item({"title":"Popup", "selected":"No Popup"}),
            custom_item({"title":"Light", "selected":"White"}),
            Padding(
              padding: const EdgeInsets.only(left: 18.0,right: 18,top: 10,bottom: 10),
              child: Text("Groups",style: TextStyle(color: Colors.grey),),
            ),
            custom_item({"title":"Notification Tone", "selected":"tone_001"}),
            custom_item({"title":"Vibrate", "selected":"Default"}),
            custom_item({"title":"Popup", "selected":"No Popup"}),
            custom_item({"title":"Light", "selected":"White"}),
            Padding(
              padding: const EdgeInsets.only(left: 18.0,right: 18,top: 10,bottom: 10),
              child: Text("Calls",style: TextStyle(color: Colors.grey),),
            ),
            custom_item({"title":"Ringtone", "selected":"tone_001"}),
            custom_item({"title":"Vibrate", "selected":"Default"}),



          ],
        ),
      ),
    );
  }
  Widget item(data){
    return Container(
      padding: EdgeInsets.only(left: 18,right: 18,top: 10,bottom: 10),
      height: 70,
      child: Row(

        children: [
          IconButton(onPressed: (){}, icon: Icon(data["icon"],color: Colors.grey,)),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(data["title"],style: TextStyle(fontWeight: FontWeight.bold,fontSize: 15),),
                Text(data["selected"],style: TextStyle(color: Colors.grey),),
              ],
            ),
          ),
        ],
      ),
    );
  }
  Widget single_line_item(data){
    return Container(
      padding: EdgeInsets.only(left: 18,right: 18,top: 10,bottom: 10),
      height: 70,
      child: Row(

        children: [
          IconButton(onPressed: (){}, icon: Icon(data["icon"],color: Colors.grey,)),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(data["title"],style: TextStyle(fontWeight: FontWeight.bold,fontSize: 15),),

              ],
            ),
          ),
        ],
      ),
    );
  }
  Widget custom_item(data){
    return Container(
      padding: EdgeInsets.only(left: 18,right: 18,top: 10,bottom: 10),
      height: 70,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(data["title"],style: TextStyle(fontWeight: FontWeight.bold,fontSize: 15),),
          Text(data["selected"],style: TextStyle(color: Colors.grey),),
        ],
      ),
    );
  }
}

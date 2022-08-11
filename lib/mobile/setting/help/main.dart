import 'package:flutter/material.dart';
import 'package:getwidget/getwidget.dart';

class Help extends StatefulWidget {
  const Help({Key? key}) : super(key: key);

  @override
  _HelpState createState() => _HelpState();
}

class _HelpState extends State<Help> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: GFAppBar(
        leading: IconButton(onPressed: (){
          Navigator.pop(context);
        }, icon: Icon(Icons.arrow_back_ios,color: Colors.black,)),
        title: const Text('Help',style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold,fontSize: 18),),
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
            single_line_item({"icon":Icons.email_outlined,"title":"Contact us"}),
            single_line_item({"icon":Icons.privacy_tip_outlined,"title":"Privacy Policy"}),
            single_line_item({"icon":Icons.note,"title":"Terms & Conditions"}),
            single_line_item({"icon":Icons.info_outline,"title":"App Info"}),



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

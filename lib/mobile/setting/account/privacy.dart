import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:getwidget/getwidget.dart';


class Privacy extends StatefulWidget {
  const Privacy({Key? key}) : super(key: key);

  @override
  _PrivacyState createState() => _PrivacyState();
}

class _PrivacyState extends State<Privacy> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: GFAppBar(
        leading: IconButton(onPressed: (){
          Navigator.pop(context);
        }, icon: Icon(Icons.arrow_back_ios,color: Colors.black,)),
        title: const Text('Privacy',style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold,fontSize: 18),),
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
            item({"title":"Last Seen", "selected":"Everyone"}),
            item({"title":"Profile Photo", "selected":"Everyone"}),
            item({"title":"About", "selected":"Everyone"}),
            item({"title":"Groups", "selected":"Everyone"}),
            custom_item({"title":"Blocked Contacts", "selected":"2"}),
          ],
        ),
      ),


    );
  }
  Widget item(data){
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

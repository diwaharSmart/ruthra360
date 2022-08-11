import 'package:flutter/material.dart';
import 'package:getwidget/getwidget.dart';

class LinkedDevice extends StatefulWidget {
  const LinkedDevice({Key? key}) : super(key: key);

  @override
  _LinkedDeviceState createState() => _LinkedDeviceState();
}

class _LinkedDeviceState extends State<LinkedDevice> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: GFAppBar(
        leading: IconButton(onPressed: (){
          Navigator.pop(context);
        }, icon: Icon(Icons.arrow_back_ios,color: Colors.black,)),
        title: const Text('Linked Devices',style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold,fontSize: 18),),
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
            item({"title": "Conection","icon":Icons.connected_tv,"selected":"You can connect a single device at a time"}),
            Padding(
              padding: const EdgeInsets.only(left: 18.0,right: 18,top: 10,bottom: 10),
              child: Text("Recent Logins",style: TextStyle(color: Colors.grey),),
            ),
            device({"title": "Chrome","image":"assets/chrome.png","selected":"12.57 PM"}),




          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(backgroundColor: Colors.red,onPressed: (){
        Navigator.pushNamed(context, "scan_device");
      },child: Icon(Icons.qr_code_scanner),),
    );
  }
  Widget item(data){
    return Container(
      padding: EdgeInsets.only(left: 18,right: 18,top: 10,bottom: 10),
      height: 70,
      child: Row(

        children: [
          IconButton(onPressed: (){}, icon: Icon(data["icon"],color: Colors.red,)),
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
  Widget device(data){
    return InkWell(
      onTap: (){
        showDialog<void>(
          context: context,
          barrierDismissible: false, // user must tap button!
          builder: (BuildContext context) {
            return AlertDialog(
              title: const Text('Remove this device ?'),
              content: SingleChildScrollView(
                child: ListBody(
                  children: const <Widget>[
                    Text('you can remove the device by clicking the approve'),

                  ],
                ),
              ),
              actions: <Widget>[
                TextButton(
                  child: const Text('Deny',style: TextStyle(color: Colors.red),),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
                TextButton(
                  child: const Text('Approve'),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
              ],
            );
          },
        );
      },
      child: Container(
        padding: EdgeInsets.only(left: 18,right: 18,top: 10,bottom: 10),
        height: 70,
        child: Row(

          children: [
            Image.asset(data["image"],height: 50,width: 50,),
            SizedBox(width: 10,),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(data["title"],style: TextStyle(fontWeight: FontWeight.bold,fontSize: 15),),

                  Text("last active ${data["selected"]}",style: TextStyle(color: Colors.grey),),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

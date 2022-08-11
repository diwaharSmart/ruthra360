import 'package:flutter/material.dart';
import 'package:getwidget/getwidget.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({Key? key}) : super(key: key);

  @override
  _SettingsScreenState createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  bool value = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: GFAppBar(
        leading: IconButton(onPressed: (){
          Navigator.pop(context);
        }, icon: Icon(Icons.arrow_back_ios,color: Colors.black,)),
        title: const Text('Settings',style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold,fontSize: 18),),
        backgroundColor: Colors.white,
        elevation: 0,
        actions: [

          IconButton(onPressed: (){}, icon: Icon(Icons.search,color: Colors.black,)),

        ],
        // bottom: PreferredSize(
        //     child: Container(
        //       color: Colors.grey[350],
        //       height: 1.0,
        //     ),
        //     preferredSize: Size.fromHeight(4.0)),

      ),
      body: SingleChildScrollView(
        child: Column(
          children: [

            Container(
              color: Colors.white,
              padding: EdgeInsets.all(18),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  CircleAvatar(radius: 35,),
                  SizedBox(width: 30,),
                  Expanded(child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Diwahar",style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold),),
                      Text("online")
                    ],
                  )),
                  Icon(Icons.qr_code,color: Colors.redAccent,),

                ],
              ),
            ),
            InkWell(
              onTap: (){
                _editProfile();
              },
              child: Container(
                color: Colors.white54,
                padding: EdgeInsets.all(15),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                   Icon(Icons.edit,color: Colors.grey,),
                    SizedBox(width: 10,),
                    Expanded(child:
                    Text(
                      "Edit your profile",
                      style: TextStyle(color: Colors.grey),
                    )
                    )
                  ],
                ),
              ),
            ),
            SizedBox(height: 18,),
            Option(Icons.vpn_key,{"title":"Account","text":"Privacy, Security, Mobile bumber","redirect":"account"}),
            Option(Icons.device_hub,{"title":"Linked Devices","text":"Link your device on browsers","redirect":"linked_device"}),

            Option(Icons.message,{"title":"Chats","text":"Theme, Wallpapers, Chat History","redirect":"chats"}),
            Option(Icons.notifications,{"title":"Notification","text":"Chats , Channels, calls","redirect":"notification"}),
            // Option(Icons.sd_storage,{"title":"Storage and data","text":"Privacy, Security","redirect":"account"}),
            Option(Icons.help,{"title":"Help","text":"Helpcenter, contact us,privacy policy","redirect":"help"}),
            // Option(Icons.group_add_rounded,{"title":"Invite Firends","text":"Invite your friends","redirect":"account"}),

            SizedBox(height: 28,),


            Text('MERZOL',style: TextStyle(color: Colors.redAccent,fontWeight: FontWeight.bold,fontSize: 16,fontFamily: "ACK",),),
            SizedBox(height: 48,),
          ],
        ),
      ),
    );
  }
  Widget Option(a,b){
    return InkWell(
      onTap: (){
        Navigator.pushNamed(context, b["redirect"]);
      },
      child: Container(
        padding: EdgeInsets.all(8),
        height: 70,
        color: Colors.white,
        child:Row(
          children: [
            IconButton(onPressed: (){}, icon:Icon(a,color: Colors.grey,)),
            SizedBox(width: 10,),
            Expanded(child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(b["title"],style: TextStyle(fontWeight: FontWeight.bold,fontSize: 16),),
                Text(b["text"],style: TextStyle(color: Colors.grey),),
              ],
            ))
          ],
        )
      ),
    );
  }

  onchanged(){
  setState(() {
    value = true;
  });
  }

  Future<void> _editProfile() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Edit Your Profile'),
          content: SingleChildScrollView(
            child: ListBody(
              children: const <Widget>[
                TextField(
                  style: TextStyle(fontSize: 13),
                  decoration: InputDecoration(
                    hintText: "Your Name",

                    contentPadding: EdgeInsets.all(10),
                    border: OutlineInputBorder(
                      borderSide: const BorderSide(color: Colors.transparent, width: 0.0),
                    ),
                    enabledBorder: const OutlineInputBorder(
                      borderSide: const BorderSide(color: Colors.transparent, width: 0.0),
                    ),
                    focusedBorder: const OutlineInputBorder(
                      borderSide: const BorderSide(color: Colors.transparent, width: 0.0),
                    ),
                    fillColor: Color(0xFFEEEEEE),
                    filled: true,



                  ),
                ),
                SizedBox(height: 10,),
                TextField(
                  maxLines: 4,

                  style: TextStyle(fontSize: 13),
                  decoration: InputDecoration(
                    hintText: "Your Status",

                    contentPadding: EdgeInsets.all(10),
                    border: OutlineInputBorder(
                      borderSide: const BorderSide(color: Colors.transparent, width: 0.0),
                    ),
                    enabledBorder: const OutlineInputBorder(
                      borderSide: const BorderSide(color: Colors.transparent, width: 0.0),
                    ),
                    focusedBorder: const OutlineInputBorder(
                      borderSide: const BorderSide(color: Colors.transparent, width: 0.0),
                    ),
                    fillColor: Color(0xFFEEEEEE),
                    filled: true,



                  ),
                ),
                // Checkbox(value: true, onChanged: onchanged,)
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('Cancel',style: TextStyle(color: Colors.red),),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: const Text('Update'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}

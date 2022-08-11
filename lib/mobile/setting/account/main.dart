import 'package:flutter/material.dart';
import 'package:getwidget/getwidget.dart';

class Account extends StatefulWidget {
  const Account({Key? key}) : super(key: key);

  @override
  _AccountState createState() => _AccountState();
}

class _AccountState extends State<Account> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: GFAppBar(
        leading: IconButton(onPressed: (){
          Navigator.pop(context);
        }, icon: Icon(Icons.arrow_back_ios,color: Colors.black,)),
        title: const Text('Account',style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold,fontSize: 18),),
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
          children: [
            SizedBox(height: 18,),



            Option(Icons.lock,"Privacy"),
            Option(Icons.security,"Security"),
            Option(Icons.mobile_screen_share,"Change number"),
            Option(Icons.download,"Download Account Data"),
            Option(Icons.delete,"Delete Account"),



          ],
        ),
      ),
    );
  }
  Widget Option(a,b){
    String route = b.toLowerCase();
    return InkWell(
      onTap: (){
        Navigator.pushNamed(context, route);
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
                  Text(b,style: TextStyle(fontWeight: FontWeight.bold,fontSize: 16,color: Colors.grey),),

                ],
              ))
            ],
          )
      ),
    );
  }
}

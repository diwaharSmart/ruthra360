import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:ruthra360/mobile/auth/login.dart';
import 'package:ruthra360/mobile/auth/register.dart';
import 'package:ruthra360/mobile/chat/chat.dart';
import 'package:ruthra360/mobile/group/createGroup.dart';
import 'package:ruthra360/mobile/home/index.dart';
import 'package:ruthra360/mobile/meeting/createMeeting.dart';
import 'package:ruthra360/mobile/setting/account/main.dart';
import 'package:ruthra360/mobile/setting/account/privacy.dart';
import 'package:ruthra360/mobile/setting/chats/main.dart';
import 'package:ruthra360/mobile/setting/help/main.dart';
import 'package:ruthra360/mobile/setting/linked_device/main.dart';
import 'package:ruthra360/mobile/setting/linked_device/scanner.dart';
import 'package:ruthra360/mobile/setting/notification/main.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await Hive.initFlutter();

  runApp( GetMaterialApp(
    debugShowCheckedModeBanner: false,

    initialRoute: '/',


    routes: {
      '/chat':(context) =>  ChatScreenMain(),
      '/': (context) =>  InitLoader(),
      '/login': (context) =>  Login(),
      '/complete-profile': (context) =>  CompleteProfile(),
      '/home': (context) =>  HomeIndex(),
      'account':(context) =>  Account(),
      'chats':(context) =>  Chats(),
      'privacy':(context) =>  Privacy(),
      'notification':(context) =>  NotificationScreen(),
      'help':(context) =>  Help(),
      'linked_device':(context) =>  LinkedDevice(),
      'scan_device':(context) =>  QRViewExample(),
      'create_meeting':(context) =>  CreateMeeting(),
      'create_group':(context) =>  CreateGroup(),

    },
  ));


}

class InitLoader extends StatefulWidget {
  const InitLoader({Key? key}) : super(key: key);

  @override
  State<InitLoader> createState() => _InitLoaderState();
}

class _InitLoaderState extends State<InitLoader> {
  Future checkLogin() async{
    FirebaseAuth.instance
        .authStateChanges()
        .listen((User? user) async {
      if (user == null) {
        Navigator.of(context)
            .pushNamedAndRemoveUntil('/login', (Route<dynamic> route) => false);
      }

      else
      {
        Box box = await Hive.openBox('user');
        dynamic p = box.get('profile_completed');
        if(p!= false) {
          Navigator.of(context)
              .pushNamedAndRemoveUntil('/home', (Route<dynamic> route) => false);

        }
        else{
          Navigator.of(context)
              .pushNamedAndRemoveUntil('/complete-profile', (Route<dynamic> route) => false);
        }
       
      }
    });
  }

  @override
  void initState(){
    super.initState();
    // FirebaseAuth.instance.signOut();
    checkLogin();
  }


  Widget build(BuildContext context) {
    return Scaffold();
  }
}












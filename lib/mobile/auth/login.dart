import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:country_list_pick/country_list_pick.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:hive/hive.dart';

import 'package:getwidget/getwidget.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:sms_autofill/sms_autofill.dart';






enum MobileVerificationState {
  SHOW_MOBILE_FROM_STATE,
  SHOW_OTP_FROM_STATE,
}

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {

  final FirebaseAuth _auth = FirebaseAuth.instance;
  TextEditingController controller = new TextEditingController();
  TextEditingController _smsController = new TextEditingController();
  dynamic currentState = MobileVerificationState.SHOW_MOBILE_FROM_STATE;
  late String _verificationId ;
  bool is_loading = false;

  final _scaffoldKey = GlobalKey<ScaffoldState>();
  final color = const Color(0xff43469E);
  String selection ='+91';


  

  void showSnackbar(String message) {

    GFToast.showToast(message, context,toastPosition: GFToastPosition.BOTTOM);
  }

    

    

  void verifyPhoneNumber() async {


      final PhoneVerificationCompleted verificationCompleted =
        (AuthCredential phoneAuthCredential) async {
         
      final res = await _auth.signInWithCredential(phoneAuthCredential);
      
      };
    
    final PhoneCodeSent codeSent =
        (dynamic verificationId, [dynamic forceResendingToken]) async {
           setState(() {
            currentState = MobileVerificationState.SHOW_OTP_FROM_STATE;
          });

      _verificationId = verificationId;

           setState(() {
             is_loading = false;
           });
    };

    final PhoneCodeAutoRetrievalTimeout codeAutoRetrievalTimeout =
        (String verificationId) {
      _verificationId = verificationId;
      
    };
    //
    await _auth.verifyPhoneNumber(
        // mobile no. with country code
        phoneNumber: selection+controller.text,
        timeout: const Duration(seconds: 30),
        verificationCompleted: verificationCompleted,
        verificationFailed: (e){
          setState(() {
            is_loading = false;
          });
          if(e.code == 'invalid-phone-number'){
            showSnackbar("Invalid Mobile Number");
          }
          },
        codeSent: codeSent,
        codeAutoRetrievalTimeout: codeAutoRetrievalTimeout);
   
  }

  void signInWithPhoneNumber() async {
    try {
    final AuthCredential credential = PhoneAuthProvider.credential(
      verificationId: _verificationId,
      smsCode: _smsController.text,
    );

    final User? user = (await _auth.signInWithCredential(credential)).user;
    showSnackbar("Successfully signed in");
    Box box = await Hive.openBox('user');
    box.put('mobile_number', controller.text);
    box.put('country_code', selection);

    check_user();



  } catch (e) {
    showSnackbar("Invalid OTP");
  }
  setState(() {
    is_loading = false;
  });
  }

  Future check_user() async{
    Box box = await Hive.openBox('user');
    var url =
    Uri.parse('http://217.21.78.14:8000/account/check-user/?mobile_number=${selection+controller.text}');

    // Await the http get response, then decode the json-formatted response.
    var response = await http.get(url);
    // print(response.statusCode);
    if (response.statusCode == 200) {
      dynamic data = jsonDecode(response.body);

      box.put('user_id',data["user_id"]);
      box.put('token',data["token"]);
      box.put('profile_image',data["profile_image"]);
      box.put('status',data["status"]);
      box.put('profile_completed',true);
      Navigator.of(context)
          .pushNamedAndRemoveUntil('/home', (Route<dynamic> route) => false);

    } else {
      box.put('profile_completed', false);
      Navigator.of(context)
          .pushNamedAndRemoveUntil('/complete-profile', (Route<dynamic> route) => false);


    }



}







  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      body:
      (is_loading==false)?
      (currentState == MobileVerificationState.SHOW_MOBILE_FROM_STATE)
          ?EnterMobileNumber():
          VerifyOtp()
      :
        GFLoader(),
    );
  }

  
   @override
  void dispose() {
    SmsAutoFill().unregisterListener();
    super.dispose();
  }

  Widget EnterMobileNumber(){
    return Container(
      padding: const EdgeInsets.all(30.0),
      child: ListView(
        children: <Widget>[

          SizedBox(height: 50,),

          //Logo
          Container(
            padding: const EdgeInsets.all(20.0),
            child: Image.asset(
              'assets/MERZOL3.png',

            ),
          ),
          const SizedBox(height: 50,),




          // Mobile Number
          Container(
            padding: EdgeInsets.only(left: 10,right: 10),


              child: Container(

                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: new BorderRadius.circular(30.0),
                    boxShadow: const [
                      BoxShadow(
                          color: Colors.grey,
                          blurRadius: 2.0,
                          spreadRadius: 0.4)
                    ]),
                child: TextFormField(
                
                  decoration: InputDecoration(

                      hintText: 'Mobile Number',
                      prefixIcon: Padding(
                        padding: const EdgeInsets.only(
                            top: 0, left: 10, right: 10, bottom: 0),
                        child: SizedBox(
                            height: 5,
                            child: ButtonTheme(
                              buttonColor: color,
                              shape: RoundedRectangleBorder(
                                  borderRadius:
                                  BorderRadius.circular(30)),
                              child: MaterialButton(
                                onPressed: () {
                                  Navigator.pushNamed(context, '/complete');
                                },
                                child: CountryListPick(
                                    appBar: AppBar(
                                      backgroundColor: Colors.blue,
                                      title: Text('Select Country'),
                                    ),


                                    // To disable option set to false
                                    theme: CountryTheme(
                                      isShowFlag: true,
                                      isShowTitle: false,
                                      isShowCode: false,
                                      isDownIcon: false,
                                      showEnglishName: true,
                                    ),
                                    // Set default value
                                    initialSelection: selection,
                                    // or
                                    // initialSelection: 'US'
                                    onChanged: ( code) {
                                      dynamic a = code?.dialCode;
                                      setState(() {
                                        selection= a;
                                      });


                                    },
                                    // Whether to allow the widget to set a custom UI overlay
                                    useUiOverlay: true,
                                    // Whether the country list should be wrapped in a SafeArea
                                    useSafeArea: false
                                ),
                              ),
                            )),
                      ),
                      counterText: "",
                      border: OutlineInputBorder(
                          borderRadius: new BorderRadius.circular(30.0),
                          borderSide: BorderSide.none)),
                  textAlign: TextAlign.start,
                  maxLines: 1,
                  maxLength: 15,
                  cursorHeight: 20.0,
                  keyboardType: TextInputType.number,
                  inputFormatters: <TextInputFormatter>[
                    FilteringTextInputFormatter.digitsOnly
                  ],


                  controller: controller,
                ),
              )

          ),


          const SizedBox(
            height: 10.0,
          ),

          const Padding(
            padding: EdgeInsets.only(left: 10,right: 10),
            child: Text(
              'Enter your mobile number and verify your otp sent to this device',
              style: TextStyle(
                  fontFamily: 'Poppins', fontSize: 12.0, color: Colors.grey),
            ),
          ),

          const SizedBox(
            height: 70.0,
          ),


          // Send OTP Button
          ButtonTheme(
            minWidth: 200,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30)),
            height: 50,
            buttonColor: color,
            child: MaterialButton(
                onPressed: () async {
                  setState(() {
                    is_loading = true;
                  });
                  verifyPhoneNumber();
                },
                child: const Text(
                  'SEND OTP',
                  style: TextStyle(
                      fontWeight: FontWeight.w700,
                      fontFamily: 'Poppins',
                      color: Colors.white),
                )),
          )
        ],
      ),
    );
  }


  Widget VerifyOtp(){
    return Container(
      padding: EdgeInsets.all(30.0),
      child: ListView(
        children: <Widget>[
          const SizedBox(height: 50,),
          //Logo
          Container(
            padding: EdgeInsets.all(20.0),
            child: Image.asset(
              'assets/MERZOL3.png',
            ),
          ),

          const SizedBox(height: 50,),

          // Otp Number
          Container(
              padding: EdgeInsets.only(left: 10,right: 10),


              child: Container(

                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(30.0),
                    boxShadow: const [
                      BoxShadow(
                          color: Colors.grey,
                          blurRadius: 2.0,
                          spreadRadius: 0.4)
                    ]),
                child: TextField(
                  decoration: InputDecoration(
                      hintText: 'Enter your OTP',

                      counterText: "",
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30.0),
                          borderSide: BorderSide.none)
                  ),
                  style: const TextStyle(fontWeight: FontWeight.bold,color: Colors.grey),
                  textAlign: TextAlign.center,
                  maxLines: 1,
                  maxLength: 6,
                  cursorHeight: 20.0,
                  keyboardType: TextInputType.number,
                  inputFormatters: <TextInputFormatter>[
                    FilteringTextInputFormatter.digitsOnly
                  ],


                  controller: _smsController,
                ),
              )

          ),

          Padding(
            padding: const EdgeInsets.all(18.0),
            child: InkWell(onTap: (){setState(() {
              currentState = MobileVerificationState.SHOW_MOBILE_FROM_STATE;
            });}, child: Text("Change mobile number",style: const TextStyle(color: Colors.blue,fontSize: 12),textAlign: TextAlign.right,)),
          ),

          const SizedBox(height: 70,),
          // Verify OTP Button

          ButtonTheme(
            minWidth: 200,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30)),
            height: 50,
            buttonColor: color,
            child: MaterialButton(
                onPressed: () async{
                  setState(() {
                    is_loading = true;
                  });
                   signInWithPhoneNumber();
                },
                child: const Text(
                  'VERIFY OTP',
                  style: TextStyle(
                      fontWeight: FontWeight.w700,
                      fontFamily: 'Poppins',
                      color: Colors.white),
                ))
          )

        ],
      ),
    );
  }
}



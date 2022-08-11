import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:hive/hive.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';



class CompleteProfile extends StatefulWidget {
  const CompleteProfile({Key? key}) : super(key: key);

  @override
  _CompleteProfileState createState() => _CompleteProfileState();
}

class _CompleteProfileState extends State<CompleteProfile> {
  bool _switchValue = true;
  final _nameKey   = GlobalKey<FormState>();
  final _statusKey = GlobalKey<FormState>();

  TextEditingController nameController = TextEditingController();
  TextEditingController statusController = TextEditingController();

  Future save() async{
    Box box = await Hive.openBox('user');
    dynamic mobile = box.get('mobile_number');
    dynamic country= box.get('country_code');

    final response = await http.post(
      Uri.parse('http://217.21.78.14:8000/account/register-user/'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'username': '${country+mobile}',
        'email': '',
        'name': '${nameController.text}',
        'status': '${statusController.text}',
        'country_code': '${country}'
      }),
    );
    if(response.statusCode == 200){
      // print(response.body);
      dynamic data = jsonDecode(response.body);
      box.put('user_id',data["user_id"]);
      box.put('token',data["token"]);
      box.put('profile_image',data["profile_image"]);
      box.put('status',data["status"]);
      box.put('profile_completed',true);
      Navigator.of(context)
          .pushNamedAndRemoveUntil('/home', (Route<dynamic> route) => false);
    }
    else{
      print(response.statusCode);
      print(response.body);
      box.put('profile_completed',false);
    }

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xff43469E),
        title: const Text(
          'Complete Your Profile',
          style: TextStyle(fontFamily: 'Poppins'),
        ),
      ),
      body: ListView(
        children: <Widget>[
          Column(
            children: <Widget>[
              Container(
                padding: EdgeInsets.all(20.0),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    const Expanded(
                      child: CircleAvatar(
                        radius: 45.0,
                      ),
                    ),
                    Expanded(
                        flex: 3,
                        child: Container(
                          padding: EdgeInsets.only(left: 30.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: <Widget>[
                              const Text(
                                "Your Name",
                                style: TextStyle(
                                    fontFamily: 'Poppins',
                                    fontSize: 20.0,
                                    fontWeight: FontWeight.w700),
                              ),
                              Form(
                                key: _nameKey,
                                child: TextFormField(

                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'Please enter your name';
                                    }

                                  },
                                  controller: nameController,
                                  maxLength: 20,
                                ),
                              )
                            ],
                          ),
                        ))
                  ],
                ),
              ),
              Container(
                child: Row(
                  children: <Widget>[
                    Expanded(
                        child: Container(
                          padding: EdgeInsets.all(10.0),
                          color: Colors.grey[300],
                          child: const Text(
                            'Others',
                            style: TextStyle(
                                fontFamily: 'Poppins', fontWeight: FontWeight.w500),
                          ),
                        )),
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.all(15.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    TextField(
                      decoration:
                      new InputDecoration(hintText: "Enter your email"),
                    ),
                    const Divider(
                      height: 20.0,
                    ),
                    const Text(
                      "Status",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    const Divider(
                      height: 10.0,
                    ),
                    Form(
                      key: _statusKey,

                      child: TextFormField(
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter status';
                          }
                          return null;

                        },

                        controller: statusController,
                        maxLines: 3,
                        maxLength: 150,
                        decoration: InputDecoration(
                            suffixIcon: GestureDetector(
                              onTap: () {

                              },
                              child: Icon(Icons.emoji_emotions),
                            ),
                            contentPadding: EdgeInsets.all(10.0),
                            border: const OutlineInputBorder(
                              borderRadius: BorderRadius.all(
                                Radius.circular(20.0),
                              ),
                            ),
                            isDense: true,
                            filled: true,
                            hintStyle: new TextStyle(color: Colors.grey[800]),
                            hintText: "Tell more about you...",
                            fillColor: Colors.white),
                        cursorHeight: 20.0,
                      ),
                    ),
                    const Divider(
                      height: 20.0,
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        const Expanded(
                            child: Text(
                              "Visible Globally",
                              style: TextStyle(fontWeight: FontWeight.bold),
                            )),
                        Expanded(
                          child: CupertinoSwitch(
                            value: _switchValue,
                            onChanged: (value) {
                              setState(() {
                                _switchValue = value;
                              });
                            },
                          ),
                        ),
                      ],
                    ),
                    const Divider(
                      height: 5.0,
                    ),
                    const Text(
                      'By turning on to globally your Profile will be visible to peoples around the world.Personal details will not be shown',
                      style: TextStyle(fontSize: 12.0, color: Colors.grey),
                    ),
                    const Divider(
                      height: 40,
                    ),
                    const Text(
                      '*Terms & Condition Apply',
                      style: TextStyle(fontSize: 12.0, color: Colors.grey),
                    )
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.navigate_next),
        backgroundColor: Color(0xff43469E),
        onPressed: () {

          if(_nameKey.currentState!.validate()&&_statusKey.currentState!.validate()){
                  save();
          }
          // Navigator.pushReplacementNamed(context, "/invite");
        },
      ),
    );
  }
}
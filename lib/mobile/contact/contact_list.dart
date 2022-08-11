import 'package:flutter/material.dart';
import 'package:flutter_contacts/flutter_contacts.dart';
import 'package:getwidget/components/toast/gf_toast.dart';
import 'package:getwidget/getwidget.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:ruthra360/mobile/chat/chat.dart';
import 'package:hive/hive.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class FlutterContactsExample extends StatefulWidget {
  @override
  _FlutterContactsExampleState createState() => _FlutterContactsExampleState();
}

class _FlutterContactsExampleState extends State<FlutterContactsExample> {
  List ? _contacts;
  List contactsFiltered = [];

  bool _permissionDenied = false;
  bool isSearching=false;
  TextEditingController searchController = new TextEditingController();


  @override
  void initState() {
    super.initState();
    _loadContacts();
    bool isSearching = searchController.text.isNotEmpty;
  }

  Future _loadContacts() async{
    List c = [];
    Box box = await Hive.openBox('contacts');
    setState(() => _contacts = box.values.toList());
  }

  filterContacts() {
    List fcontact = [];
    if (searchController.text.isNotEmpty) {
      for(dynamic c in _contacts!){
        if(c["first_name"].toLowerCase().contains(searchController.text.toString().toLowerCase())){
          fcontact.add(c);
        }
      }
      setState(() {
        contactsFiltered = fcontact;
      });
    }
  }

  Future check_contacts(contacts) async{
    Box box = await Hive.openBox('contacts');
    final response = await http.post(
      Uri.parse('http://217.21.78.14:8000/account/get-contacts/'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<dynamic, dynamic>{
        'contacts': contacts,
      }),
    );


    if(response.statusCode == 200){
      // print(response.body);
      GFToast.showToast("Contacts Updated", context,toastPosition: GFToastPosition.BOTTOM);
      dynamic data = jsonDecode(response.body);

      for(dynamic i in data){
        box.put(i["user_id"], i);
      }
      _loadContacts();
    }
    
    else{
      GFToast.showToast(response.statusCode.toString(), context);


    }
  }

  Future _fetchContacts() async {

    List a = [];
    if (!await FlutterContacts.requestPermission(readonly: true)) {
      setState(() => _permissionDenied = true);
    } else {
      final contacts = await FlutterContacts.getContacts(withProperties: true);

      for(dynamic c in contacts){
        try {
          a.add(c.phones[0].normalizedNumber);
        }
        catch(e){

        }
      }
      check_contacts(a);
    }

  }

  @override
  Widget build(BuildContext context) => MaterialApp(

      home: SafeArea(
        child: Scaffold(
            backgroundColor: Colors.grey[100],
            appBar: AppBar(
              elevation: 0,
            
              backgroundColor: Colors.white,
            flexibleSpace: Container(
              child: Row(
                children: [
                  IconButton(splashRadius: 25,onPressed: (){

                    Navigator.pop(context);
                  },icon: Icon(Icons.arrow_back_ios_outlined,color: Colors.black,
                  ),

                  ),

                  Expanded(
                    child: Container(
                      padding: EdgeInsets.all(10),
                      child: TextField(
                        style: TextStyle(fontSize: 13),
                        decoration: InputDecoration(
                          hintText: "Search contacts",

                          contentPadding: EdgeInsets.all(10),
                          border: const OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.transparent, width: 0.0),
                          ),
                          enabledBorder: const OutlineInputBorder(
                            borderSide: const BorderSide(color: Colors.transparent, width: 0.0),
                          ),
                          focusedBorder: const OutlineInputBorder(
                            borderSide: const BorderSide(color: Colors.transparent, width: 0.0),
                          ),
                          fillColor: Colors.grey[200],
                          filled: true,

                        ),
                        controller: searchController,
                        onChanged: (val){
                          if(searchController.text.isEmpty){
                            setState(() {
                              isSearching = false;
                            });

                          }
                          else{
                            setState(() {
                              filterContacts();
                              isSearching = true;

                            });
                          }
                        },
                      ),
                    ),
                  ),
                  IconButton(splashRadius: 25,onPressed: (){_fetchContacts();}, icon: Icon(Icons.refresh))
                ],
              ),
            ),),
            body: _body()),
      ));

  Widget _body() {


    if (_permissionDenied) return Center(child: Text('Permission denied'));
    if (_contacts == null || _contacts!.isEmpty) return Center(child: Text("No Contacts Available"));
    return Column(
      children: [
        (searchController.text.isNotEmpty==true)?ContactItemListFiltered():ContactItemList(),

      ],
    );
  }

  Widget ContactItemList() {
    return Expanded(
      child: ListView.builder(
          itemCount: _contacts!.length,
          itemBuilder: (context, i) {

            dynamic subname =_contacts![i]["first_name"].substring(0,2);

              return ListTile(
                  title: Row(
                    children: [
                      CircleAvatar(
                        backgroundColor: Colors.blueGrey,
                        child: Text(subname),
                      ),
                      SizedBox(width: 10,),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('${_contacts![i]["first_name"]}',
                              style: TextStyle(fontSize: 13),),
                            Text('${_contacts![i]["username"]}',
                              style: TextStyle(fontSize: 11,color: Colors.grey),),
                          ],
                        ),
                      ),
                      IconButton(onPressed: () {},
                          icon: Icon(Icons.call, color: Colors.blueGrey,)),
                      IconButton(onPressed: () {},
                          icon: Icon(
                            Icons.video_call, color: Colors.blueGrey,)),

                    ],
                  ),
                  onTap: () async {
                    await Navigator.of(context).push(
                        MaterialPageRoute(
                            builder: (_) => ChatScreenMain()));
                  }
          );
          }
    )

    );
  }
  Widget ContactItemListFiltered(){
    return Expanded(
      child: ListView.builder(
          itemCount: contactsFiltered.length,
          itemBuilder: (context, i) => ListTile(
              title: Row(
                children: [
                  Expanded(child: Text(contactsFiltered[i].displayName,style: TextStyle(fontSize: 13),)),
                  IconButton(onPressed: (){}, icon: Icon(Icons.call,color: Colors.blueGrey,)),
                  IconButton(onPressed: (){}, icon: Icon(Icons.video_call,color: Colors.blueGrey,)),
                ],
              ),
              onTap: () async {

                await Navigator.of(context).pushReplacement(
                    MaterialPageRoute(builder: (_) => ChatScreenMain()));
              })),
    );
  }

}


class ContactPage extends StatelessWidget
{
  final Contact contact;
  ContactPage(this.contact);

  @override
  Widget build(BuildContext context) => Scaffold(
      appBar: AppBar(title: Text(contact.displayName)),
      body: Column(children: [
        Text('First name: ${contact.name.first}'),
        Text('Last name: ${contact.name.last}'),
        Text(
            'Phone number: ${contact.phones.isNotEmpty ? contact.phones.first.number : '(none)'}'),
        Text(
            'Email address: ${contact.emails.isNotEmpty ? contact.emails.first.address : '(none)'}'),
      ]));
}


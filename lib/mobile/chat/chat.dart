import 'package:flutter/material.dart';
import 'package:language_picker/languages.dart';
import 'package:language_picker/language_picker.dart';
import 'package:ruthra360/mobile/chat/widgets/chatBubble.dart';
// import 'package:ruthra360/chat_package/chat_package.dart';
import 'package:ruthra360/mobile/chat/widgets/chatController.dart';
import 'package:ruthra360/mobile/chat/widgets/messages.dart';

class ChatScreenMain extends StatefulWidget {
  const ChatScreenMain({Key? key}) : super(key: key);

  @override
  State<ChatScreenMain> createState() => _ChatScreenMainState();
}

class _ChatScreenMainState extends State<ChatScreenMain> {
  Language _selectedLaunguage = Languages.english;
  String data = "";

  List<String> chat = [];

  Widget _buildDialogItem(Language language) => Row(
        children: <Widget>[
          Text(language.name),
          SizedBox(width: 8.0),
          Flexible(child: Text("(${language.isoCode})"))
        ],
      );

  void _openLanguagePickerDialog() => showDialog(
        context: context,
        builder: (context) => Theme(
            data: Theme.of(context).copyWith(primaryColor: Colors.pink),
            child: LanguagePickerDialog(
                titlePadding: EdgeInsets.all(8.0),
                searchCursorColor: Colors.pinkAccent,
                searchInputDecoration: InputDecoration(hintText: 'Search...'),
                isSearchable: true,
                title: Text('Select language'),
                onValuePicked: (Language language) => setState(() {
                      _selectedLaunguage = language;
                      // print(_selectedLaunguage.name);
                      // print(_selectedLaunguage.isoCode);
                    }),
                itemBuilder: _buildDialogItem)),
      );

  @override
  void initState() {
    setState(() {
      chat = [];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          elevation: 0,
          automaticallyImplyLeading: false,
          backgroundColor: Colors.grey[100],
          flexibleSpace: SafeArea(
              child: Container(
            padding: EdgeInsets.only(left: 10, right: 10),
            child: Row(
              children: [
                IconButton(
                    splashRadius: 20,
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    icon: Icon(Icons.arrow_back_ios)),
                CircleAvatar(),
                Expanded(
                  child: Container(
                    padding: EdgeInsets.only(left: 10, right: 10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: const [
                        Text(
                          "Diwahar",
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        Text(
                          "Active Now",
                          style: TextStyle(fontSize: 10),
                        ),
                      ],
                    ),
                  ),
                ),

                // Container(
                //     color: Colors.green,
                //     padding: EdgeInsets.all(10),
                //     child: Text("${_selectedLaunguage.isoCode}")
                // ),

                // SizedBox(width: 20,),

                IconButton(
                    splashRadius: 20,
                    onPressed: () {
                      _openLanguagePickerDialog();
                    },
                    icon: Icon(Icons.translate)),

                // SizedBox(width: 20,),

                IconButton(
                    splashRadius: 20,
                    onPressed: () {},
                    icon: Icon(Icons.phone)),
              ],
            ),
          )),
        ),
        body: Column(
          children: [
            // Expanded(child: ChatScreen(senderColor: Colors.redAccent,sendMessageHintText: "Type here...",messages: []))
            Expanded(child: RoomMessages(chat)),
            ChatController((value) => {
                  setState(
                    () {
                      data = value;
                      chat.add(value);
                    },
                  )
                }),
          ],
        ));
  }

  Widget Message() {
    return ListView(
      children: const [
        ChatBubble(
          text: 'How was the concert?',
          isCurrentUser: false,
          hasAudio: false,
          hasDocument: false,
          hasImage: false,
          hasVideo: false,
          isVoiceNote: false,
        ),
        ChatBubble(
          text: 'Awesome! Next time you gotta come as well!',
          isCurrentUser: true,
          hasAudio: false,
          hasDocument: false,
          hasImage: false,
          hasVideo: false,
          isVoiceNote: false,
        ),
      ],
    );
  }
}

// class Messages {
//   final String text;

//   const Messages({required this.text});
// }

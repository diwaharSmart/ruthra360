import 'package:flutter/material.dart';
import 'package:ruthra360/mobile/chat/widgets/audioWidget.dart';

class ChatBubble extends StatelessWidget {
  const ChatBubble({
    Key? key,
    required this.text,
    required this.isCurrentUser,
    required this.hasImage,
    required this.hasVideo,
    required this.hasAudio,
    required this.hasDocument,
    required this.isVoiceNote,
    this.image,
    this.video,
    this.audio,
    this.document,
    this.voicenote,
  }) : super(key: key);
  final String text;
  final bool isCurrentUser;
  final bool hasImage;
  final bool hasVideo;
  final bool hasAudio;
  final bool hasDocument;
  final bool isVoiceNote;
  final dynamic image;
  final dynamic audio;
  final dynamic video;
  final dynamic document;
  final dynamic voicenote;

  @override
  Widget build(BuildContext context) {
    return Padding(
      // asymmetric padding
      padding: EdgeInsets.fromLTRB(
        isCurrentUser ? 64.0 : 16.0,
        4,
        isCurrentUser ? 16.0 : 64.0,
        4,
      ),
      child: Align(
        // align the child within the container
        alignment: isCurrentUser ? Alignment.centerRight : Alignment.centerLeft,
        child: DecoratedBox(
          // chat bubble decoration
          decoration: BoxDecoration(
            color: isCurrentUser ? Colors.blue : Colors.grey[300],
            borderRadius: BorderRadius.circular(16),
          ),
          child: Padding(
            padding: const EdgeInsets.all(12),
            child:
            Column(
              children: [
                AudioMessageWidget(inActiveAudioSliderColor: Colors.black,activeAudioSliderColor: Colors.white,audioURl: "https://www2.cs.uic.edu/~i101/SoundFiles/BabyElephantWalk60.wav",isSender: true,senderColor: Colors.blue,createdAt: 100023948,)

                // Text(
                //   text,
                //   style: Theme.of(context).textTheme.bodyText1!.copyWith(
                //       color: isCurrentUser ? Colors.white : Colors.black87),
                // ),
              ],
            ),

          ),
        ),
      ),
    );
  }
}
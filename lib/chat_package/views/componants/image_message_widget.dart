import 'dart:io';

import 'package:ruthra360/chat_package/models/chat_message.dart';
import 'package:ruthra360/chat_package/utils/constants.dart';
import 'package:ruthra360/chat_package/views/screens/photo_gallery_view.dart';
import 'package:flutter/material.dart';
import 'package:transparent_image/transparent_image.dart';

class ImageMessageWidget extends StatelessWidget {
  /// chat message model to get teh data
  final ChatMessage message;

  ///the color of the sender container
  final Color senderColor;

  const ImageMessageWidget(
      {Key? key, required this.message, required this.senderColor})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment:
          message.isSender ? CrossAxisAlignment.end : CrossAxisAlignment.start,
      children: [
        InkWell(
          onTap: () {
            /// navigate to to the photo galary view, for viewing the taped image
            Navigator.of(context).push(
              MaterialPageRoute<void>(
                builder: (BuildContext context) => PhotoGalleryView(
                  chatMessage: message,
                ),
              ),
            );
          },
          child: Container(
            width: MediaQuery.of(context).size.width * 0.45,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(30),
              color: senderColor.withOpacity(message.isSender ? 1 : 0.1),
            ),

            /// 45% of total width
            child: AspectRatio(
              aspectRatio: 1,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: message.imageUrl != null
                    ? FadeInImage.memoryNetwork(
                        placeholder: kTransparentImage,
                        image: message.imageUrl!,
                        fit: BoxFit.cover,
                      )
                    : Image.file(File(message.imagePath!)),
              ),
            ),
          ),
        ),
        SizedBox(
          height: 3,
        ),
        Padding(
          padding: EdgeInsets.only(
            // top: 2,
            left: kDefaultPadding / 2,
            right: kDefaultPadding / 2,
          ),
          child: Text(
            dateStringFormatter(message.createdAt ?? DateTime.now()),
            style: TextStyle(fontSize: 12),
          ),
        ),
      ],
    );
  }
}

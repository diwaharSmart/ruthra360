import 'package:flutter/material.dart';
import 'package:story_view/story_view.dart';

class MoreStories extends StatefulWidget {
  @override
  _MoreStoriesState createState() => _MoreStoriesState();
}

class _MoreStoriesState extends State<MoreStories> {
  final storyController = StoryController();

  @override
  void dispose() {
    storyController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: Stack(
        children: [
          StoryView(

            storyItems: [
              StoryItem.text(
                title: "I guess you'd love to see more of our food. That's great.",
                backgroundColor: Colors.blue,
              ),
              StoryItem.text(
                title: "Nice!\n\nTap to continue.",
                backgroundColor: Colors.red,
                textStyle: TextStyle(
                  fontFamily: 'Dancing',
                  fontSize: 40,
                ),
              ),
              StoryItem.pageImage(
                url:
                "https://image.ibb.co/cU4WGx/Omotuo-Groundnut-Soup-braperucci-com-1.jpg",
                caption: "Still sampling",
                controller: storyController,
              ),
              StoryItem.pageImage(
                  url: "https://media.giphy.com/media/5GoVLqeAOo6PK/giphy.gif",
                  caption: "Working with gifs",
                  controller: storyController),
              StoryItem.pageImage(
                url: "https://media.giphy.com/media/XcA8krYsrEAYXKf4UQ/giphy.gif",
                caption: "Hello, from the other side",
                controller: storyController,
              ),
              StoryItem.pageImage(
                url: "https://media.giphy.com/media/XcA8krYsrEAYXKf4UQ/giphy.gif",
                caption: "Hello, from the other side2",
                controller: storyController,
              ),
            ],
            onStoryShow: (s) {
              print("Showing a story");
            },
            onComplete: () {
              print("Completed a cycle");
            },
            progressPosition: ProgressPosition.top,
            repeat: false,
            controller: storyController,
          ),
          Column(
            children: [
              Container(
                height: kToolbarHeight-5,
                color: Colors.transparent,
              ),
              Container(
                height: kToolbarHeight,
                color: Colors.transparent,
                padding: EdgeInsets.only(left: 20.0,right: 20.0),

                child: Row(
                  children: [
                    InkWell(
                      onTap: (){ Navigator.pop(context);},
                      child: Icon(Icons.arrow_back_ios,color: Colors.white,),
                    ),

                    CircleAvatar(radius: 25.0,),
                    SizedBox(width: 15.0,),
                    Expanded(child: Text("Merzol" ,style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold),))
                  ],
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
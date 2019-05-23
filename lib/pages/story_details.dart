import 'dart:math';
import 'package:flutter/material.dart';
import '../resources/data.dart';

class StoryDetails extends StatefulWidget {
  String storyName;
  String storyDetails;
  StoryDetails({this.storyName = '', this.storyDetails = ''});

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _StoryDetailsState();
  }
}

class _StoryDetailsState extends State<StoryDetails> {
  double fontSize = 16.0;
  double textScaleFactor;
  TextStyle storyStyle = TextStyle(
    fontSize: 16.0,
  );

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    textScaleFactor = 1;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.storyName)),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.all(20.0),
          child: GestureDetector(
              onScaleUpdate: (ScaleUpdateDetails details) {
                // if (textScaleFactor == 10) {
                // } else {
                //  print(details.scale);
                print('-------');
                print(details.scale);
                var scale = details.scale;
                setState(() {
                  textScaleFactor = scale;
                });
                //   }
              },
              onScaleEnd: (ScaleEndDetails details) {
             //   print(details.velocity);
                // setState(() {
                //   textScaleFactor = 1;
                // });
              },
              child: Text(widget.storyDetails,
                  textScaleFactor: textScaleFactor,
                  maxLines: 100000,
                  softWrap: true,
                  textAlign: TextAlign.left,
                  style: storyStyle)),
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import './pages/story_home_screen.dart';

void main() => runApp(StoryApp());

class StoryApp extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _StoryAppState();
  }
}

class _StoryAppState extends State<StoryApp>{
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return MaterialApp(
      theme: ThemeData(accentColor: Color(0xffF5C469),
      primaryColor: Color(0xff7B8788)),
      home: StoryHome(),


    );
  }
}

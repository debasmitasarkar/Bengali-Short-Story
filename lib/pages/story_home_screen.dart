import 'dart:ui';

import 'package:flutter/material.dart';
import '../resources/data.dart';
import './story_details.dart';

class StoryHome extends StatelessWidget {
  TextStyle headerTextStyle =
      TextStyle(fontSize: 22.0, fontWeight: FontWeight.w700);
  TextStyle descTextStyle =
      TextStyle(fontSize: 19.0, fontWeight: FontWeight.w500);

  Widget cardImage(image) => Image.asset(
        'assets/images/$image',
        fit: BoxFit.cover,
      );

  Widget cardColor() => Container(
        decoration: BoxDecoration(boxShadow: <BoxShadow>[
          BoxShadow(
            color: Colors.grey.withOpacity(0.7),
            blurRadius: 5.0,
          ),
        ]),
      );

  Widget cardData(story) => Container(
      padding: EdgeInsets.all(10.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(
            story['storyname'],
            style: headerTextStyle,
          ),
          SizedBox(
            height: 10.0,
          ),
          Text(
            story['story'],
            style: descTextStyle,
            maxLines: 4,
          )
        ],
      ));

  Widget _buildStoryCard(context, story) {
    return GestureDetector(
        onTap: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (BuildContext context) => StoryDetails(
                        storyName: story['storyname'],
                        storyDetails: story['story'],
                      )));
        },
        child: Card(
          clipBehavior: Clip.antiAlias,
          elevation: 2.0,
          child: Container(
              height: 200.0,
              child: Stack(
                fit: StackFit.expand,
                children: <Widget>[
                  cardImage(story['image']),
                  cardColor(),
                  cardData(story),
                ],
              )),
        ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Container(
        margin: EdgeInsets.all(10.0),
        child: ListView.builder(
          itemCount: storyList.length,
          itemBuilder: (BuildContext context, index) {
            return _buildStoryCard(context, storyList[index]);
          },
        ),
      ),
    );
  }
}

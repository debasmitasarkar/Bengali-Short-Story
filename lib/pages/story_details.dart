import 'dart:math';

import 'package:flutter/material.dart';
import 'package:firebase_admob/firebase_admob.dart';

import '../resources/data.dart';

class StoryDetails extends StatefulWidget {
  String storyName;
  String storyDetails;
  StoryDetails({this.storyName = '', this.storyDetails = ''});

  @override
  State<StatefulWidget> createState() {
    return _StoryDetailsState();
  }
}

class _StoryDetailsState extends State<StoryDetails> {
  double fontSize = 16.0;
  double textScaleFactor;

  TextStyle storyStyle = TextStyle(
    fontSize: 16.0,
  );

  static const MobileAdTargetingInfo targetingInfo = MobileAdTargetingInfo(
    keywords: <String>['foo', 'bar'],
    contentUrl: 'http://foo.com/bar.html',
    childDirected: true,
    nonPersonalizedAds: true,
  );

  BannerAd _bannerAd;
  InterstitialAd _interstitialAd;

  BannerAd createBannerAd() {
    return BannerAd(
      adUnitId: BannerAd.testAdUnitId, //ca-app-pub-1734447714483073/8319456188
      size: AdSize.banner,
      targetingInfo: targetingInfo,
      listener: (MobileAdEvent event) {
        print("BannerAd event $event");
      },
    );
  }

  InterstitialAd createInterstitialAd() {
    return InterstitialAd(
      adUnitId:
          InterstitialAd.testAdUnitId, //ca-app-pub-1734447714483073/7221641714
      targetingInfo: targetingInfo,
      listener: (MobileAdEvent event) {
        print("InterstitialAd event $event");
      },
    );
  }

  @override
  void initState() {
    super.initState();
    textScaleFactor = 1;
    _bannerAd = null;
    _interstitialAd = createInterstitialAd()
      ..load()
      ..show();
    // FirebaseAdMob.instance.initialize(appId: FirebaseAdMob.testAppId);
    // _bannerAd = createBannerAd()
    //   ..load()
    //   ..show();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _bannerAd.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.storyName)),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.all(20.0),
          margin: EdgeInsets.only(bottom: 50.0),
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

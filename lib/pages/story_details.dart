import 'dart:math';

import 'package:flutter/material.dart';
import 'package:firebase_admob/firebase_admob.dart';

import '../resources/data.dart';
import 'package:share/share.dart';

enum AppConstants { increaseFont, decreaseFont, shareApp }

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
  double maxFontSize = 50;
  double minFontSize = 10;
  // double _initTextScaleFactor=1;

  TextStyle storyStyle(_fontSize) => TextStyle(
        fontSize: _fontSize,
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
      adUnitId: 'ca-app-pub-3940256099942544/6300978111',
      size: AdSize.banner,
      targetingInfo: targetingInfo,
      listener: (MobileAdEvent event) {
        print("BannerAd event $event");
      },
    );
  }

  InterstitialAd createInterstitialAd() {
    return InterstitialAd(
      adUnitId: 'ca-app-pub-3940256099942544/1033173712',
      targetingInfo: targetingInfo,
      listener: (MobileAdEvent event) {
        print("InterstitialAd event $event");
      },
    );
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _bannerAd.dispose();
    _interstitialAd.dispose();
  }

  @override
  void initState() {
    super.initState();
    _bannerAd = createBannerAd()
      ..load()
      ..show();
    _interstitialAd = createInterstitialAd()
      ..load()
      ..show();
  }

  _buildPopupMenuItem(AppConstants constants, String text) {
    return PopupMenuItem<AppConstants>(
      value: constants,
      child: GestureDetector(
          onTap: () {
            setState(() {
              if (constants == AppConstants.increaseFont &&
                  fontSize < maxFontSize) {
                fontSize = fontSize + 3;
              } else if (constants == AppConstants.decreaseFont &&
                  fontSize > minFontSize) {
                fontSize = fontSize - 3;
              } else if (constants == AppConstants.shareApp) {
                Share.share(widget.storyDetails);
              }
            });
          },
          child: Text(text)),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.storyName),
        actions: <Widget>[
          PopupMenuButton<AppConstants>(
            itemBuilder: (BuildContext context) => [
                  _buildPopupMenuItem(
                      AppConstants.decreaseFont, "Decrease Font"),
                  _buildPopupMenuItem(
                      AppConstants.increaseFont, "Increase Font"),
                  _buildPopupMenuItem(AppConstants.shareApp, "Share App")
                ],
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Container(
            padding: EdgeInsets.all(20.0),
            margin: EdgeInsets.only(bottom: 40.0),
            child: Text(widget.storyDetails,
                maxLines: 100000,
                softWrap: true,
                textAlign: TextAlign.left,
                style: storyStyle(fontSize))),
      ),
    );
  }
}

import 'dart:async';
import 'package:flutter/material.dart';

class ImageSwitcher extends StatefulWidget {
  const ImageSwitcher({super.key});

  @override
  _ImageSwitcherState createState() => _ImageSwitcherState();
}

class _ImageSwitcherState extends State<ImageSwitcher> {
  List<String> imageAssets = [
    "assetimage/shutterstock_139888759 1.png",
    "assetimage/Premium Vector _ Wolrd water day.jpeg",
    "assetimage/Wellness tips, reminder to drink water, daily reminder, drink water quote, wellness.jpeg",
  ];

  int currentIndex = 0;
  Timer? timer;

  @override
  void initState() {
    super.initState();
    startTimer();
  }

  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }

  void startTimer() {
    timer?.cancel(); // Cancel any existing timer
    timer = Timer.periodic(Duration(seconds: 2), (Timer t) {
      setState(() {
        currentIndex = (currentIndex + 1) % imageAssets.length;
      });
    });
  }

  void stopTimer() {
    timer?.cancel();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onLongPressStart: (_) => stopTimer(),
      onLongPressEnd: (_) => startTimer(),
      child: Container(
        width: 400,
        height: 480,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: 50,
              width: 400,
              color: Colors.lightBlueAccent,
              child: Padding(
                padding: const EdgeInsets.only(left: 10.0 ,top: 10),
                child: Text(
                  "Advertisement",
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      letterSpacing: 1,
                      fontWeight: FontWeight.w400),
                ),
              ),
            ),
            Container(
              width: 400,
              height: 430,
              decoration: BoxDecoration(
                color: Colors.transparent,
                image: DecorationImage(
                  image: AssetImage(imageAssets[currentIndex]),
                  fit: BoxFit.fill,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

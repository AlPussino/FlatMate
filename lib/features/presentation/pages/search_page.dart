import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        elevation: 0,
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        title: const Text(
          "Search",
          style: TextStyle(
            color: Color(0xff000000),
            fontFamily: 'Dosis',
            fontWeight: FontWeight.bold,
            fontSize: 24,
          ),
        ),
      ),
      body: Column(
        children: [
          SizedBox(
            width: MediaQuery.sizeOf(context).width,
            child: TextLiquidFill(
              text: 'Search',
              waveColor: Colors.blueAccent,
              boxBackgroundColor: Colors.white,
              textStyle: TextStyle(
                fontSize: 80.0,
                fontWeight: FontWeight.bold,
                fontFamily: 'Dosis',
              ),
              boxHeight: 300.0,
              loadDuration: Duration(seconds: 1),
            ),
          ),
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              DefaultTextStyle(
                textAlign: TextAlign.start,
                style: const TextStyle(
                  fontSize: 40.0,
                  fontFamily: 'Dosis',
                  color: Colors.black,
                ),
                child: AnimatedTextKit(
                  isRepeatingAnimation: true,
                  animatedTexts: [
                    RotateAnimatedText("I don't know"),
                    RotateAnimatedText("how to code"),
                    RotateAnimatedText('Search Page'),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

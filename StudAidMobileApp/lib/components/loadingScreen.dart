import 'package:flutter/cupertino.dart';
import 'package:loading_indicator/loading_indicator.dart';
import 'package:flutter/material.dart';

const List<Color> _kDefaultRainbowColors = const [
  Color.fromRGBO(20, 30, 39, 1.0),
];

class LoadingScreen extends StatefulWidget {
  const LoadingScreen({super.key});

  @override
  State<LoadingScreen> createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {
  @override
  Widget build(BuildContext context) {
    return SizedBox.expand(
      child: Container(
        height: 100,
        width: 100,
        decoration: BoxDecoration(color: Color.fromRGBO(238, 237, 222, 1)),
        alignment: Alignment.center,
        child: Padding(
          padding: const EdgeInsets.all(150),
          child: Align(
            alignment: Alignment.center,
            child: LoadingIndicator(
              indicatorType: Indicator.ballSpinFadeLoader,
              colors: _kDefaultRainbowColors,
              strokeWidth: 4.0,
            ),
          ),
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  final double containerSize;
  final double tileSize;
  final Curve curve;
  const SplashScreen({
    super.key,
    this.containerSize = 160.0,
    this.tileSize = 46.0,
    this.curve = Curves.easeInOut,
  });

  const SplashScreen.large({super.key, this.curve = Curves.easeInOut})
      : containerSize = 320.0,
        tileSize = 92.0;

  const SplashScreen.normal({super.key, this.curve = Curves.easeInOut})
      : containerSize = 240.0,
        tileSize = 64.0;

  const SplashScreen.medium({super.key, this.curve = Curves.easeInOut})
      : containerSize = 120.0,
        tileSize = 36.0;

  const SplashScreen.small({super.key, this.curve = Curves.easeInOut})
      : containerSize = 54.0,
        tileSize = 18.0;

  @override
  SplashScreenState createState() => SplashScreenState();
}

class SplashScreenState extends State<SplashScreen> with TickerProviderStateMixin {
  late double containerSize = widget.containerSize;
  late double tileSize = widget.tileSize;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.grey[300],
      child: Center(
        child: SizedBox(
          width: containerSize,
          height: containerSize,
          child: const Center(
            child: CircularProgressIndicator.adaptive(),
          ),
        ),
      ),
    );
  }
}

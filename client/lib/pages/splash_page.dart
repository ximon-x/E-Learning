import 'package:client/utils/constants.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  get xSplashContainerSize => null;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(children: [
          const Positioned(
              top: 80, left: 30, child: Image(image: AssetImage(xAppBanner))),
          const Positioned(
              bottom: 100,
              child: Image(
                image: AssetImage(xSplashImage),
              )),
          Positioned(
              bottom: 40,
              right: 30,
              child: Container(
                width: 80,
                height: 80,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(100),
                  color: Theme.of(context).primaryColor,
                ),
              ))
        ]),
      ),
    );
  }
}

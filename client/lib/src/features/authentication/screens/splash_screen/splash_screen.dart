import 'package:client/src/constants/color.dart';
import 'package:client/src/constants/image_strings.dart';
import 'package:client/src/constants/sizes.dart';
import 'package:client/src/constants/text_strings.dart';
import 'package:client/src/features/authentication/controllers/splash_screen_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SplashScreen extends StatelessWidget {
  SplashScreen({Key? key}) : super(key: key);

  final splashController = Get.put(SplashScreenController());

  @override
  Widget build(BuildContext context) {
    splashController.initialLoad();

    return Scaffold(
      body: SafeArea(
        child: Stack(children: [
          Positioned(
              top: 80,
              left: xDefaultSize,
              child: Column(children: [
                Text(
                  xAppName,
                  style: Theme.of(context).textTheme.displaySmall,
                ),
                Text(
                  xAppTagLine,
                  style: Theme.of(context).textTheme.headlineSmall,
                )
              ])),
          const Positioned(
              bottom: 100,
              child: Image(
                image: AssetImage(xSplashImage),
              )),
          Positioned(
              bottom: 40,
              right: xDefaultSize,
              child: Container(
                width: xSplashContainerSize,
                height: xSplashContainerSize,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(100),
                  color: xPrimaryColor,
                ),
              ))
        ]),
      ),
    );
  }
}

import 'package:client/src/features/authentication/screens/welcome_screen/welcome_screen.dart';
import 'package:get/get.dart';

class SplashScreenController extends GetxController {
  static SplashScreenController get find => Get.find();

  Future initialLoad() async {
    await Future.delayed(const Duration(seconds: 5));
    Get.to(const WelcomeScreen());
  }
}

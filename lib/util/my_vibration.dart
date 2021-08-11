import 'package:vibration/vibration.dart';

class MyVibration {
  static void vibrateWhenClicked() async {
    if (await Vibration?.hasVibrator() == true) {
      Vibration.vibrate(duration: 10, amplitude: 120);
    }
  }
}

import 'dart:math';

class BodyMassIndex {

  String hint() {
    double bmiNumber = bmi();

    if (bmiNumber >= 25) {
      return 'You are a fat fuck. Get your shit together!';
    } else if (bmiNumber > 18.5) {
      return 'You are average if not mediocre. Do more to be more!';
    } else {
      return 'You are a whimsical little bitch. Feed and train your body!';
    }
  }

  String judgement() {
    double bmiNumber = bmi();

    if (bmiNumber >= 25) {
      return 'Overweight';
    } else if (bmiNumber > 18.5) {
      return 'Normal';
    } else {
      return 'Underweight';
    }
  }

  String numberSring() {
    return bmi().toStringAsFixed(1);
  }

  double bmi() {
    return weight.toDouble() / pow(height.toDouble() / 100, 2);
  }

  BodyMassIndex({required this.height, required this.weight});

  int height;
  int weight;
}
import 'package:flutter/material.dart';
import 'package:confetti/confetti.dart'; // Add this dependency
import 'dart:math';

class ResultPage extends StatefulWidget {
  final double bmi;

  const ResultPage({super.key, required this.bmi});

  @override
  _ResultPageState createState() => _ResultPageState();
}

class _ResultPageState extends State<ResultPage> {
  late ConfettiController _confettiController;

  @override
  void initState() {
    super.initState();
    _confettiController =
        ConfettiController(duration: const Duration(seconds: 2));
    // Only play confetti if BMI is in the "Normal" range
    if (widget.bmi >= 18.5 && widget.bmi < 24.9) {
      _confettiController.play();
    }
  }

  @override
  void dispose() {
    _confettiController.dispose();
    super.dispose();
  }

  String getBMICategoryText() {
    if (widget.bmi < 18.5) {
      return "Underweight";
    } else if (widget.bmi >= 18.5 && widget.bmi < 24.9) {
      return "Normal";
    } else if (widget.bmi >= 25 && widget.bmi < 29.9) {
      return "Overweight";
    } else {
      return "Obese";
    }
  }

  Widget getBMICategory() {
    if (widget.bmi < 18.5) {
      return Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            "Underweight",
            style: TextStyle(
              fontSize: 28,
              fontWeight: FontWeight.bold,
              color: getCategoryColor(),
            ),
          ),
          const SizedBox(width: 8),
          Icon(
            Icons.sentiment_dissatisfied_outlined,
            color: getCategoryColor(),
            size: 28,
          ),
        ],
      );
    } else if (widget.bmi >= 18.5 && widget.bmi < 24.9) {
      return Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            "Normal",
            style: TextStyle(
              fontSize: 28,
              fontWeight: FontWeight.bold,
              color: getCategoryColor(),
            ),
          ),
          const SizedBox(width: 8),
          Icon(
            Icons.sentiment_satisfied_alt_outlined,
            color: getCategoryColor(),
            size: 28,
          ),
        ],
      );
    } else if (widget.bmi >= 25 && widget.bmi < 29.9) {
      return Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            "Overweight",
            style: TextStyle(
              fontSize: 28,
              fontWeight: FontWeight.bold,
              color: getCategoryColor(),
            ),
          ),
          const SizedBox(width: 8),
          Icon(
            Icons.sentiment_dissatisfied_outlined,
            color: getCategoryColor(),
            size: 28,
          ),
        ],
      );
    } else {
      return Text(
        "Obese",
        style: TextStyle(
          fontSize: 28,
          fontWeight: FontWeight.bold,
          color: getCategoryColor(),
        ),
      );
    }
  }

  Color getCategoryColor() {
    if (widget.bmi < 18.5) {
      return Colors.blue;
    } else if (widget.bmi >= 18.5 && widget.bmi < 24.9) {
      return Colors.green;
    } else if (widget.bmi >= 25 && widget.bmi < 29.9) {
      return Colors.orange;
    } else {
      return Colors.red;
    }
  }

  String getAdvice() {
    if (widget.bmi < 18.5) {
      return "You are underweight. Increase your calorie intake with protein-rich food and strength training. Eat nutrient-dense foods like nuts, avocados, and whole grains. Avoid skipping meals or relying solely on sugary snacks.";
    } else if (widget.bmi >= 18.5 && widget.bmi < 24.9) {
      return "Great! Your BMI is normal. Maintain a balanced diet and regular exercise. Eat a variety of fruits, vegetables, and lean proteins. Avoid excessive processed foods or high-sugar drinks.";
    } else if (widget.bmi >= 25 && widget.bmi < 29.9) {
      return "You're overweight. Try engaging in physical activities like jogging, swimming, or gym workouts. Eat more fiber-rich foods like vegetables, legumes, and whole grains. Avoid high-fat fast foods and sugary desserts.";
    } else {
      return "Your BMI is in the obese range. Consult a healthcare provider for personalized weight management guidance. Eat portion-controlled meals with lean proteins, vegetables, and healthy fats. Avoid processed carbs and excessive alcohol.";
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [Colors.teal, Colors.blueAccent],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
            ),
            child: Center(
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Card(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30)),
                  elevation: 20,
                  child: Padding(
                    padding: const EdgeInsets.all(30.0),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Text(
                          "Your BMI Result",
                          style: TextStyle(
                            fontSize: 32,
                            fontWeight: FontWeight.bold,
                            color: Colors.teal,
                          ),
                        ),
                        const SizedBox(height: 30),
                        TweenAnimationBuilder(
                          tween: Tween<double>(begin: 0, end: widget.bmi / 40),
                          duration: const Duration(milliseconds: 1500),
                          curve: Curves.easeOut,
                          builder: (context, value, child) {
                            return Stack(
                              alignment: Alignment.center,
                              children: [
                                SizedBox(
                                  height: 180,
                                  width: 180,
                                  child: CircularProgressIndicator(
                                    value: value,
                                    strokeWidth: 15,
                                    valueColor: AlwaysStoppedAnimation<Color>(
                                        getCategoryColor()),
                                    backgroundColor: Colors.grey[300],
                                  ),
                                ),
                                Text(
                                  widget.bmi.toStringAsFixed(1),
                                  style: const TextStyle(
                                    fontSize: 50,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black87,
                                  ),
                                ),
                              ],
                            );
                          },
                        ),
                        const SizedBox(height: 30),
                        getBMICategory(), // Updated to return a Widget with text and icon
                        const SizedBox(height: 20),
                        Text(
                          getAdvice(),
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                              fontSize: 18, color: Colors.black87),
                        ),
                        const SizedBox(height: 40),
                        ElevatedButton.icon(
                          icon: const Icon(Icons.refresh),
                          label: const Text("Calculate Again",
                              style: TextStyle(fontSize: 18)),
                          onPressed: () => Navigator.pop(context),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
          // Only show ConfettiWidget for "Normal" BMI
          if (widget.bmi >= 18.5 && widget.bmi < 24.9)
            Align(
              alignment: Alignment.topCenter,
              child: ConfettiWidget(
                confettiController: _confettiController,
                blastDirection: pi / 2,
                emissionFrequency: 0.05,
                numberOfParticles: 20,
                maxBlastForce: 50,
                minBlastForce: 20,
                colors: const [Colors.teal, Colors.blueAccent, Colors.white],
              ),
            ),
        ],
      ),
    );
  }
}

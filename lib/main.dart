import 'dart:core';
import 'quiz_brain.dart';
import 'package:flutter/material.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

void main() => runApp(Quizzler());

QuizBrain quizBrain = QuizBrain();

class Quizzler extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: Colors.grey.shade900,
        body: SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 10.0),
            child: QuizPage(),
          ),
        ),
      ),
    );
  }
}

class QuizPage extends StatefulWidget {
  @override
  _QuizPageState createState() => _QuizPageState();
}

class _QuizPageState extends State<QuizPage> {

  List<Icon> ScoreKepper = [];

  void checkAnswer(bool userPickAnswer){
    bool correctAnswer = quizBrain.getAnswer();
    setState(() {
      if (quizBrain.isFinished() == true) {
        Alert(
          context: context,
          title: 'Finished!',
          desc: 'You\'ve reached the end of the quiz.',
        ).show();

        quizBrain.reset();

        ScoreKepper = [];
      }
      else{
        if (userPickAnswer == correctAnswer){
          ScoreKepper.add(Icon(Icons.check, color: Colors.green));
        }else{
          ScoreKepper.add(Icon(Icons.close, color: Colors.red));
        }
        quizBrain.nextQuestion();
      };
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        Expanded(
          flex: 5,
          child: Padding(
            padding: EdgeInsets.all(10.0),
            child: Center(
              child: Text(
                quizBrain.getQuestion(),
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 25.0,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ),
        Expanded(
          child: Padding(
            padding: EdgeInsets.all(15.0),
            child: TextButton(
              style: TextButton.styleFrom(
                foregroundColor: Colors.white, // This sets the text color
                backgroundColor: Colors.green, // This sets the button color
                textStyle: TextStyle(
                  fontSize: 20.0,
                ),
              ),
              child: Text('True'),
              onPressed: () {
                // The user picked true.
                checkAnswer(true);
              },
            ),
          ),
        ),
        Expanded(
          child: Padding(
            padding: EdgeInsets.all(15.0),
            child: TextButton(
              style: TextButton.styleFrom(
                backgroundColor: Colors.red, // This sets the button color
                foregroundColor: Colors.white, // This sets the text color
                textStyle: TextStyle(
                  fontSize: 20.0,
                ),
              ),
              child: Text('False'),
              onPressed: () {
                // The user picked true.
                checkAnswer(false);
              },
            ),
          ),
        ),
        Row(
          children: ScoreKepper,
        ),
        //TODO: Add a Row here as your score keeper
      ],
    );
  }
}

/*
question1: 'You can lead a cow down stairs but not up stairs.', false,
question2: 'Approximately one quarter of human bones are in the feet.', rute,
question3: 'A slug\'s blood is green.', true,
*/

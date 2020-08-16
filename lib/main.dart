import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

import 'Quiz_Brain.dart';

void main() => runApp(Quizzler());

class Quizzler extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: Text(
            'Quizzler',
            textAlign: TextAlign.center,
          ),
          backgroundColor: Colors.blueGrey,
        ),
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
  List<Widget> scoreKeeper = [];

//  List<bool> questionsAnswer = [false, true, true];
//
//  List<String> questionBank = [
//    'You can lead a cow down stairs but not up stairs.',
//    'Approximately one quarter of human bones are in the feet.',
//    'A slug\'s blood is green.'
//  ];
//
//  Questions q1 = Questions(q: '', a: false);

  int correctAnswerCount = 0;
  void checkAnswer(bool userPickedAnswer) {
    setState(() {
      bool correctAnswer = brain.getQuestionAnswers();
      //The user picked true.
      if (!isFinished(brain.getCurrentNum())) {
        if (correctAnswer == userPickedAnswer) {
          correctAnswerCount++;
          print("Right Answer and correct answer count is $correctAnswerCount");
          scoreKeeper.add(Icon(
            Icons.check,
            color: Colors.green,
          ));
        } else {
          print("wrong!!!");
          scoreKeeper.add(Icon(Icons.close, color: Colors.red));
        }
      } else {
        Alert(
          context: context,
          title: 'FINISHED',
          desc:
              'You have reached end of Quiz. Your total score was $correctAnswerCount',
        ).show();
        brain.setCurrentQuestion(0);
        scoreKeeper.clear();
        correctAnswerCount = 0;
      }

      brain.updateCurrentQuestion();
    });
  }

  int getNewQuestion() {
    int ran = Random().nextInt(2);
    return ran;
  }

  bool isFinished(int currentQuestion) {
    if (brain.getCurrentNum() == brain.getQuestionBankLength() - 1) {
      return true;
    }
    else
      return false;
  }


  QuizBrain brain = QuizBrain();

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        Expanded(
          flex: 6,
          child: Padding(
            padding: EdgeInsets.all(10.0),
            child: Center(
              child: Text(
                brain.getQuestionText(),
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
            child: FlatButton(
              textColor: Colors.white,
              color: Colors.green,
              child: Text(
                'True',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20.0,
                ),
              ),
              onPressed: () {
                checkAnswer(true);
              },
            ),
          ),
        ),
        Expanded(
          child: Padding(
            padding: EdgeInsets.all(15.0),
            child: FlatButton(
              color: Colors.red,
              child: Text(
                'False',
                style: TextStyle(
                  fontSize: 20.0,
                  color: Colors.white,
                ),
              ),
              onPressed: () {
                //The user picked false.
                checkAnswer(false);
              },
            ),
          ),
        ),
        //TODO: Stop the Row to get increase.
        Row(
          children: scoreKeeper,
        )
      ],
    );
  }
}

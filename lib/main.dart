import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

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

  int getNewQuestion() {
    int ran = Random().nextInt(2);
    return ran;
  }

  QuizBrain brain = QuizBrain();

  int currentQuestionNum = 0;

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
                brain.questionList[currentQuestionNum].questionText,
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
                bool correctAnswer =
                    brain.questionList[currentQuestionNum].questionAnswer;
                //The user picked true.
                if (correctAnswer &&
                    currentQuestionNum < brain.questionList.length - 1) {
                  print("Right Answer");
                  scoreKeeper.add(Icon(
                    Icons.check,
                    color: Colors.green,
                  ));
                } else {
                  print("wrong!!!");
                  scoreKeeper.add(Icon(Icons.close, color: Colors.red));
                }
                setState(() {
                  print(brain.questionList.length);
                  if (currentQuestionNum < brain.questionList.length - 1) {
                    currentQuestionNum++;
                  }
                });
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
                bool correctAnswer =
                    brain.questionList[currentQuestionNum].questionAnswer;
                if (!correctAnswer &&
                    currentQuestionNum < brain.questionList.length - 1) {
                  print("Right Answer");
                  scoreKeeper.add(Icon(Icons.check, color: Colors.green));
                } else {
                  print("wrong!!!");
                  scoreKeeper.add(Icon(
                    Icons.close,
                    color: Colors.red,
                  ));
                }
                setState(() {
                  if (currentQuestionNum < brain.questionList.length - 1) {
                    currentQuestionNum++;
                  }
                });
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

/*
 'You can lead a cow down stairs but not up stairs.', false,
 'Approximately one quarter of human bones are in the feet.', true,
 'A slug\'s blood is green.', true,
*/

import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

void main() {
  runApp(MaterialApp(
    home: QuestionsPage(),
  ));
}

class QuestionsPage extends StatefulWidget {
  @override
  _QuestionsPageState createState() => _QuestionsPageState();
}

double sum = 0;
int i = 0;
double _currentSliderValue = 0;

class _QuestionsPageState extends State<QuestionsPage> {
  String buttonText = "Next";
  List<Question> questionList = [
    Question("Rate the UI of this App on a scale of 5", 0),
    Question("How would you rate your online campus life", 0),
    Question("How would you rate your offline campus life", 0),
    Question("How many best friend do you have?", 0),
    Question("How many hours do you study in a day?", 0),
    Question("How many hours do you play video games?", 0),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue,
      appBar: AppBar(
        title: Text(
          "FeedBack App",
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        backgroundColor: Colors.red,
      ),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(30.0, 30.0, 30.0, 30.0),
        child: Center(
          child: Column(
            children: [
              Expanded(
                flex: 1,
                child: SizedBox(),
              ),
              Expanded(
                flex: 1,
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20.0),
                    gradient: LinearGradient(
                      colors: [Colors.amber[400]!, Colors.amber[600]!],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                    border: Border.all(width: 3.0, color: Colors.red),
                  ),
                  padding: EdgeInsets.all(10.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Q${i + 1} ${questionList[i].que}",
                        style: TextStyle(
                          fontSize: 20.0,
                          fontWeight: FontWeight.bold,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      Slider(
                        value: _currentSliderValue,
                        min: 0,
                        max: 5,
                        divisions: 5,
                        label: _currentSliderValue.round().toString(),
                        activeColor: Colors.red,
                        inactiveColor: Colors.red[100],
                        onChanged: (double value) {
                          setState(() {
                            _currentSliderValue = value;
                          });
                        },
                      ),
                      ElevatedButton(
                          onPressed: () {
                            setState(() {
                              if (i < (questionList.length - 2)) {
                                questionList[i].rating = _currentSliderValue;
                                i++;
                              } else if (i < (questionList.length - 1)) {
                                questionList[i].rating = _currentSliderValue;
                                buttonText = "Finish";
                                i++;
                              } else {
                                questionList[i].rating = _currentSliderValue;
                                for (int j = 0; j < questionList.length; j++) {
                                  sum += questionList[j].rating;
                                }
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => Result()),
                                );
                              }
                            });
                          },
                          child: Text("$buttonText"),
                          style: ButtonStyle(
                            foregroundColor:
                                MaterialStateProperty.all<Color>(Colors.white),
                            backgroundColor:
                                MaterialStateProperty.all<Color>(Colors.red),
                          )),
                    ],
                  ),
                ),
              ),
              Expanded(
                flex: 1,
                child: SizedBox(),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class Question {
  String que;
  double rating;

  Question(this.que, this.rating);
}

class Result extends StatefulWidget {
  const Result({Key? key}) : super(key: key);

  @override
  _ResultState createState() => _ResultState();
}

class _ResultState extends State<Result> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue,
      appBar: AppBar(
        title: Text(
          "FeedBack App",
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        backgroundColor: Colors.red,
      ),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(30.0, 30.0, 30.0, 30.0),
        child: Center(
          child: Column(
            children: [
              Expanded(
                flex: 1,
                child: SizedBox(),
              ),
              Expanded(
                flex: 1,
                child: Expanded(
                  flex: 1,
                  child: Row(
                    children: [
                      Expanded(
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20.0),
                            gradient: LinearGradient(
                              colors: [Colors.grey[400]!, Colors.grey[600]!],
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                            ),
                            border: Border.all(width: 3.0, color: Colors.red),
                          ),
                          padding: EdgeInsets.all(10.0),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                "Result: ${sum.round()}",
                                style: TextStyle(
                                  fontSize: 20.0,
                                  fontWeight: FontWeight.bold,
                                ),
                                textAlign: TextAlign.center,
                              ),
                              display(),
                              ElevatedButton(
                                  onPressed: () {
                                    i = 0;
                                    sum = 0;
                                    _currentSliderValue = 0.0;
                                    Navigator.pop(context);
                                  },
                                  child: Text("Reset"),
                                  style: ButtonStyle(
                                    foregroundColor:
                                        MaterialStateProperty.all<Color>(
                                            Colors.white),
                                    backgroundColor:
                                        MaterialStateProperty.all<Color>(
                                            Colors.red),
                                  )),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Expanded(
                flex: 1,
                child: SizedBox(),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget display() {
    if (sum <= 10) {
      return Center(
        child: Container(
            margin: EdgeInsets.all(20.0),
            child: Text(
              'We are sorry for your inconvenience.',
              style: TextStyle(
                  fontSize: 20, color: Colors.red, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            )),
      );
    } else if (sum >= 11 && sum <= 20) {
      return Center(
        child: Container(
            margin: EdgeInsets.all(20.0),
            child: Text(
              'Hope we serve you better next time.',
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontSize: 20,
                  color: Colors.yellowAccent.shade700,
                  fontWeight: FontWeight.bold),
            )),
      );
    } else {
      return Center(
        child: Container(
            margin: EdgeInsets.all(20.0),
            child: Text(
              'We hope you come back next time.',
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontSize: 20,
                  color: Colors.green,
                  fontWeight: FontWeight.bold),
            )),
      );
    }
  }
}

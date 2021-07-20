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

class _QuestionsPageState extends State<QuestionsPage> {
  int i = 0;
  double _currentSliderValue = 0;
  String buttonText = "Next";
  double sum = 0;
  bool completed = false;
  List<Question> questionList = [
    Question("Rate the UI of this App1", 0),
    Question("Rate the UI of this App2", 0),
    Question("Rate the UI of this App3", 0),
    Question("Rate the UI of this App4", 0),
    Question("Rate the UI of this App5", 0),
    Question("Rate the UI of this App6", 0),
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
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Q${i + 1} ${questionList[i].que}",
                        style: TextStyle(
                          fontSize: 20.0,
                          fontWeight: FontWeight.bold,
                        ),
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
                            questionList[i].rating = value;
                          });
                        },
                      ),
                      ElevatedButton(
                          onPressed: () {
                            setState(() {
                              if (i < (questionList.length - 2))
                                i++;
                              else if (i < (questionList.length - 1)) {
                                buttonText = "Finish";
                                i++;
                              } else {
                                buttonText = "Reset";
                                completed = true;
                                for (int j = 0; j < questionList.length; j++) {
                                  sum += questionList[j].rating;
                                }
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

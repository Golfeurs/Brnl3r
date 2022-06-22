import 'package:flutter/material.dart';
import 'package:brnl3r/services/implementation/fetch_settings.dart';
import 'package:brnl3r/services/implementation/http_request_to_QA.dart';

class TrivialDialog extends StatefulWidget {
  const TrivialDialog({Key? key}) : super(key: key);

  @override
  State<TrivialDialog> createState() => _TrivialDialogState();
}

class _TrivialDialogState extends State<TrivialDialog> {
  int? questionAmount = 6;

  String? difficulty = "medium";

  int questionNumber = 1;

  int correctAnswers = 0;

  int? selectIndex;

  String question = "Loading...";

  List<int> indices = [];

  String url =
      "https://opentdb.com/api.php?amount=1&difficulty=easy&type=multiple";

  List<String> answers = [];

  String correctAnswer = "";

  @override
  void initState() {
    getPreferences();
    url =
        "https://opentdb.com/api.php?amount=1&difficulty=$difficulty&type=multiple";
    getData(url, setState);
    super.initState();
  }

  void getPreferences() async {
    String? tempQuestionAmount = await FetchSettings().getQuestionAmount();
    if (tempQuestionAmount is String) {
      questionAmount = int.parse(tempQuestionAmount);
    }

    difficulty = await FetchSettings().getQuestionDifficulty();
  }

  @override
  Widget build(BuildContext context) {
    return trivialDialog();
  }

  StatefulBuilder trivialDialog() {
    return StatefulBuilder(builder: ((context, setState) {
      return AlertDialog(
        title: Text("$questionNumber/$questionAmount | $correctAnswers"),
        content: _pageBuilder(setState, context),
      );
    }));
  }

  GestureDetector _pageBuilder(StateSetter setState, BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: () {
        if (selectIndex is int) {
          _refreshPage(setState, context);
        }
      },
      child: IgnorePointer(
        ignoring: (selectIndex is int),
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(4.0),
            child: Column(children: [
              Flexible(
                flex: 1,
                child: Center(
                  child: Text(question,
                      style: Theme.of(context).textTheme.headlineSmall,
                      textAlign: TextAlign.center),
                ),
              ),
              Flexible(
                flex: 1,
                child: Column(
                  children: indices
                      .map((i) => Expanded(
                            child: _buttonBuilder(setState, i, context),
                          ))
                      .toList(),
                ),
              )
            ]),
          ),
        ),
      ),
    );
  }

  GestureDetector _buttonBuilder(
      StateSetter setState, int i, BuildContext context) {
    final Color pressed = (selectIndex == i) ? Colors.red : Colors.blue;
    final Color buttonColor =
        (i == 0) && (selectIndex is int) ? Colors.green : pressed;

    return GestureDetector(
        onTap: () => _showAnswer(setState, i),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 250),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20), color: buttonColor),
          width: MediaQuery.of(context).size.width * 0.9,
          margin: const EdgeInsets.all(10),
          child: FittedBox(
            fit: BoxFit.contain,
            child: Padding(
              padding: const EdgeInsets.all(4.0),
              child: Text(answers[i],
                  textAlign: TextAlign.center,
                  style: const TextStyle(color: Colors.white)),
            ),
          ),
        ));
  }

  void _showAnswer(StateSetter setState, int i) {
    return setState(() {
      selectIndex = i;
      if (selectIndex == 0) {
        correctAnswers += 1;
      }
    });
  }

  void _refreshPage(StateSetter setState, BuildContext context) {
    return setState(() {
      if (questionNumber == questionAmount) {
        Navigator.of(context).pop(correctAnswers);
        return;
      }
      questionNumber += 1;
      selectIndex = null;
      question = "Loading...";
      indices = [];
      getData(url, setState);
    });
  }

  void getData(String url, Function setState) async {
    List<Map<String, List<String>>> data =
        await HttpRequestToQA().getQAFromUrl(url);

    setState(() {
      var checkedData = data[0];
      question = checkedData.keys.first;
      answers = checkedData[question] as List<String>;
      correctAnswer = answers[0];
      indices = [];
      for (int i = 0; i < answers.length; i++) {
        indices.add(i);
      }
      indices.shuffle();
    });
  }
}

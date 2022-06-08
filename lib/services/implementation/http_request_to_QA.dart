// Takes URL and returns Q&A array as {Question, [correct answer, wrong answers,...]}

import 'package:brnl3r/models/q_and_a.dart';
import 'package:brnl3r/services/interfaces/http_request_to_QA_interface.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

const URL =
    "https://opentdb.com/api.php?amount=6&difficulty=medium&type=multiple";

void main() async {
  var questions = await getQAFromUrl(URL);
  for (final entry in questions) {
    print(entry);
  }
}

//class HttpRequestToQA implements HttpRequestToQAInterface {
Future<Questions> getQAFromUrl(var url) async {
  var decoded = await jsonParser(url);
  Questions questions = [];

  for (final entry in decoded) {
    Question question = {};
    List<String> answers = [];
    answers.add(entry["correct_answer"]);
    for (final iAnswer in entry["incorrect_answers"]) {
      answers.add(iAnswer);
    }
    question[entry["question"]] = answers;
    questions.add(question);
  }

  return questions;
}

Future<List<dynamic>> jsonParser(String url) async {
  var response = await httpRequest(url);
  var json = jsonDecode(response.body);
  assert(json is Map<String, dynamic>);
  var results = json["results"];

  return results;
}

Future<http.Response> httpRequest(String url) async {
  var response = await http.get(Uri.parse(url));

  return response;
}
//}

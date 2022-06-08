// Takes URL and returns Q&A array as {Question, [correct answer, wrong answers,...]}

import 'package:brnl3r/models/q_and_a.dart';
import 'package:brnl3r/services/interfaces/http_request_to_QA_interface.dart';
import 'package:html_unescape/html_unescape.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

// void main(List<String> args) async {
//   Questions questions = await getQAFromUrl(
//       "https://opentdb.com/api.php?amount=6&difficulty=easy&type=multiple");

//   for (final entry in questions) {
//     print(entry);
//   }
// }

class HttpRequestToQA implements HttpRequestToQAInterface {
  @override
  Future<Questions> getQAFromUrl(var url) async {
    var unescape = HtmlUnescape();

    var decoded = await _jsonParser(url);
    Questions questions = decoded.map((entry) {
      Question question = {};
      String correct = unescape.convert(entry["correct_answer"]);
      var incorrect = entry["incorrect_answers"]
          .map((iAnswer) => unescape.convert(iAnswer))
          .toList();
      question[unescape.convert(entry["question"])] = [correct, ...incorrect];
      return question;
    }).toList();

    return questions;
  }

  Future<List<dynamic>> _jsonParser(String url) async {
    var response = await _httpRequest(url);
    var json = jsonDecode(response.body);
    assert(json is Map<String, dynamic>);
    var results = json["results"];

    return results;
  }

  Future<http.Response> _httpRequest(String url) async {
    var response = await http.get(Uri.parse(url));

    return response;
  }
}

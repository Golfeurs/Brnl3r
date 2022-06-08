// Interface
// Takes URL and returns Q&A array [(Q;A),...]

import 'package:brnl3r/models/q_and_a.dart';

abstract class HttpRequestToQAInterface {
  Future<Questions> getQAFromUrl(var url);
}

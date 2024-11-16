import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_welcome/exception/http_exception.dart';
import 'package:flutter_welcome/screen/question_screen/question_page.dart';
import 'package:flutter_welcome/service/http_service.dart';

import '../../../di/get_it.dart';

class RootProvider with ChangeNotifier {
  String get sessionId => _sessionId;
  late String _sessionId;
  final _navigator = getIt<NavigationService>();
  void onStart() async {
    var _response = await HttpService.request(
        method: HttpMethod.post,
        url: '${dotenv.get('BASE_URL')}/api/v1/Quiz/Session',
        log: 'post on /api/v1/Quiz/Session');
    var body = jsonDecode(_response.body);
    _sessionId = body['data']['sessionId'];
    _navigator.navigatorKey.currentState!.push(QuestionPage.route());
  }
}

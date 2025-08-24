import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:logging/logging.dart';

import 'base_object.dart';

class AppLogger {
  final String category;
  late Logger _logger;

  AppLogger(this.category) {
    _logger = Logger(category);
  }

  String _convertToJson(Object? object) {
    try {
      if (object != null) {
        if (object is BaseObject) {
          return json.encode(object);
        }
        return object.toString();
      }
      return '';
    } on Exception {
      return object.toString();
    }
  }

  void info(String message, [Object? object]) {
    var content = object != null ? '${DateTime.now().toString()}: $message - ${_convertToJson(object)}' : '${DateTime.now().toString()}: $message';
    _logger.info(content);
  }

  //debug
  void debug(String message, [Object? object]) {
    //if current runtime mode is debug
    if (kDebugMode) {
      info(message, object);
    }
  }
}

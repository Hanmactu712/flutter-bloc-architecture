import 'dart:convert';
import 'package:app_core/app_core.dart';
import 'package:crypto/crypto.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc_architecture_template/src/common/app_router.dart';
import 'package:flutter_bloc_architecture_template/src/pages/home/home_page.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';

class Utils {
  static String formatCurrency(double amount) {
    var numberFormat = NumberFormat("#,##0", "en_US");
    var formattedAmount = numberFormat.format(amount);
    return formattedAmount;
  }

  static String formatDateTime(DateTime dateTime, {String format = "dd/MM/yyyy"}) {
    var dateFormat = DateFormat(format);
    return dateFormat.format(dateTime);
  }

  static String sha256Hash(String input) {
    return sha256.convert(utf8.encode(input)).toString();
  }

  static getStartDateOfWeek(DateTime startDate, int iterationDue) {
    var actualDue = iterationDue == 1 ? 7 : iterationDue - 1;
    var day = startDate.weekday;
    var diff = actualDue - day;
    if (diff < 0) {
      diff = 7 + diff;
    }
    return startDate.add(Duration(days: diff));
  }
}

//string? extension
extension StringExtension on String? {
  bool get isNullOrEmpty {
    return this == null || this!.isEmpty;
  }
}

//list? extension
extension ListExtension<T> on List<T>? {
  bool get isNullOrEmpty {
    return this == null || this!.isEmpty;
  }
}

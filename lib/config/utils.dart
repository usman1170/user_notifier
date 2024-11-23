import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

String calculateDays(String date) {
  try {
    DateFormat inputFormat = DateFormat("dd-MM-yyyy");
    DateTime parsedDate = inputFormat.parse(date);
    DateTime now = DateTime.now();
    int difference = now.difference(parsedDate).inDays;
    if (difference > 0) {
      return "$difference days ago";
    } else {
      return DateFormat("dd-MM-yyyy").format(parsedDate);
    }
  } catch (e) {
    return "Invalid date";
  }
}

Future<String> pickDate(BuildContext context) async {
  FocusScope.of(context).requestFocus(FocusNode());
  DateTime? pickedDate = await showDatePicker(
    context: context,
    initialDate: DateTime.now(),
    firstDate: DateTime.now().subtract(const Duration(days: 90)),
    lastDate: DateTime.now().add(const Duration(days: 90)),
  );
  if (pickedDate != null) {
    return "${pickedDate.day}-${pickedDate.month}-${pickedDate.year}";
  }
  return "";
}

import 'package:app/models/card_model.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

String formatDateTime(DateTime? dateTime) {
  if (dateTime != null) {
    return "${dateTime.year}-${dateTime.month.toString().padLeft(2, '0')}-${dateTime.day.toString().padLeft(2, '0')}T${dateTime.hour.toString().padLeft(2, '0')}:${dateTime.minute.toString().padLeft(2, '0')}:${dateTime.second.toString().padLeft(2, '0')}.${dateTime.millisecond.toString().padLeft(3, '0')}Z";
  } else {
    return "";
  }
}

String formatDatetimeOutput(DateTime datetime){
  return DateFormat("yyyy-MM-dd'T'HH:mm:ss.SSS'Z'").format(datetime.toUtc());
}

Future<void> selectStartDate(BuildContext context, TextEditingController startDateController, ShortCard card) async {
  DateTime initialDate = startDateController.text.isNotEmpty ? DateTime.parse(startDateController.text) : DateTime.now();
  final DateTime? pickedStartDate = await showDatePicker(
    context: context,
    initialDate: initialDate,
    firstDate: DateTime(2000),
    lastDate: DateTime(2101),
  );
  if (pickedStartDate != null) {
    final TimeOfDay? pickedStartTime = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.fromDateTime(initialDate),
    );
    if (pickedStartTime != null) {
      final startDateTime = DateTime(
        pickedStartDate.year,
        pickedStartDate.month,
        pickedStartDate.day,
        pickedStartTime.hour,
        pickedStartTime.minute,
      );
      startDateController.text = startDateTime.toString().substring(0, 16);
      final output = formatDatetimeOutput(startDateTime);
      //update si la date change (callAPI)
      print("New Start Date: $output");
    } else {
      // L'utilisateur a annulé la sélection de l'heure
      print("Start Time selection cancelled");
    }
  } else {
    // L'utilisateur a annulé la sélection de la date
    print("Start Date selection cancelled");
  }
}

Future<void> selectDueDate(BuildContext context, TextEditingController dueDateController, ShortCard card) async {
  DateTime initialDate = dueDateController.text.isNotEmpty ? DateTime.parse(dueDateController.text) : DateTime.now();
  final DateTime? pickedDueDate = await showDatePicker(
    context: context,
    initialDate: initialDate,
    firstDate: DateTime(2000),
    lastDate: DateTime(2101),
  );
  if (pickedDueDate != null) {
    final TimeOfDay? pickedDueTime = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.fromDateTime(initialDate),
    );
    if (pickedDueTime != null) {
      final dueDateTime = DateTime(
        pickedDueDate.year,
        pickedDueDate.month,
        pickedDueDate.day,
        pickedDueTime.hour,
        pickedDueTime.minute,
      );
      dueDateController.text = dueDateTime.toString().substring(0, 16);
      final output = formatDatetimeOutput(dueDateTime);
      //update si la date change (callAPI)
      print("New Due Date: $output");
    } else {
      // L'utilisateur a annulé la sélection de l'heure
      print("Due Time selection cancelled");
    }
  } else {
    // L'utilisateur a annulé la sélection de la date
    print("Due Date selection cancelled");
  }
}
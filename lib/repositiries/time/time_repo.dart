import 'dart:async';

import 'package:intl/intl.dart';

import '../../generated/l10n.dart';


class HandlingTime {
  final String? time;

  HandlingTime({this.time});

  String handleTime() {
    List<String> formatedTime =
        time!.replaceFirst("TimeOfDay(", "").replaceFirst(")", "").split(":");
    //print"hour: ${formatedTime[0]}\nminute: ${formatedTime[1]}");
    DateTime timeFormatted = DateTime(
        0, 0, 0, int.parse(formatedTime[0]), int.parse(formatedTime[1]), 0);
    String result = DateFormat('HH:mm:ss').format(timeFormatted);
    return result;
  }

  callAtSpecificTime(
      /* {required DateTime date} */ {required Function callAtSpecificTime}) {
    // Get the current time
    DateTime now = DateTime.now();

    // Calculate the next 12 PM (noon)
    DateTime next12PM = DateTime(now.year, now.month, now.day, 13, 53, 0);

    // If the current time is after 12 PM, schedule for the next day
    if (now.isAfter(next12PM)) {
      next12PM = next12PM.add(const Duration(days: 1));
    }

    // Calculate the difference between now and 12 PM
    Duration durationUntil12PM = next12PM.difference(now);

    // Schedule the function call at 12 PM
    Timer(durationUntil12PM, callAtSpecificTime());
  }

  String formatDuration(Duration duration) {
    int hours =
        duration.inHours.remainder(24); // remaining hours after taking out days
    int minutes = duration.inMinutes
        .remainder(60); // remaining minutes after taking out hours
    return "${S.current.hours}: $hours ${S.current.minutes}: $minutes";
  }
  String formatDurationPrint(Duration duration){
    int hours =
        duration.inHours.remainder(24); // remaining hours after taking out days
    int minutes = duration.inMinutes
        .remainder(60); // remaining minutes after taking out hours
    return "Hours: $hours Minutes: $minutes";
  
  }
}

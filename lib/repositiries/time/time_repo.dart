import 'package:intl/intl.dart';

class HandlingTime {
  final String time;

  HandlingTime({required this.time});

  String handleTime() {
    List<String> formatedTime =
        time.replaceFirst("TimeOfDay(", "").replaceFirst(")", "").split(":");
    //print"hour: ${formatedTime[0]}\nminute: ${formatedTime[1]}");
    DateTime timeFormatted = DateTime(
        0, 0, 0, int.parse(formatedTime[0]), int.parse(formatedTime[1]), 0);
    String result = DateFormat('HH:mm:ss').format(timeFormatted);
    return result;
  }
}

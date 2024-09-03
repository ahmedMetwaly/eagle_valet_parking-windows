import 'package:intl/intl.dart';

class HandlingDate {
  final String date;

  HandlingDate({required this.date});
  DateTime fromStringToDate() {
    //printdate);
    DateTime formattedDate = DateFormat('yyyy-MM-dd').parse(date);
    return formattedDate;
  }

  String handleDate() {
    DateTime formattedDate = DateFormat('yyyy-MM-dd').parse(date);
    String convertedDate = DateFormat('d MMMM yyyy').format(formattedDate);
    String ordinalDate =
        convertedDate.replaceFirstMapped(RegExp(r'\d+'), (match) {
      int day = int.parse(match.group(0) ?? "0");
      String suffix = getOrdinalSuffix(day);
      return '$day$suffix';
    });
    return ordinalDate;
    // prints 30th June 2024
  }

  String convertDate() {
    String dateString = date;
    List<String> splittedDate = dateString.toString().split(" ");
    String day = splittedDate[0]
        .replaceFirst('st', '')
        .replaceFirst('nd', '')
        .replaceFirst('rd', '')
        .replaceFirst('th', '');
    dateString = "$day ${splittedDate[1]} ${splittedDate[2]}";
    DateTime dateTime = DateFormat('d MMMM yyyy').parse(dateString);
    String formattedDate = DateFormat('yyyy-MM-dd').format(dateTime);
    return formattedDate;
  }

  String getOrdinalSuffix(int number) {
    if (number >= 11 && number <= 13) {
      return 'th';
    }
    switch (number % 10) {
      case 1:
        return 'st';
      case 2:
        return 'nd';
      case 3:
        return 'rd';
      default:
        return 'th';
    }
  }
}

import 'package:intl/intl.dart';

class HandlingDate {
  final String date;

  HandlingDate({required this.date});
  DateTime fromStringToDate() {
    //printdate);
    DateTime formattedDate = DateFormat('yyyy-MM-dd hh:mm').parse(date);
    return formattedDate;
  }

  //if you have minutes as integer Duration(minutes:your number)

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

  DateTime convertToDateTime(String time) {
    //input 8th September 2024
    Map months = {
      "Jan": "01",
      "Feb": "02",
      "Mar": "03",
      "May": "05",
      "Jun": "06",
      "Jul": "07",
      "Aug": "08",
      "Sep": "09",
      "Oct": "10",
      "Nov": "11",
      "Dec": "12",
    };
    String dateString = date;
    List<String> splittedDate = dateString.toString().split(" ");
    String day = splittedDate[0]
        .replaceFirst('st', '')
        .replaceFirst('nd', '')
        .replaceFirst('rd', '')
        .replaceFirst('th', '');
    if (int.parse(day) < 10) {
      day = '0$day';
    }
    print("day:$day");
    String month = months[splittedDate[1].substring(0, 3)];
print("month:$month");
    List<String> splittedTime = time.toString().split(":");
    String hour = splittedTime[0];
    String minute = splittedTime[1];
    if (int.parse(hour) < 10) {
      hour = '0$hour';
    }
    print("hour:$hour");
    if (int.parse(minute) < 10) {
      minute = '0$minute';
    }
    print("minute:$minute");
    dateString = "${splittedDate[2]}-$month-$day";
    DateTime dateTime = DateTime(
      int.parse(splittedDate[2]),
      int.parse(month),
      int.parse(day),
      int.parse(hour),
      int.parse(minute),
    );
    // output 2024-09-08 21:00:00.000
    return dateTime;
  }

  DateTime convertToDateTime2() {
    //input  2024-09-08 20:58:57.355114
    DateTime dateTime;
    List<String> splitted = date.split(" ");
    String splittedDate = splitted[0];
    String splittedTime = splitted[1];
    List<String> splittedDate2 = splittedDate.split("-");
    List<String> splittedTime2 = splittedTime.split(":");
    dateTime = DateTime(
      int.parse(splittedDate2[0]),
      int.parse(splittedDate2[1]),
      int.parse(splittedDate2[2]),
      int.parse(splittedTime2[0]),
      int.parse(splittedTime2[1]),
    );
    // output 2024-09-08 20:58:00
    return dateTime;
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

  String formatDateInArabic() {
    try {
      // Parse the date string from Firebase
      DateTime dateInArabic = DateTime.parse(date);

      // Format the date for Arabic locale
      String formattedDate = DateFormat.yMMMEd('ar').format(dateInArabic);
      print(formattedDate);
      return formattedDate;
    } catch (e) {
      print("Error formatting date: $e");
      return date; // Return the original if parsing fails
    }
  }

  String convertArabicToEnglishDate() {
    try {
      // Define a date format for the Arabic date
      DateFormat arabicFormat = DateFormat('EEEE، d MMMM yyyy', 'ar');

      // Parse the Arabic date string into a DateTime object
      DateTime parsedDate = arabicFormat.parse(date);

      // Define the format for the English date with "th"
      DateFormat englishFormat = DateFormat('d\'th\' MMMM yyyy', 'en_US');

      // Format the date in English
      return englishFormat.format(parsedDate);
    } catch (e) {
      print("Error parsing Arabic date: $e");

      throw Exception("Error parsing Arabic date: $e");
    }
  }

  String convertEnglishToArabicDate(String englishDate) {
    try {
      // Define the format for the English date with "th"
      DateFormat englishFormat = DateFormat('d\'th\' MMMM yyyy', 'en_US');

      // Parse the English date string into a DateTime object
      DateTime parsedDate = englishFormat.parse(englishDate);

      // Define a date format for the Arabic date
      DateFormat arabicFormat = DateFormat('EEEE، d MMMM yyyy', 'ar');

      // Format the date in Arabic
      return arabicFormat.format(parsedDate);
    } catch (e) {
      print("Error parsing English date: $e");

      throw Exception("Error parsing English date: $e");

      // return englishDate; // Return original if parsing fails
    }
  }
}

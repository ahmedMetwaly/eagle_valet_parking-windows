import 'package:intl/intl.dart';

class DateDifference {
  int differenceBetweenDates(
      {required String enterDate,
      required String enterTime,
      required String leaveDate,
      required String leaveTime}) {
    late final int difference;
    final expiredAt =
        DateFormat('yyyy-MM-dd HH:mm').parse("$leaveDate $leaveTime");
    final startAt =
        DateFormat('yyyy-MM-dd HH:mm').parse("$enterDate $enterTime");
    difference = expiredAt.difference(startAt).inSeconds;

    /* if (DateTime.now().difference(startAt).inMinutes < 0) {
      //future
      state.insert(0, "future");
      state.insert(1, difference);
    } else if (DateTime.now().difference(startAt).inMinutes > 0 &&
        expiredAt.difference(DateTime.now()).inMinutes > 0) {
      //active
      difference = expiredAt.difference(DateTime.now()).inMinutes;
      state.insert(0, "active");
      state.insert(1, difference);
    } else if (DateTime.now().difference(expiredAt).inMinutes > 0) {
      //expired
      state.insert(0, "expired");
      state.insert(1, 0);
    } else {
      //expired
      state.insert(0, "expired");
      state.insert(1, 0);
    }
    return state;
  } */
  
    return difference;
  }
}

import 'dart:async';

import 'package:eagle_valet_parking/bloc/authentication_bloc/auth_bloc.dart';
import 'package:eagle_valet_parking/bloc/parking_cubit/parking_states.dart';
import 'package:eagle_valet_parking/models/parking_model.dart';
import 'package:eagle_valet_parking/repositiries/date/date_format.dart';
import 'package:eagle_valet_parking/repositiries/parking_repos/parking_repo.dart';
import 'package:eagle_valet_parking/repositiries/parking_repos/print_repo.dart';
import 'package:eagle_valet_parking/repositiries/time/time_repo.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

import '../../repositiries/translate_nmerical/translte_numericale.dart';

class ParkingCubit extends Cubit<ParkingStates> {
  ParkingCubit() : super(InitialParkingState());
  ParkingModel parking = ParkingModel();
  String parkingId = AuthenticationBloc.employer.parkingId!;
  void callAtTime() {
    try {
      String? enDate;
      String? enTime;
      DateTime? dateTimeEn;
      DateTime? at12PM;
      if (Intl.getCurrentLocale() == "ar") {
        String arDate =
            HandlingDate(date: DateTime.now().toString()).formatDateInArabic();
        enDate = HandlingDate(date: arDate).convertArabicToEnglishDate();
        String arTime =
            HandlingTime(time: TimeOfDay.now().toString()).handleTime();
        enTime = TranslteNumericaleRepo().arabicToEnglishNumerals(arTime);
        dateTimeEn = HandlingDate(date: enDate).convertToDateTime(enTime);
        print("dateTimeEnd: $dateTimeEn");
        at12PM = DateTime(
            dateTimeEn.year, dateTimeEn.month, dateTimeEn.day, 0, 0, 0);
        print("english date: $enDate");
        print("enTime: $enTime");
      }
      at12PM ??= DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day, 0, 0, 0);
      print(parking.capacity);
      if (at12PM.isBefore(dateTimeEn?? DateTime.now())) {
        print("i'm done");
      } else {
        Timer(at12PM.difference(dateTimeEn ?? DateTime.now()), () async {
          Map<String, dynamic> fieldsToUpdate = {
            "emptyParking": parking.capacity,
            "occupidParking": 0,
            "totalCustomersOfToday": 0,
          };
          await ParkingRepo().updateFields(
              parkingId: parkingId, fieldsToUpdate: fieldsToUpdate);
          await ParkingRepo()
              .updateIncome(parkingId: parkingId, income: 0)
              .then((value) async {
            await readParkingData();
          });
          print("i will be 0");
        });
      }
    } catch (error) {
      emit(ErrorParkingState(error: error.toString()));
    }
  }

  Future readParkingData() async {
    try {
      emit(LoadingParkingState());

      print("start");
      await ParkingRepo().readParkingData(parkingId).then((value) {
        print("then");
        if (value is ParkingModel) {
          parking = value;
          print("parking that the employer works ${parking.parkingName}");
          emit(ParkingLoadedState(parking: parking));
        } else {
          emit(ErrorParkingState(error: "Error while reading parking data"));
        }
      });
    } catch (error) {
      emit(ErrorParkingState(error: error.toString()));
    }
  }

  //TODO:: calculation
  Future printTicket() async {
    try {
      emit(LoadingParkingState());
      if (parking.occupidParking! <= parking.capacity!) {
        await forceGetTicket();
      } else {
        emit(ParkingFull());
      }
    } catch (error) {
      emit(ErrorParkingState(error: error.toString()));
    }
  }

  Future forceGetTicket({bool? cancelled}) async {
    try {
      if (cancelled != null) {
        emit(ParkingLoadedState(parking: parking));
      } else {
        emit(LoadingParkingState());
        final int totalCustomersOfToday = parking.totalCustomersOfToday! + 1;
        Map<String, dynamic> fieldsToUpdate = {
          "emptyParking": parking.emptyParking! - 1,
          "occupidParking": parking.occupidParking! + 1,
          "totalCustomersOfToday": totalCustomersOfToday,
        };
        String? enDate;
        String? enTime;

        if (Intl.getCurrentLocale() == "ar") {
          String arDate = HandlingDate(date: DateTime.now().toString())
              .formatDateInArabic();
          enDate = HandlingDate(date: arDate).convertArabicToEnglishDate();
          String arTime =
              HandlingTime(time: TimeOfDay.now().toString()).handleTime();
          enTime = TranslteNumericaleRepo().arabicToEnglishNumerals(arTime);

          print("english date: $enDate");
          print("enTime: $enTime");
        } else {
          enDate = HandlingDate(date: DateTime.now().toString()).handleDate();
          enTime = HandlingTime(time: TimeOfDay.now().toString()).handleTime();
        }

        await ParkingRepo()
            .updateFields(parkingId: parkingId, fieldsToUpdate: fieldsToUpdate)
            .then((_) {
          print("updated");
        });
        await ParkingRepo()
            .updateIncome(
                parkingId: parkingId,
                income: totalCustomersOfToday * parking.price!)
            .then((_) {
          print("updated incom");
        });
        ;
        await ParkingRepo()
            .addTicket(
                parkingId: parkingId, ticketNumber: totalCustomersOfToday)
            .then((_) {
          print("added  ticket");
        });
        ;
        for (int i = 0; i < 3; i++) {
          await PrintTicketRepo().generateReceipt(
            enterDate: enDate,
            enterTime: enTime,
            ticketNumber: totalCustomersOfToday.toString(),
          );
          print("printing");
        }
        await ParkingRepo().readParkingData(parkingId).then((value) {
          parking = value;
          emit(ParkingLoadedState(parking: parking));
        });
      }
    } catch (error) {
      emit(ErrorParkingState(error: error.toString()));
    }
  }
}

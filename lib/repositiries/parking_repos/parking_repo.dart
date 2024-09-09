import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eagle_valet_parking/models/income_of_day.dart';
import 'package:eagle_valet_parking/models/parking_model.dart';
import 'package:eagle_valet_parking/models/ticket.dart';
import 'package:eagle_valet_parking/repositiries/time/time_repo.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../date/date_format.dart';
import '../translate_nmerical/translte_numericale.dart';

class ParkingRepo {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future createParkingData(ParkingModel parking) async {
    try {
      ////print"parking id :${parking.uid}");
      await _firestore
          .collection('parkings')
          .doc(parking.parkingId)
          .set(parking.toJson());
    } catch (error) {
      // debug////print'Error saving parking data: $error');
      throw Exception("Error while saving data to the database $error");
    }
  }

  Future readParkingData(String parkingId) async {
    try {
      final documentSnapshot =
          await _firestore.collection('parkings').doc(parkingId).get();
      if (documentSnapshot.exists) {
        print("parking exist");

        return ParkingModel.fromJson(documentSnapshot.data() ?? {});
      } else {
        return {}; // Return empty map if parking doesn't exist
      }
    } catch (error) {
      // Handle errors appropriately
      throw Exception('Error getting parking data: $error');
      //////print'Error getting parking data: $error');
      //return {}; // Return empty map on error
    }
  }

  Future updateParkingData(
      {required String parkingId,
      required String field,
      required dynamic data}) async {
    ////print"parkingId $parkingId");
    try {
      //print"fire");
      await _firestore
          .collection("parkings")
          .doc(parkingId)
          .update({field: data}).then((value) {
        //print"done");
      }).catchError((error) {
        throw Exception('Failed to update parking data');
      });
    } catch (error) {
      ////printerror);
      throw Exception('Failed to update parking data');
    }
  }

  Future updateFields(
      {required String parkingId,
      required Map<String, dynamic> fieldsToUpdate}) async {
    try {
      _firestore
          .collection('parkings')
          .doc(parkingId)
          .update(fieldsToUpdate)
          .then((_) {
        //print"Fields updated successfully!");
      }).catchError((error) {
        //print"Failed to update fields: $error");
      });
    } catch (error) {
      throw Exception('Failed to update parking data');
    }
  }

  Future deleteParkingData({required String parkingId}) async {
    try {
      await _firestore
          .collection('parkings')
          .doc(parkingId)
          .delete()
          .then((value) {
        //print"done");
      }).catchError((error) {
        throw Exception('Failed to delete parking data');
      });
    } catch (error) {
      throw Exception('Failed to delete parking data');
    }
  }

  Future updateIncome({required String parkingId, required int income}) async {
    // Reference to the document you want to update
    DocumentReference documentReference =
        _firestore.collection('parkings').doc(parkingId);
    // Get the current list
    DocumentSnapshot snapshot = await documentReference.get();
    if (snapshot.exists) {
      int? index;
      List items = snapshot['incomeOfDay'];
      //get the index
      String? enDate;
      if (Intl.getCurrentLocale() == "ar") {
        String arDate =
            HandlingDate(date: DateTime.now().toString()).formatDateInArabic();
        enDate = HandlingDate(date: arDate).convertArabicToEnglishDate();
      } else {
        enDate = HandlingDate(date: DateTime.now().toString()).handleDate();
      }
      for (int i = 0; i < items.length; i++) {
        if (items[i]['date'] == enDate) {
          index = i;
        }
      }
      if (index == null) {
        // Add a new item to the list
        items.add(IncomeOfDay(date: enDate, income: income).toJson());
        //print"new day");
        await documentReference.update({'incomeOfDay': items}).then((_) {
          //print"List item updated successfully!");
        }).catchError((error) {
          //print"Failed to update list item: $error");
        });
      } else {
        items[index]["income"] = income;
        // Update the list back to the document
        await documentReference.update({'incomeOfDay': items}).then((_) {
          //print"List item updated successfully!");
        }).catchError((error) {
          //print"Failed to update list item: $error");
        });
      }
    } else {
      //print"Document does not exist!");
    }
  }

  Future addTicket(
      {required String parkingId, required int ticketNumber}) async {
    try {
      DocumentReference documentReference =
          _firestore.collection('parkings').doc(parkingId);
      // Get the current list
      DocumentSnapshot snapshot = await documentReference.get();
      if (snapshot.exists) {
        List items = snapshot['tickets'];
        // Add a new item to the list
        String? enDate;
        String? enTime;
        DateTime? dateTimeEn;
        if (Intl.getCurrentLocale() == "ar") {
          String arDate = HandlingDate(date: DateTime.now().toString())
              .formatDateInArabic();
          enDate = HandlingDate(date: arDate).convertArabicToEnglishDate();
          String arTime =
              HandlingTime(time: TimeOfDay.now().toString()).handleTime();
          enTime = TranslteNumericaleRepo().arabicToEnglishNumerals(arTime);
          print("yarb");
          dateTimeEn = HandlingDate(date: enDate).convertToDateTime(enTime);
          print("dateTimeEnd: $dateTimeEn");
          print("english date: $enDate");
          print("enTime: $enTime");
        }

        items.add(TicketModel(
                ticketNumber: ticketNumber,
                id: enDate == null
                    ? HandlingDate(date: DateTime.now().toString())
                            .handleDate() +
                        ticketNumber.toString()
                    : enDate.toString() + ticketNumber.toString(),
                enterDate: dateTimeEn == null
                    ? DateTime.now().toString()
                    : dateTimeEn.toString(),
                enterTime: enTime ??
                    HandlingTime(time: TimeOfDay.now().toString()).handleTime(),
                leaveDate: "",
                leaveTime: "",
                parkingDurationInMinutes: 0)
            .toJson());
        print("added");
        await documentReference.update({'tickets': items}).then((_) {
          //print"added to List tickets successfully!");
        }).catchError((error) {
          //print"Failed to update list item: $error");
        });
      }
    } catch (error) {
      throw Exception("Error while adding ticket");
    }
  }

  Future updateTickets(
      {required String parkingId, required int ticketNumber}) async {
    try {
      //DateTime now ;
      String? enDate;
      String? enTime;
      if (Intl.getCurrentLocale() == "ar") {
        String arDate =
            HandlingDate(date: DateTime.now().toString()).formatDateInArabic();
        enDate = HandlingDate(date: arDate).convertArabicToEnglishDate();
        String arTime =
            HandlingTime(time: TimeOfDay.now().toString()).handleTime();
        enTime = TranslteNumericaleRepo().arabicToEnglishNumerals(arTime);
        print("english date: $enDate");
        print("enTime: $enTime");
      }
      DocumentReference documentReference =
          _firestore.collection('parkings').doc(parkingId);
      DocumentSnapshot snapshot = await documentReference.get();
      print("enDate2: $enDate");

      String id = enDate == null
          ? HandlingDate(date: DateTime.now().toString()).handleDate() +
              ticketNumber.toString()
          : enDate + ticketNumber.toString();
      print("id: $id");
      if (snapshot.exists) {
        int? index;
        List items = snapshot['tickets'];
        print(id);
        for (int i = 0; i < items.length; i++) {
          if (items[i]['id'] == id) {
            print("found");
            index = i;
            print(index);
          }
        }
        if (index == null) {
          print("Check the ticket number, please!");
          return "Check the ticket number, please!";
        } else {
          if (items[index]["leaveDate"] == "") {
            items[index]["leaveDate"] = enDate ??
                HandlingDate(date: DateTime.now().toString()).handleDate();
            print("leaveDate" + items[index]["leaveDate"]);

            items[index]["leaveTime"] = enTime ??
                HandlingTime(time: TimeOfDay.now().toString()).handleTime();
            print("leaveTime" + items[index]["leaveTime"]);
            if (Intl.getCurrentLocale() == "ar") {
              print("enDate3 $enDate");
              print(enTime);
              DateTime dateTimeEn =
                  HandlingDate(date: enDate!).convertToDateTime(enTime!);
              print("dateTimeEnd: $dateTimeEn");

              items[index]["parkingDurationInMinutes"] = dateTimeEn
                  .difference(HandlingDate(date: items[index]["enterDate"])
                      .convertToDateTime2())
                  .inMinutes;
            } else {
              print("else");
              items[index]["parkingDurationInMinutes"] = DateTime.now()
                  .difference(HandlingDate(date: items[index]["enterDate"])
                      .fromStringToDate())
                  .inMinutes;
            }
            TicketModel ticket = TicketModel.fromJson(items[index]);
            print("Ticket $ticket");
            await documentReference.update({'tickets': items}).then((_) {
              print("List tickets updated successfully!");
            }).catchError((error) {
              print("Failed to update list tickets: $error");
            });
            return ticket;
          } else {
            return 'This car left the parking';
          }
        }
      } else {
        print("Document does not exist!");
      }
    } catch (error) {
      throw Exception("error updating tickets $error");
    }
  }
}

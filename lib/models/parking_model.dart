import 'package:eagle_valet_parking/models/ticket.dart';
import 'income_of_day.dart';

class ParkingModel {
  String? parkingId;
  String? parkingName;
  int? capacity;
  int? price;
  List<String>? employerIds;
  List<TicketModel>? tickets;
  List<IncomeOfDay>? incomeOfDay;
  int? totalCustomersOfToday;
  int? occupidParking;
  int? emptyParking;
  ParkingModel({
    this.parkingId,
    this.parkingName,
    this.capacity,
    this.price,
    this.employerIds,
    this.tickets,
    this.incomeOfDay,
    this.totalCustomersOfToday,
    this.occupidParking,
    this.emptyParking,
  });

  ParkingModel.fromJson(Map<String, dynamic> json) {
    parkingId = json["parkingId"];
    print("parkingId $parkingId");
    parkingName = json["parkingName"];
    print("parkingName $parkingName");
    capacity = json["capacity"];
    print("capacity $capacity");
    price = json["price"];
    print("price $price");

    totalCustomersOfToday = json["totalCustomersOfToday"];
    print("totalCustomersOfToday $totalCustomersOfToday");

    occupidParking = json["occupidParking"];
    print("occupidParking $occupidParking");

    emptyParking = json["emptyParking"];
    print("emptyParking $emptyParking");

    employerIds = json["employers"].cast<String>();

    print("employerIds $employerIds");

    tickets = json["tickets"]
        .map<TicketModel>((e) => TicketModel.fromJson(e))
        .toList();

    print("tickets $tickets");

    incomeOfDay = json["incomeOfDay"]
        .map<IncomeOfDay>((e) => IncomeOfDay.fromJson(e))
        .toList();
  }
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data["parkingId"] = parkingId;
    data["parkingName"] = parkingName;
    data["capacity"] = capacity;
    data["price"] = price;
    data["totalCustomersOfToday"] = totalCustomersOfToday;
    data["occupidParking"] = occupidParking;
    data["emptyParking"] = emptyParking;
    data["totalCustomersOfToday"] = totalCustomersOfToday;
    if (employerIds != null) {
      data['employers'] = employerIds!.map((v) => v).toList();
    }
    if (tickets != null) {
      data['tickets'] = tickets!.map((v) => v).toList();
    }
    if (incomeOfDay != null) {
      data['incomeOfDay'] = incomeOfDay!.map((v) => v).toList();
    }

    return data;
  }
}

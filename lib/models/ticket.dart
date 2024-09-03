class TicketModel {
  String? id;
  int? ticketNumber;
  String? enterTime;
  String? leaveTime;
  String? enterDate;
  String? leaveDate;
  int? parkingDurationInMinutes;
  TicketModel(
      {this.id,
      this.ticketNumber,
      this.enterTime,
      this.leaveTime,
      this.enterDate,
      this.leaveDate,this.parkingDurationInMinutes});
  TicketModel.fromJson(Map<String, dynamic> json) {
    id = json["id"];
    ticketNumber = json["ticketNumber"];
    enterTime = json["enterTime"];
    leaveTime = json["leaveTime"];
    enterDate = json["enterDate"];
    leaveDate = json["leaveDate"];
    parkingDurationInMinutes = json["parkingDurationInMinutes"];
  }
  Map<String, dynamic> toJson() {
    Map<String, dynamic> data = {};
    data["id"] = id;
    data["ticketNumber"] = ticketNumber;
    data["enterTime"] = enterTime;
    data["leaveTime"] = leaveTime;
    data["enterDate"] = enterDate;
    data["leaveDate"] = leaveDate;
    data["parkingDurationInMinutes"] = parkingDurationInMinutes;
    return data;
  }
}

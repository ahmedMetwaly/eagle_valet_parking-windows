class IncomeOfDay {
  String? date;
  int? income; //garage capacity * grage price
  IncomeOfDay({required this.date, required this.income});
  IncomeOfDay.fromJson(Map<String, dynamic> json) {
    date = json["date"];
    income = json["income"];
  }
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data["date"] = date;
    data["income"] = income;
    return data;
  }
}

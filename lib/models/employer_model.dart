class EmployerModel {
  String? uid;
  String? parkingId;

  String? name;
  String? email;
  String? imageUrl;
  String? password;
  String? phoneNumber;

  EmployerModel({
    this.uid,
    required this.parkingId,
    required this.name,
    required this.email,
    required this.imageUrl,
    required this.password,
    this.phoneNumber,
  });
  EmployerModel.fromJson(Map<String, dynamic> json) {
    uid = json['uid'];
    parkingId = json['parkingId'];
    name = json['name'];
    email = json['email'];
    password = json["password"];
    imageUrl = json["imageUrl"];
    phoneNumber = json["phoneNumber"];
  }
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data["uid"] = uid;
    data["parkingId"] = parkingId;
    data["name"] = name;
    data["email"] = email;
    data["password"] = password;
    data["imageUrl"] = imageUrl;
    data["phoneNumber"] = phoneNumber;

    return data;
  }
}

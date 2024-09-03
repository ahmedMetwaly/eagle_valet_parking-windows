import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eagle_valet_parking/models/parking_model.dart';
import 'package:eagle_valet_parking/repositiries/parking_repos/parking_repo.dart';

class CalculationRepo {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future calculateDuration(
      {required String parkingId, required int ticketNumber}) async {
    await _firestore
        .collection('parkings')
        .doc(parkingId)
        .get()
        .then((value) async {
      if (value.data() != null) {
        ParkingModel parking = ParkingModel.fromJson(value.data()!);
        Map<String, dynamic> fieldsToUpdate = {
          "emptyParking": parking.emptyParking! + 1,
          "occupidParking": parking.occupidParking! - 1,
        };
        await ParkingRepo()
            .updateFields(parkingId: parkingId, fieldsToUpdate: fieldsToUpdate);
        
      }
    });
  }
}

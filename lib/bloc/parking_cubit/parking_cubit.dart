import 'package:eagle_valet_parking/bloc/authentication_bloc/auth_bloc.dart';
import 'package:eagle_valet_parking/bloc/parking_cubit/parking_states.dart';
import 'package:eagle_valet_parking/models/parking_model.dart';
import 'package:eagle_valet_parking/repositiries/parking_repos/parking_repo.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ParkingCubit extends Cubit<ParkingStates> {
  ParkingCubit() : super(InitialParkingState());
  ParkingModel parking = ParkingModel();
  String parkingId = AuthenticationBloc.employer.parkingId!;
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
        await ParkingRepo()
            .updateFields(parkingId: parkingId, fieldsToUpdate: fieldsToUpdate);
        await ParkingRepo().updateIncome(
            parkingId: parkingId,
            income: totalCustomersOfToday * parking.price!);
        await ParkingRepo().addTicket(
            parkingId: parkingId,
            ticketNumber: totalCustomersOfToday);
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

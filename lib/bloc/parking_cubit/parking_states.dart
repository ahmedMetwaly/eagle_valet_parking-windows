import 'package:eagle_valet_parking/models/parking_model.dart';

abstract class ParkingStates {}

class InitialParkingState extends ParkingStates {}

class LoadingParkingState extends ParkingStates {}

class ParkingLoadedState extends ParkingStates {
  final ParkingModel parking;
  ParkingLoadedState({required this.parking});
}

class UpdatingParkingState extends ParkingStates {}

class ParkingUpdatedState extends ParkingStates {
  final ParkingModel parking;
  ParkingUpdatedState({required this.parking});
}
class ParkingFull extends ParkingStates {}
class CancelledPrint extends ParkingStates {}

class ErrorParkingState extends ParkingStates {
  final String error;

  ErrorParkingState({required this.error}); 
}

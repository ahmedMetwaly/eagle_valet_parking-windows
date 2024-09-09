import 'package:eagle_valet_parking/generated/l10n.dart';
import 'package:eagle_valet_parking/models/ticket.dart';
import 'package:eagle_valet_parking/repositiries/parking_repos/calculation_repo.dart';
import 'package:eagle_valet_parking/repositiries/parking_repos/print_repo.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../repositiries/parking_repos/parking_repo.dart';
import '../authentication_bloc/auth_bloc.dart';
import 'calculate_duration_states.dart';

class CalculateDurationCubit extends Cubit<CalculateDurationStates> {
  CalculateDurationCubit() : super(InitialCalculateDuration());
  String parkingId = AuthenticationBloc.employer.parkingId!;
  TicketModel ticket = TicketModel();
  Future calculateDuration({required int ticketNumber,required String parkingFee}) async {
    try {
      emit(LoadingCalculateDuration());
      print("start calculation");
      await ParkingRepo()
          .updateTickets(parkingId: parkingId, ticketNumber: ticketNumber)
          .then((value) async {
        print("in updatig calculation");
        if (value == "Check the ticket number, please!") {
          emit(ErrorCalculationDuration(
              error: S.current.ticketNumberIsNotValid));
        } else if (value == 'This car left the parking') {
          emit(
              ErrorCalculationDuration(error: S.current.thisCarLeftTheParking));
        } else {
          ticket = value;
          await CalculationRepo().calculateDuration(
              parkingId: parkingId, ticketNumber: ticketNumber);
          
          emit(CompletedCalculationDuration());
        }
      });
    } catch (error) {
      print(error.toString());
      emit(ErrorCalculationDuration(error: error.toString()));
    }
  }
}

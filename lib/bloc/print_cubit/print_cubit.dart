import 'dart:async';

import 'package:eagle_valet_parking/bloc/print_cubit/print_states.dart';
import 'package:eagle_valet_parking/repositiries/parking_repos/print_repo.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:thermal_printer/thermal_printer.dart';

class PrintCubit extends Cubit<PrintStates> {
  PrintCubit() : super(InitialPrintState());

  Set<PrinterDevice> printers = {};
  late String selectedPrinter;

  Future connectPrinter({required String pritner}) async {
    try {
      emit(LoadingPrinterState());
      await PrintTicketRepo().connectPrinter(pritner).then((_) {
        selectedPrinter = pritner;
        emit(SuccessPrinterState());
      });
    } catch (error) {
      emit(PrintFaildState(message: error.toString()));
    }
  }

 /*  Future scanPrinters() async {
    try {
      emit(LoadingPrinterState());
   
      await PrinterManager.instance
          .discovery(type: PrinterType.usb, isBle: false)
          .listen((device) {
        print(device);
        printers.add(device);
        emit(SuccessPrinterState());
      });
    } catch (error) {
      emit(PrintFaildState(message: error.toString()));
    }
  }
 */
  Future firstReceipt() async {
    try {
      emit(LoadingPrinterState());
      await PrintTicketRepo().firstReceipt().then((_) {
        emit(SuccessPrinterState());
      });
    } catch (error) {
      emit(PrintFaildState(message: error.toString()));
    }
  }

  Future generateReceipt(
      {required String ticketNumber,
       String? enterDate,
       String? enterTime,
      String? parkingFee,
      String? leavingDate,
      String? leavingTime,
      String? duration}) async {
    try {
      emit(LoadingPrinterState());
      await PrintTicketRepo()
          .generateReceipt(
        ticketNumber: ticketNumber,
        enterDate: enterDate,
        enterTime: enterTime,
        parkingFee: parkingFee,
        leavingDate: leavingDate,
        leavingTime: leavingTime,
        duration: duration,
      )
          .then((_) {
        emit(SuccessPrinterState());
      });
    } catch (error) {
      emit(PrintFaildState(message: error.toString()));
    }
  }
}

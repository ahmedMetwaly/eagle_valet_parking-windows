import 'dart:async';
import 'package:eagle_valet_parking/bloc/sharedprefrences/sharedpref_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../repositiries/parking_repos/print_repo.dart';
import '../../repositiries/shared_prefrences/sharedprefrences_service.dart';

class SharedPrefBloc extends Cubit<SettingsStates> {
  SharedPrefBloc() : super(SettingsInitial());

  static bool isDark = false;
  bool isOpenedBefore = false;
  String lang = "en";
  String printer = "EPSON TM-T20II Receipt";

  Future appStarted() async {
    emit(LoadingSettings());
    try {
      await SharedPrefrencesService.getBoolValuesSF("isOpenedBefore")
          .then((value) async {
        if (value == null) {
          await SharedPrefrencesService.addBoolToSF("isDark", false);
          await SharedPrefrencesService.addStringToSF("lang", "en");
          await SharedPrefrencesService.addStringToSF(
              "printerName", "EPSON TM-T20II Receipt");
          await PrintTicketRepo().connectPrinter(printer);
        } else {
          isOpenedBefore = true;
          await SharedPrefrencesService.getBoolValuesSF("isDark")
              .then((value) => isDark = value ?? false);
          await SharedPrefrencesService.getStringFromSF("lang")
              .then((value) => lang = value ?? "en");
          await SharedPrefrencesService.getStringFromSF("printerName")
              .then((value) async {
            printer = value ?? "EPSON TM-T20II Receipt";
            await PrintTicketRepo().connectPrinter(printer);
            return printer;
          });
        }
        print("printer:$printer");
        ////print
        //    "isOpenBefore: $isOpenedBefore\nisDark : $isDark\nlanguage : $lang");
        emit(SettingsLoadedSuccessfully(
            isOpenedBefore: isOpenedBefore,
            isDark: isDark,
            language: lang,
            printerName: printer));
      });
    } catch (error) {
      //Exception("error $error");
      emit(SettingsError(errorMsg: error.toString()));
    }
  }

  Future changeTheme(bool isDarkFunction) async {
    emit(LoadingSettings());
    try {
      isDark = isDarkFunction;
      await SharedPrefrencesService.addBoolToSF("isDark", isDarkFunction).then(
          (value) => emit(SettingsLoadedSuccessfully(isDark: isDarkFunction)));
    } catch (error) {
      //Exception("error $error");
      emit(SettingsError(errorMsg: error.toString()));
    }
  }

  Future changeLang(String language) async {
    emit(LoadingSettings());
    try {
      lang = language;
      await SharedPrefrencesService.addStringToSF("lang", language).then(
          (value) => emit(SettingsLoadedSuccessfully(language: language)));
    } catch (error) {
      //  Exception("error $error");
      emit(SettingsError(errorMsg: error.toString()));
    }
  }

  Future selectPrinter({
    required String printerName,
  }) async {
    emit(LoadingSettings());
    try {
      await SharedPrefrencesService.addStringToSF("printerName", printerName)
          .then((_) {
        printer = printerName;
        print("printer $printer is selected successfully in shared pref");
        emit(SettingsLoadedSuccessfully(printerName: printerName));
      });
    } catch (error) {
      emit(SettingsError(errorMsg: error.toString()));
    }
  }
}

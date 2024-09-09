import 'package:eagle_valet_parking/bloc/parking_cubit/parking_cubit.dart';
import 'package:eagle_valet_parking/view/ticket/initPrinter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../generated/l10n.dart';
import '../../../resources/image_manager.dart';
import '../../../resources/routes.dart';
import 'change_language.dart';

AppBar myAppBar(BuildContext context) {
  return AppBar(
    backgroundColor: Theme.of(context).colorScheme.surface,
    title: Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Image.asset(ImageManager.splash, width: 50, height: 50),
        Text(
            "${S.current.Eagle_valet_parking} ( ${context.read<ParkingCubit>().parking.parkingName} ${S.current.branch} )"),
      ],
    ),
    actions: [
      TextButton(
        onPressed: () {
          Navigator.of(context).pushReplacementNamed(Routes.home);
        },
        child: Text(
          S.current.home,
          style: TextStyle(color: Colors.black.withOpacity(0.6)),
        ),
      ),
      TextButton(
          onPressed: () {
            Navigator.of(context).push(MaterialPageRoute(builder: (context)=> const InitPrinter()));
          },
          child: Text(
            S.current.printTicket,
            style: TextStyle(color: Colors.black.withOpacity(0.6)),
          )),
      TextButton(
          onPressed: () {
            Navigator.of(context)
                .pushReplacementNamed(Routes.calculateDuaration);
          },
          child: Text(
            S.current.calculateParkingDuration,
            style: TextStyle(color: Colors.black.withOpacity(0.6)),
          )),
      const ChangeLanguage()
    ],
    leading: const SizedBox(),
    leadingWidth: 0,
  );
}

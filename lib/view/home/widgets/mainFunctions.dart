
import 'package:eagle_valet_parking/bloc/parking_cubit/parking_cubit.dart';
import 'package:eagle_valet_parking/bloc/sharedprefrences/sharedpref_bloc.dart';
import 'package:eagle_valet_parking/resources/routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../bloc/sharedprefrences/sharedpref_state.dart';
import '../../../generated/l10n.dart';
import 'mainFunction.dart';

class MainFunctions extends StatelessWidget {
  const MainFunctions({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return BlocBuilder<SharedPrefBloc,SettingsStates>(
      builder: (BuildContext context, SettingsStates state) =>
      Padding(
        padding: EdgeInsets.symmetric(
          horizontal: size.width * 0.2,
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
              child: MainFunction(
                icon: Icons.print_rounded,
                title: S.current.printTicket,
                buttonTitle: S.current.print,
                onTap: () async{
                  await context.read<ParkingCubit>().printTicket();
                
                  //print"print ticket");
                },
              ),
            ),
            SizedBox(width: size.width * 0.01),
            Expanded(
              child: MainFunction(
                icon: Icons.watch_later_rounded,
                title: S.current.calculateParkingDuration,
                buttonTitle: S.current.calculate,
                onTap: () {
                  Navigator.of(context).pushReplacementNamed(Routes.calculateDuaration);
                  //print"calculate Duration");
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

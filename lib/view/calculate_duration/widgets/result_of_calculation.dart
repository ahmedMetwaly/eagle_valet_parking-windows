import 'package:eagle_valet_parking/bloc/calculate_duration_bloc/calculate_duration_cubit.dart';
import 'package:eagle_valet_parking/bloc/calculate_duration_bloc/calculate_duration_states.dart';
import 'package:eagle_valet_parking/bloc/parking_cubit/parking_cubit.dart';
import 'package:eagle_valet_parking/generated/l10n.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../resources/values_manager.dart';

class ResultOfCalculation extends StatelessWidget {
  const ResultOfCalculation({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return BlocBuilder<CalculateDurationCubit, CalculateDurationStates>(
      builder: (BuildContext context, CalculateDurationStates state) {
        print(state);
        if (state is LoadingCalculateDuration) {
          return SizedBox(
              height: size.height * 0.20,
              width: size.width * 0.3,
              child: const Center(child: CircularProgressIndicator()));
        }
        if (state is CompletedCalculationDuration) {
          return Container(
            height: size.height * 0.20,
            width: size.width * 0.3,
            padding: const EdgeInsets.all(25),
            decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.primary,
                borderRadius:
                    BorderRadius.circular(SizeManager.bottomSheetRadius),
                border: Border.all(
                  color: Theme.of(context).colorScheme.outline,
                )),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                  child: Row(
                    children: [
                      Expanded(
                          child: Text(
                        "${S.current.totalDuration}: ",
                        style: TextStyle(
                            fontSize: 20,
                            color: Theme.of(context).colorScheme.surface,
                            fontWeight: FontWeight.w400),
                      )),
                      Expanded(
                          flex: 2,
                          child: Center(
                            child: Text(
                                "10 ${S.current.hours} ${context.read<CalculateDurationCubit>().ticket.parkingDurationInMinutes} ${S.current.minutes}",
                                style: TextStyle(
                                    fontSize: 20,
                                    color:
                                        Theme.of(context).colorScheme.surface,
                                    fontWeight: FontWeight.w400)),
                          )),
                    ],
                  ),
                ),
                Expanded(
                    child: Row(
                  children: [
                    Expanded(
                      child: Text("${S.current.parkingFee}: ",
                          style: TextStyle(
                              fontSize: 20,
                              color: Theme.of(context).colorScheme.surface,
                              fontWeight: FontWeight.w400)),
                    ),
                    Expanded(
                      child: Text(
                          "${context.read<ParkingCubit>().parking.price} ${S.current.currencySign}",
                          style: TextStyle(
                              fontSize: 20,
                              color: Theme.of(context).colorScheme.surface,
                              fontWeight: FontWeight.w400)),
                    )
                  ],
                )),
              ],
            ),
          );
        }
        return SizedBox(height: size.height * 0.20, width: size.width * 0.3);
      },
    );
  }
}

import 'package:eagle_valet_parking/bloc/parking_cubit/parking_cubit.dart';
import 'package:eagle_valet_parking/bloc/parking_cubit/parking_states.dart';
import 'package:eagle_valet_parking/generated/l10n.dart';
import 'package:eagle_valet_parking/view/home/widgets/show_today_collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../resources/values_manager.dart';
import 'live_preview_content.dart';

class LiveOverview extends StatelessWidget {
  const LiveOverview({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return BlocBuilder<ParkingCubit, ParkingStates>(
        builder: (BuildContext context, ParkingStates state) {
          //printstate);
      if (state is InitialParkingState) {
        context.read<ParkingCubit>().readParkingData();
      }
      if (state is LoadingParkingState) {
        return SizedBox(
            height: size.height * 0.125,
            child: const Center(child: CircularProgressIndicator()));
      }
       
      if (state is ParkingLoadedState) {
        return Container(
          height: size.height * 0.125,
          decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.surface,
              borderRadius:
                  BorderRadius.circular(SizeManager.bottomSheetRadius),
              border: Border.all(
                color: Theme.of(context).colorScheme.outline,
              )),
          child: Row(children: [
            Expanded(
              child: LivePrevewContent(
                value: context
                    .read<ParkingCubit>()
                    .parking
                    .occupidParking!
                    .toString(),
                capacity:
                    context.read<ParkingCubit>().parking.capacity!.toString(),
                description: S.current.parkingLotsOccupied,
              ),
            ),
            Container(
              color: Theme.of(context).colorScheme.outline,
              height: size.height * 0.125,
              width: 1.5,
            ),
            Expanded(
              child: LivePrevewContent(
                value: context
                    .read<ParkingCubit>()
                    .parking
                    .emptyParking!
                    .toString(),
                capacity:
                    context.read<ParkingCubit>().parking.capacity!.toString(),
                description: S.current.emptyParking,
              ),
            ),
            Container(
              color: Theme.of(context).colorScheme.outline,
              height: size.height * 0.125,
              width: 1.5,
            ),
            Expanded(
              child: LivePrevewContent(
                value: context
                    .read<ParkingCubit>()
                    .parking
                    .totalCustomersOfToday!
                    .toString(),
                description: S.current.totalCustomersToday,
              ),
            ),
            Container(
              color: Theme.of(context).colorScheme.outline,
              height: size.height * 0.125,
              width: 1.5,
            ),
            Expanded(
                child: ShowTodayCollection(
              todayCollection:
                  (context.read<ParkingCubit>().parking.totalCustomersOfToday! *
                          context.read<ParkingCubit>().parking.price!)
                      .toString(),
            )),
          ]),
        );
      }
      return const Center(child: CircularProgressIndicator());
    });
  }
}

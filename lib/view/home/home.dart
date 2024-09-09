import 'package:eagle_valet_parking/bloc/parking_cubit/parking_cubit.dart';
import 'package:eagle_valet_parking/bloc/parking_cubit/parking_states.dart';
import 'package:eagle_valet_parking/generated/l10n.dart';
import 'package:eagle_valet_parking/resources/values_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'widgets/live_overview.dart';
import 'widgets/mainFunctions.dart';
import 'widgets/myAppBar.dart';
import 'widgets/my_bottom_navigation_bar.dart';

class Home extends StatelessWidget {
  const Home({super.key});
//TODO:: when new day is come check if the ticket number > total number customer of day add to  number ticket the current day -1 
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
     return BlocConsumer<ParkingCubit, ParkingStates>(
      builder: (BuildContext context, ParkingStates state) {
        return Scaffold(
            appBar: myAppBar(context),
            bottomNavigationBar: MyBottomNavigationBar(size: size),
            body: Padding(
              padding: const EdgeInsets.all(PaddingManager.pMainPadding),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    S.current.liveOverview,
                    style: Theme.of(context)
                        .textTheme
                        .bodyLarge!
                        .copyWith(fontSize: 40),
                  ),
                  SizedBox(height: size.height * 0.01),
                  const LiveOverview(),
                  SizedBox(height: size.height * 0.09),
                  const MainFunctions(),
                ],
              ),
            ));
      },
      listener: (BuildContext context, ParkingStates state) {
        if (state is ParkingFull) {
          showDialog(
              context: context,
              builder: (context) => AlertDialog(
                    title: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(S.current.warnning),
                        Divider(
                            color: Theme.of(context).colorScheme.primary,
                            height: 10),
                      ],
                    ),
                    content: Text(S.current.parking_full),
                    actions: [
                      TextButton(
                          onPressed: () async {
                            await context
                                .read<ParkingCubit>()
                                .forceGetTicket()
                                .then((_) => Navigator.pop(context));
                          },
                          child: Text(S.current.print)),
                      TextButton(
                          onPressed: () async {
                            await context
                                .read<ParkingCubit>()
                                .forceGetTicket(cancelled: true)
                                .then((_) => Navigator.pop(context));
                          },
                          child: Text(S.current.cancel)),
                    ],
                  ));
        }
      },
    );
  }
}

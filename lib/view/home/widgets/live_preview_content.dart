import 'package:eagle_valet_parking/bloc/parking_cubit/parking_cubit.dart';
import 'package:eagle_valet_parking/bloc/parking_cubit/parking_states.dart';
import 'package:eagle_valet_parking/resources/values_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LivePrevewContent extends StatelessWidget {
  const LivePrevewContent({
    super.key,
    required this.value,
    this.capacity,
    required this.description,
  });

  final String value;
  final String? capacity;
  final String description;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ParkingCubit, ParkingStates>(
      builder: (BuildContext context, ParkingStates state) {
        if(state is UpdatingParkingState){
          return const Center(child: CircularProgressIndicator());
        }
        return Padding(
        padding: const EdgeInsets.all(PaddingManager.pInternalPadding),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Text(
                  value.toString(),
                  style: TextStyle(
                      fontSize: 18,
                      color: Theme.of(context).colorScheme.primary,
                      fontWeight: FontWeight.bold),
                ),
                capacity == null
                    ? const SizedBox()
                    : Text(
                        " / $capacity",
                        style: TextStyle(
                            fontSize: 18,
                            color: Colors.black.withOpacity(0.6),
                            fontWeight: FontWeight.bold),
                      ),
              ],
            ),
            Text(
              description,
              style: TextStyle(
                  fontSize: 18,
                  color: Colors.black.withOpacity(0.6),
                  fontWeight: FontWeight.bold),
            ),
          ],
        ),
      );
      },
    );
  }
}

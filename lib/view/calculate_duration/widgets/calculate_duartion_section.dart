import 'package:eagle_valet_parking/bloc/calculate_duration_bloc/calculate_duration_cubit.dart';
import 'package:eagle_valet_parking/bloc/calculate_duration_bloc/calculate_duration_states.dart';
import 'package:eagle_valet_parking/bloc/parking_cubit/parking_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../generated/l10n.dart';
import '../../../resources/values_manager.dart';
import 'input_number.dart';

class CalculateDurationSection extends StatelessWidget {
  const CalculateDurationSection({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    TextEditingController ticketNumberController = TextEditingController();
    final formKey = GlobalKey<FormState>();
    return BlocBuilder<CalculateDurationCubit, CalculateDurationStates>(
      builder: (BuildContext context, CalculateDurationStates state) =>
          Container(
        height: size.height * 0.30,
        width: size.width * 0.4,
        padding: const EdgeInsets.all(25),
        decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.surface,
            borderRadius: BorderRadius.circular(SizeManager.bottomSheetRadius),
            border: Border.all(
              color: Theme.of(context).colorScheme.outline,
            )),
        child: Form(
          key: formKey,
          child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  S.current.calculateParkingDuration,
                  style: TextStyle(
                      fontSize: 20,
                      color: Colors.black.withOpacity(0.5),
                      fontWeight: FontWeight.w400),
                ),
                SizedBox(
                  height: size.height * 0.01,
                ),
                Text(
                  S.current.ticketNumber,
                  style: TextStyle(
                      fontSize: 15,
                      color: Colors.black.withOpacity(0.6),
                      fontWeight: FontWeight.w400),
                ),
                InputNumber(
                  controller: ticketNumberController,
                ),
                SizedBox(height: size.height * 0.05),
                ElevatedButton(
                    onPressed: () async {
                      if (formKey.currentState!.validate()) {
                        await context
                            .read<CalculateDurationCubit>()
                            .calculateDuration(
                                ticketNumber: int.parse(
                                    ticketNumberController.text.trim()))
                            .then((_) async => await context
                                .read<ParkingCubit>()
                                .readParkingData());
                      }
                    },
                    style: ButtonStyle(
                      fixedSize: WidgetStatePropertyAll(Size(size.width, 40)),
                      backgroundColor: WidgetStatePropertyAll(
                          Theme.of(context).colorScheme.primary),
                    ),
                    child: Text(
                      S.current.calculateDuration,
                      style: TextStyle(
                          color: Theme.of(context).colorScheme.surface),
                    ))
              ]),
        ),
      ),
    );
  }
}

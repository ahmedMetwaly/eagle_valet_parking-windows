import 'package:eagle_valet_parking/bloc/calculate_duration_bloc/calculate_duration_states.dart';
import 'package:eagle_valet_parking/resources/values_manager.dart';
import 'package:eagle_valet_parking/view/home/widgets/myAppBar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../bloc/calculate_duration_bloc/calculate_duration_cubit.dart';
import 'widgets/calculate_duartion_section.dart';
import 'widgets/result_of_calculation.dart';

class CalculateDuaration extends StatelessWidget {
  const CalculateDuaration({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return BlocBuilder<CalculateDurationCubit, CalculateDurationStates>(
      builder: (BuildContext context, CalculateDurationStates state) =>
          Scaffold(
              appBar: myAppBar(context),
              body: Padding(
                padding: const EdgeInsets.all(PaddingManager.pMainPadding),
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const CalculateDurationSection(),
                      SizedBox(height: size.height * 0.08),
                      const ResultOfCalculation()
                    ],
                  ),
                ),
              )),
    );
  }
}

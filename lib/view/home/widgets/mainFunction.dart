import 'package:eagle_valet_parking/bloc/parking_cubit/parking_cubit.dart';
import 'package:eagle_valet_parking/bloc/parking_cubit/parking_states.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../resources/values_manager.dart';

class MainFunction extends StatelessWidget {
  const MainFunction({
    super.key,
    required this.icon,
    required this.title,
    required this.onTap,
    required this.buttonTitle,
  });
  final IconData icon;
  final String title;
  final Function onTap;
  final String buttonTitle;
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return BlocBuilder<ParkingCubit, ParkingStates>(
      builder: (BuildContext context, ParkingStates state) => Container(
        height: size.height * 0.25,
        width: size.width * 0.35,
        padding: const EdgeInsets.all(PaddingManager.pInternalPadding),
        decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.surface,
            borderRadius: BorderRadius.circular(SizeManager.bottomSheetRadius),
            border: Border.all(
              color: Theme.of(context).colorScheme.outline,
            )),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Icon(
              icon,
              size: SizeManager.sIconSize,
              color: Theme.of(context).colorScheme.primary,
            ),
            SizedBox(height: size.height * 0.02),
            Text(title,
                style: TextStyle(
                    fontSize: 18,
                    color: Colors.black.withOpacity(0.6),
                    fontWeight: FontWeight.bold)),
            SizedBox(height: size.height * 0.02),
            ElevatedButton(
                onPressed: () => state is LoadingParkingState ? null : onTap(),
                style: ButtonStyle(
                  backgroundColor: WidgetStatePropertyAll(
                      Theme.of(context).colorScheme.primary),
                ),
                child: Text(
                  buttonTitle,
                  style:
                      TextStyle(color: Theme.of(context).colorScheme.surface),
                ))
          ],
        ),
      ),
    );
  }
}

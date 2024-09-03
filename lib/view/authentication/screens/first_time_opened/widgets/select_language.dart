import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../../bloc/sharedprefrences/sharedpref_bloc.dart';
import '../../../../../../resources/values_manager.dart';
import '../../../../../bloc/sharedprefrences/sharedpref_state.dart';
import '../../../../../resources/routes.dart';

class MyToggleButtons extends StatelessWidget {
  const MyToggleButtons({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    bool enIsSelected = true;
    return BlocConsumer<SharedPrefBloc, SettingsStates>(
      builder: (BuildContext context, SettingsStates state) => Padding(
        padding: const EdgeInsets.symmetric(
            vertical: PaddingManager.pInternalPadding),
        child: SizedBox(
          height: 50,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                onPressed: () {
                  context.read<SharedPrefBloc>().changeLang("en");
                  enIsSelected = true;
                },
                style: ButtonStyle(
                    fixedSize:
                        const WidgetStatePropertyAll<Size>(Size(100, 45)),
                    backgroundColor: WidgetStatePropertyAll<Color>(
                        enIsSelected
                            ? Theme.of(context).colorScheme.primary
                            : Theme.of(context).colorScheme.onSurface),
                    shadowColor: WidgetStatePropertyAll<Color>(
                        Theme.of(context).colorScheme.primary),
                    side: WidgetStatePropertyAll(BorderSide(
                        color: enIsSelected
                            ? Theme.of(context).colorScheme.primary
                            : Theme.of(context).colorScheme.onSecondary))),
                child: Text("English",
                    style: TextStyle(
                      color: enIsSelected
                          ? Theme.of(context).colorScheme.inversePrimary
                          : Theme.of(context).colorScheme.inversePrimary,
                    )),
              ),
              const SizedBox(
                width: SizeManager.sSpace,
              ),
              ElevatedButton(
                onPressed: () {
                  context.read<SharedPrefBloc>().changeLang("ar");
                  enIsSelected = false;
                },
                style: ButtonStyle(
                    fixedSize:
                        const WidgetStatePropertyAll<Size>(Size(100, 45)),
                    backgroundColor: WidgetStatePropertyAll<Color>(
                        enIsSelected
                            ? Theme.of(context).colorScheme.onSurface
                            : Theme.of(context).colorScheme.primary),
                    shadowColor: WidgetStatePropertyAll<Color>(
                        Theme.of(context).colorScheme.primary),
                    side: WidgetStatePropertyAll(BorderSide(
                        color: enIsSelected
                            ? Theme.of(context).colorScheme.onSecondary
                            : Theme.of(context).colorScheme.primary))),
                child: Text("العربية",
                    style: TextStyle(
                      color: enIsSelected
                          ? Theme.of(context).colorScheme.inversePrimary
                          : Theme.of(context).colorScheme.inversePrimary,
                    )),
              ),
            ],
          ),
        ),
      ),
      listener: (BuildContext context, SettingsStates state) {
        if (state is SettingsLoadedSuccessfully) {
          Navigator.of(context).pushReplacementNamed(Routes.onBoarding);
          //printstate.language);
        }
      },
    );
  }
}

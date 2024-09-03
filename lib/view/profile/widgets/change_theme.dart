/* import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../bloc/sharedprefrences/sharedpref_bloc.dart';
import '../../../../bloc/sharedprefrences/sharedpref_state.dart';
import '../../../../generated/l10n.dart';

class ChangeTheme extends StatelessWidget {
  const ChangeTheme({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SharedPrefBloc, SettingsStates>(
        builder: (context, state) {
          ////printstate);
          if(state is LoadingSettings){
            return const Center(child : CircularProgressIndicator());
          }

      return SwitchListTile(
        contentPadding: const EdgeInsets.all(0),
        value:  SharedPrefBloc.isDark ,
        onChanged: (value) {
          ////printvalue);
          context.read<SharedPrefBloc>().changeTheme(value);
        },
        title: Text(
          S.current.theme,
          style: Theme.of(context).textTheme.bodyLarge,
        ),
        subtitle: Text(
          SharedPrefBloc.isDark ? S.current.darkMode : S.current.lightMode,
          style: Theme.of(context).textTheme.bodySmall,
        ),
      );
    }, listener: (context, state) {
      if (state is LoadingSettings) {
        showDialog(
          context: context,
          barrierDismissible: false, // Prevent user from dismissing the dialog
          builder: (context) => const Center(
            child: CircularProgressIndicator(),
          ),
        );
      }
      if (state is SettingsLoadedSuccessfully) {

        Navigator.of(context).pop();
      }
    });
  }
}


 */
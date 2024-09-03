
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

import '../../../bloc/sharedprefrences/sharedpref_bloc.dart';
import '../../../bloc/sharedprefrences/sharedpref_state.dart';

class ChangeLanguage extends StatelessWidget {
  const ChangeLanguage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SharedPrefBloc, SettingsStates>(
        builder: (context, state) => TextButton(
            onPressed: () {
              Intl.getCurrentLocale() == "en"
                  ? context.read<SharedPrefBloc>().changeLang("ar")
                  : context.read<SharedPrefBloc>().changeLang("en");
            },
            child: Text(
              Intl.getCurrentLocale() == "en" ? "العربية" : "English",
              style: TextStyle(color: Colors.black.withOpacity(0.6)),
            )),
        listener: (context, state) {
          if (state is LoadingSettings) {
            showDialog(
              context: context,
              barrierDismissible:
                  false, // Prevent user from dismissing the dialog
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

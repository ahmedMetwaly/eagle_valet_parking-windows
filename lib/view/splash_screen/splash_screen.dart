import "package:firebase_auth/firebase_auth.dart";
import "package:flutter/material.dart";

import "package:flutter_bloc/flutter_bloc.dart";

import "../../../bloc/authentication_bloc/auth_states.dart";
import "../../../bloc/authentication_bloc/auth_bloc.dart";
import "../../../bloc/sharedprefrences/sharedpref_bloc.dart";
import "../../../bloc/sharedprefrences/sharedpref_state.dart";
import "../../../resources/image_manager.dart";
import "../../../resources/routes.dart";
import "../../../resources/values_manager.dart";

//TODO::check connection first
class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthenticationBloc, AuthenticationStates>(
      builder: (BuildContext context, AuthenticationStates authState) {
        return BlocListener<SharedPrefBloc, SettingsStates>(
            listener: (context, state) {
            //  //printauthState);
              if (state is SettingsLoadedSuccessfully) {
                /* //print"in shared");
                //print"isOpenedBefore : ${state.isOpenedBefore}");
                //printauthState); */
                if (!state.isOpenedBefore!) {
                  Navigator.of(context).pushReplacementNamed(Routes.appStarts);
                } else {
                  Navigator.of(context).pushReplacementNamed(Routes.logIn);
                }
              }
            },
            child: Scaffold(
              body: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Image.asset(
                      ImageManager.splash,
                      height: SizeManager.splashIconSize,
                      width: SizeManager.splashIconSize,
                      fit: BoxFit.cover,
                    ),
                    const SizedBox(
                      height: SizeManager.sSpace,
                    ),
                    const CircularProgressIndicator(),
                  ],
                ),
              ),
            ));
      },
      listener: (BuildContext context, AuthenticationStates state) async {
        if (state is AuthenticationSuccessState &&
            FirebaseAuth.instance.currentUser!.emailVerified == true) {
          ////print"the email verified");
          Navigator.of(context).pushReplacementNamed(Routes.home);
        } else if (state is AuthenticationSuccessState &&
            FirebaseAuth.instance.currentUser!.emailVerified == false) {
          ////print"the email not verified");
          Navigator.of(context).pushReplacementNamed(Routes.verifyEmail);
        }
      },
    );
  }
}

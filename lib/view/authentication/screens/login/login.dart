import "package:eagle_valet_parking/resources/image_manager.dart";
import "package:firebase_auth/firebase_auth.dart";
import "package:flutter/material.dart";
import "package:flutter_bloc/flutter_bloc.dart";
import "../../../../../generated/l10n.dart";
import "../../../../../resources/routes.dart";
import "../../../../bloc/authentication_bloc/auth_bloc.dart";
import "../../../../bloc/authentication_bloc/auth_events.dart";
import "../../../../bloc/authentication_bloc/auth_states.dart";
import "../../../../constants.dart";
import "../../../../resources/values_manager.dart";
import "widgets/email.dart";
import "widgets/password.dart";

class LogIn extends StatelessWidget {
  const LogIn({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final formKey = GlobalKey<FormState>();
    final emailController = TextEditingController();
    final passwordController = TextEditingController();
    return Scaffold(
      body: SafeArea(
          child: Padding(
        padding: const EdgeInsets.all(PaddingManager.pMainPadding),
        child: BlocConsumer<AuthenticationBloc, AuthenticationStates>(
          builder: (BuildContext context, AuthenticationStates state) {
            return Form(
              key: formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Image.asset(
                    ImageManager.splash,
                    width: size.width * 0.25,
                    height: size.height * 0.25,
                  ),
                  SizedBox(height: size.height * 0.01),
                  Text(
                    S.current.Eagle_valet_parking,
                    style: Theme.of(context).textTheme.headlineMedium,
                  ),
                  SizedBox(height: size.height * 0.08),
                  Padding(
                    padding:
                         EdgeInsets.symmetric(horizontal: size.width * 0.3,),
                    child: Column(
                      children: [
                        Email(inputController: emailController),
                        const SizedBox(height: 10),
                        Passsword(
                            inputController: passwordController,
                            insideSignInPage: true),
                        const SizedBox(height: SizeManager.sSpace16),
                        GestureDetector(
                          onTap: () => Navigator.of(context)
                              .pushNamed(Routes.forgetPassword),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Text(S.current.forgetPassword),
                              Icon(
                                Icons.arrow_forward_rounded,
                                size: SizeManager.sIconSize,
                                color: Theme.of(context).colorScheme.primary,
                              )
                            ],
                          ),
                        ),
                        SizedBox(height: size.height * 0.02),
                        ElevatedButton(
                          style: ButtonStyle(
                            backgroundColor: WidgetStateProperty.all(
                              Theme.of(context).colorScheme.primary),
                              fixedSize: WidgetStatePropertyAll(Size(size.width *0.25, size.height*0.05))
                          ),
                          onPressed: () {
                            if (formKey.currentState!.validate()) {
                              AuthenticationBloc.employer.email =
                                  emailController.text.trim().toString();
                              AuthenticationBloc.employer.password =
                                  passwordController.text.trim().toString();
                              context
                                  .read<AuthenticationBloc>()
                                  .add(SignInWithEmailEvent());
                              //print"valide");
                            }
                          },
                          child: Text(S.current.login.toUpperCase(), style: TextStyle(color: Theme.of(context).colorScheme.surface),),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            );
          },
          listener: (BuildContext context, AuthenticationStates state) {
            //printstate);
            if (state is AuthenticationSuccessState) {
              final currentUser = FirebaseAuth.instance.currentUser;
              // Navigator.pop(context);
              /* if (currentUser!.uid == adminId) {
                Navigator.pushReplacementNamed(context, Routes.adminHome);
              } else { */
                if (state.authenticationPlatform ==
                        AuthenticationPlatform.google ||
                    state.authenticationPlatform ==
                        AuthenticationPlatform.facebook) {
                  Navigator.pushReplacementNamed(context, Routes.home);
                } else {
                  if (currentUser?.emailVerified != null && currentUser?.emailVerified ==true) {
                    Navigator.pushReplacementNamed(context, Routes.home);
                  } else {
                    Navigator.pushReplacementNamed(context, Routes.verifyEmail);
                  }
                }
              //}
            }
            if (state is AuthinticationLoadingState) {
              showDialog(
                context: context,
                barrierDismissible: false,
                builder: (context) => const Center(
                  child: CircularProgressIndicator(),
                ),
              );
            }
            if (state is LoadedState) {
              Navigator.pop(context);
            }
            if (state is AuthenticationFailedState) {
              // Navigator.pop(context);
              showDialog(
                context: context,
                barrierDismissible: false,
                builder: (context) => AlertDialog(
                  title: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(S.current.error,
                          style: TextStyle(
                              color: Theme.of(context).colorScheme.error)),
                      Divider(
                        color: Theme.of(context).colorScheme.onSurface,
                      ),
                    ],
                  ),
                  content: Text(state.errorMessage),
                  actions: [
                    TextButton(
                      onPressed: () => Navigator.pop(context, true),
                      child: Text(S.current.ok),
                    ),
                  ],
                ),
              );
            }
          },
        ),
      )),
    );
  }
}

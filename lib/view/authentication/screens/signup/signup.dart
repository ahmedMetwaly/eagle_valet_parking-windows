import 'package:eagle_valet_parking/models/employer_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../bloc/authentication_bloc/auth_events.dart';
import '../../../../../resources/string_manager.dart';
import '../../../../../resources/values_manager.dart';

import '../../../../bloc/authentication_bloc/auth_states.dart';
import '../../../../constants.dart';
import '../../../../generated/l10n.dart';
import '../../../../resources/routes.dart';
import '../login/widgets/email.dart';
import '../login/widgets/password.dart';
import "../../../../../bloc/authentication_bloc/auth_bloc.dart";
import 'widgets/name.dart';
import 'widgets/phone.dart';

class SignUp extends StatelessWidget {
  const SignUp({super.key});

  @override
  Widget build(BuildContext context) {
    final formKey = GlobalKey<FormState>();
    final nameController = TextEditingController();
    final emailController = TextEditingController();
    final passwordController = TextEditingController();
    final phoneNumber = TextEditingController();
    return Scaffold(
      appBar: AppBar(),
      body: SafeArea(
          child: Padding(
        padding: const EdgeInsets.all(PaddingManager.pMainPadding),
        child: BlocListener<AuthenticationBloc, AuthenticationStates>(
          listener: (BuildContext context, AuthenticationStates state) {
            //printstate);
            if (state is AuthenticationSuccessState) {
              final currentUser = FirebaseAuth.instance.currentUser;
              if (state.authenticationPlatform ==
                      AuthenticationPlatform.google ||
                  state.authenticationPlatform ==
                      AuthenticationPlatform.facebook) {
                Navigator.pushReplacementNamed(context, Routes.home);
              } else {
                if (currentUser!.emailVerified) {
                  Navigator.pushReplacementNamed(context, Routes.home);
                } else {
                  Navigator.pushReplacementNamed(context, Routes.verifyEmail);
                }
              }
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
          child: Form(
            key: formKey,
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(2.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    StringManager.signup,
                    style: Theme.of(context).textTheme.headlineMedium,
                  ),
                  const SizedBox(height: SizeManager.sSpace32),
                  Column(
                    children: [
                      Name(
                        nameController: nameController,
                        title: S.current.name,
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Email(inputController: emailController),
                      const SizedBox(
                        height: 10,
                      ),
                      Passsword(
                          inputController: passwordController,
                          insideSignInPage: false),
                      const SizedBox(
                        height: 10,
                      ),
                      Phone(controller: phoneNumber),
                      const SizedBox(
                        height: 10,
                      ),
                      GestureDetector(
                        onTap: () => Navigator.of(context)
                            .pushReplacementNamed(Routes.logIn),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            const Text(StringManager.alreadyHaveAccoount),
                            Icon(
                              Icons.arrow_forward_rounded,
                              size: SizeManager.sIconSize,
                              color: Theme.of(context).colorScheme.primary,
                            )
                          ],
                        ),
                      ),
                      const SizedBox(height: SizeManager.sSpace32),
                      ElevatedButton(
                        key: const Key("goHome"),
                        child: Text(StringManager.signup.toUpperCase()),
                        onPressed: () {
                          if (formKey.currentState!.validate()) {
                            AuthenticationBloc.employer = EmployerModel(
                              name: nameController.text,
                              email: emailController.text,
                              password: passwordController.text,
                              imageUrl: AuthenticationBloc.employer.imageUrl,
                              phoneNumber: phoneNumber.text,
                              //TODO:: update the parkingId from parking cupit
                              parkingId: ""
                            );
                            context
                                .read<AuthenticationBloc>()
                                .add(SignUpEvent());
                          }
                        },
                      ),
                    ],
                  ),
                  const SizedBox(height: SizeManager.sSpace32),
                  const Column(
                    children: [
                      const Center(
                          child: Text(
                        StringManager.signUpWithSc,
                        textAlign: TextAlign.center,
                      )),
                      const SizedBox(
                        height: SizeManager.sSpace16,
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      )),
    );
  }
}

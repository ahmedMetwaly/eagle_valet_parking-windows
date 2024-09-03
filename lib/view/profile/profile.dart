import "package:flutter/material.dart";
import "package:flutter_bloc/flutter_bloc.dart";

import "../../../bloc/authentication_bloc/auth_states.dart";
import "../../../bloc/authentication_bloc/auth_bloc.dart";
import "../../../generated/l10n.dart";
import "../../../resources/routes.dart";
import "../../../resources/values_manager.dart";
import "../../bloc/authentication_bloc/auth_events.dart";
import "../../models/employer_model.dart";
import "widgets/change_lang.dart";
import "widgets/change_profile_image.dart";
import "widgets/image_from_network.dart";
import "widgets/user_info.dart";

class Profile extends StatelessWidget {
  const Profile({super.key});
  @override
  Widget build(BuildContext context) {
    var previousScreen = ModalRoute.of(context)?.settings.arguments;
    return Scaffold(
        appBar: AppBar(
          leading: previousScreen == null ? const SizedBox() : null,
          leadingWidth: previousScreen == null ? 0.0 : null,
          title: Text(
            S.current.myProfile,
            style: Theme.of(context).textTheme.headlineMedium,
          ),
        ),
        body: BlocConsumer<AuthenticationBloc, AuthenticationStates>(
          builder: (BuildContext context, AuthenticationStates state) =>
              SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(PaddingManager.pMainPadding),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  state is AuthenticationSuccessState
                      ? const ChangeProfileImageWidget()
                      : ImageFromNetwork(
                          imagePath: AuthenticationBloc.employer.imageUrl ?? "",
                          height: 150,
                          width: 150,
                          fit: BoxFit.cover,
                        ),
                  const UserInfo(),
                  // const ChangeTheme(),
                  const ChangeLanguageWidget(),
           
                  const Spacer(),
                  ElevatedButton(
                      onPressed: () {
                        if (state is AuthenticationSuccessState) {
                          showDialog<bool>(
                            context: context,
                            barrierDismissible: false,
                            builder: (BuildContext context) {
                              return AlertDialog(
                                title: Text(S.current.confirmLogout),
                                content: Text(S.current.logoutDescription),
                                actions: [
                                  TextButton(
                                      onPressed: () {
                                        context
                                            .read<AuthenticationBloc>()
                                            .add(SignOutEvent());
                                        Navigator.pop(context, true);
                                      },
                                      child: Text(S.current.ok)),
                                  TextButton(
                                    onPressed: () =>
                                        Navigator.pop(context, true),
                                    child: Text(S.current.cancel),
                                  )
                                ],
                              );
                            },
                          );
                        }
                        if (state is AuthLogedOutState) {
                          Navigator.of(context).pushNamed(Routes.logIn);
                        }
                      },
                      child: SizedBox(
                        width: double.infinity,
                        child: Text(
                          state is AuthenticationSuccessState
                              ? S.current.logout
                              : S.current.login,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              color: Theme.of(context).colorScheme.background),
                        ),
                      )),
                ],
              ),
            ),
          ),
          listener: (BuildContext context, AuthenticationStates state) {
            if (state is AuthLogedOutState) {
              AuthenticationBloc.employer = EmployerModel(
                  uid: "0",
                  name:"",
                  email: "",
                  imageUrl: "",
                  password: "",
                  parkingId: "",
            );
              if (previousScreen != null) {
                Navigator.of(context).pushNamedAndRemoveUntil(Routes.logIn, (route)=>false);
              }
            }
          },
        ));
  }
}


import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gif_view/gif_view.dart';

import '../../../../../../bloc/authentication_bloc/auth_bloc.dart';
import '../../../../../../generated/l10n.dart';
import '../../../../../../resources/image_manager.dart';
import '../../../../../../resources/routes.dart';
import '../../../../../../resources/values_manager.dart';
import '../../../../../bloc/authentication_bloc/auth_events.dart';
import '../../../../../bloc/authentication_bloc/auth_states.dart';

class ResetEmail extends StatelessWidget {
  const ResetEmail({
    super.key,
  });
  @override
  Widget build(BuildContext context) {
     late GifController gifController;
    gifController = GifController(onFrame: (value) => value==24 ? gifController.pause():null);
    return Scaffold(
      appBar: AppBar(
        leadingWidth: 0,
        leading: const SizedBox(),
        actions: [
          IconButton(
              onPressed: () => Navigator.of(context).pop(),
              icon: const Icon(Icons.close))
        ],
      ),
      body: SafeArea(
          child: Padding(
        padding: const EdgeInsets.all(PaddingManager.pMainPadding),
        child: BlocConsumer<AuthenticationBloc, AuthenticationStates>(
          listener: (BuildContext context, AuthenticationStates state) {
            if (state is ForgetPasswordEmailSentState) {
              if (state.email.isNotEmpty) {
                Navigator.of(context).pop();
                showDialog<bool>(
                  context: context,
                  barrierDismissible: false,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      title: Text(S.current.sent),
                      content: Text(S.current.checkYourEmail),
                      actions: [
                        TextButton(
                            onPressed: () => Navigator.pop(context, true),
                            child: Text(S.current.ok)),
                      ],
                    );
                  },
                );
              }
            }
            if (state is AuthenticationFailedState) {
              Navigator.of(context).pop();
              showDialog<bool>(
                context: context,
                barrierDismissible: false,
                builder: (BuildContext context) {
                  return AlertDialog(
                    title: Text(S.current.error),
                    content: Text(state.errorMessage),
                    actions: [
                      TextButton(
                          onPressed: () => Navigator.pop(context, true),
                          child: Text(S.current.ok)),
                    ],
                  );
                },
              );
            }
          },
          builder: (context, state) => Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Center(
                  child: GifView.asset(
                ImageManager.shirts,
                controller: gifController,
                matchTextDirection: true,
                height: 300,
                width: 300,
                frameRate: 30, // default is 15 FPS
              )),
              const SizedBox(height: SizeManager.sSpace),
              Text(S.current.passwordReset,
                  style: Theme.of(context).textTheme.headlineMedium),
              const SizedBox(height: SizeManager.sSpace),
              Text(state is ForgetPasswordEmailSentState ? state.email : "",
                  style: Theme.of(context).textTheme.bodySmall),
              const SizedBox(height: SizeManager.sSpace16),
              Text(S.current.passwordResetDetails,
                  style: Theme.of(context).textTheme.bodySmall),
              const SizedBox(height: SizeManager.sSpace32),
              ElevatedButton(
                  child:Text( S.current.done),
                  onPressed: () {
                    Navigator.of(context).pushReplacementNamed(Routes.logIn);
                  }),
              const SizedBox(height: SizeManager.sSpace16),
              TextButton(
                  onPressed: () {
                    context
                        .read<AuthenticationBloc>()
                        .add(ForgetPasswordEvent());
                  },
                  child: Text(S.current.resendEmail)),
            ],
          ),
        ),
      )),
    );
  }
}
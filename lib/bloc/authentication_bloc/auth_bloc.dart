import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../models/employer_model.dart';
import '../../repositiries/authentication_services/authentication_service.dart';
import '../../repositiries/employer_repos/employer_repo.dart';
import 'auth_states.dart';
import 'auth_events.dart';

class AuthenticationBloc
    extends Bloc<AuthenticationEvents, AuthenticationStates> {
  AuthenticationBloc() : super(AuthenticationInitialState()) {
    on<SignInWithEmailEvent>(_logIn);
    on<ForgetPasswordEvent>(_forgetPassword);
    on<SendEmailVerficationEvent>(_sendEmailVerfication);
    on<SignOutEvent>(_logOut);
    on<AppStarted>(_checkTheUserLogged);
  }

  static EmployerModel employer = EmployerModel(
    uid: "0",
    name: "",
    email: "",
    password: "",
    imageUrl: "",
    phoneNumber: "",
    parkingId: ""
  );

  FutureOr<void> _checkTheUserLogged(
      AppStarted event, Emitter<AuthenticationStates> emit) async {
    final userFireBase = FirebaseAuth.instance.currentUser;
    //print"checking if the user is null or not");
    if (userFireBase != null) {
      employer = await EmployerRepo().getEmployerData(userFireBase.uid);
      //print"user found loggedIn");
      emit(AuthenticationSuccessState(employer: employer));
    } else {
      //print"No user");
      emit(AuthLogedOutState());
    }
  }

  FutureOr<void> _logIn(
      SignInWithEmailEvent event, Emitter<AuthenticationStates> emit) async {
    emit(AuthinticationLoadingState());
    try {
      await FirebaseAuthService.signIn(
              emailAddress: employer.email ?? "",
              password: employer.password ?? "")
          .then((value) async {
        if (value is EmployerModel) {
          employer = await EmployerRepo().getEmployerData(value.uid ?? "0");
          print(employer.name);
          print(employer.parkingId);
          emit(LoadedState());

          emit(AuthenticationSuccessState(employer: employer));
        } else {
          emit(LoadedState());

          emit(AuthenticationFailedState(errorMessage: value.toString()));
        }
      });
    } catch (e) {
      emit(LoadedState());

      emit(AuthenticationFailedState(errorMessage: e.toString()));
    }
  }

  FutureOr<void> _forgetPassword(
      ForgetPasswordEvent event, Emitter<AuthenticationStates> emit) async {
    try {
      emit(AuthinticationLoadingState());
      await FirebaseAuthService.forgotPassword(employer.email ?? "")
          .then((value) {
        if (value == true) {
          emit(LoadedState());

          emit(ForgetPasswordEmailSentState(
              email: AuthenticationBloc.employer.email ?? ""));
        } else {
          emit(LoadedState());

          emit(AuthenticationFailedState(errorMessage: value));
        }
      });
    } catch (error) {
      emit(LoadedState());

      emit(AuthenticationFailedState(errorMessage: error.toString()));
    }
  }

  FutureOr<void> _logOut(
      SignOutEvent event, Emitter<AuthenticationStates> emit) async {
    emit(AuthinticationLoadingState());
    await FirebaseAuthService.logOut();
    emit(LoadedState());

    emit(AuthLogedOutState());
  }

  FutureOr<void> _sendEmailVerfication(SendEmailVerficationEvent event,
      Emitter<AuthenticationStates> emit) async {
    try {
      await FirebaseAuthService.sendEmailVerfication().then((value) {
        if (value == true) {
          emit(EmailVerficationSentState(
              email: AuthenticationBloc.employer.email ?? ""));
        }
      });
    } catch (error) {
      emit(LoadedState());

      emit(AuthenticationFailedState(errorMessage: error.toString()));
    }
  }
}

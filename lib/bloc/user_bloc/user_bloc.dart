import 'dart:async';

import 'package:eagle_valet_parking/repositiries/employer_repos/employer_repo.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';

import '../authentication_bloc/auth_bloc.dart';
import 'user_event.dart';
import 'user_state.dart';

class UserBloc extends Bloc<UserEvents, UserState> {
  UserBloc() : super(InitialFirestore()) {
    on<ChangeProfileImage>(_changeProfileImage);
  }

  late XFile profileImage;
  FutureOr<void> _changeProfileImage(
      ChangeProfileImage event, Emitter<UserState> emit) async {
    try {
      emit(UpdatindDataState());
      await EmployerRepo()
          .uploadImage(
        employerId: AuthenticationBloc.employer.uid ?? "0",
        image: profileImage,
      )
          .then((value) {
        ////print"image uploaded");
        AuthenticationBloc.employer.imageUrl = value;
        return emit(UpdatedUserDataState(user: AuthenticationBloc.employer));
      });
    } catch (error) {
      emit(UpdateFailedDataState(errorMessage: error.toString()));
    }
  }
}

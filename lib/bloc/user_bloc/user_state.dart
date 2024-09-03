
import '../../models/employer_model.dart';

abstract class UserState {}
class  InitialFirestore extends UserState {}
class UpdatindDataState extends UserState {}
class  UpdatingFavoriteState  extends UserState {}
class  UpdatingBagState  extends UserState {
  //final String productId;

  //UpdatingBagState({required this.productId});
}

class UpdatedUserDataState extends UserState {
  final EmployerModel user;

  UpdatedUserDataState({required this.user});
}
class UpdatedUserFavoriteState extends UserState {
  final EmployerModel user;

  UpdatedUserFavoriteState({required this.user});
}

class UpdatedUserBagState extends UserState {
  final EmployerModel user;

  UpdatedUserBagState({required this.user});
}
class UpdateFailedDataState extends UserState {
  final String errorMessage;

  UpdateFailedDataState({required this.errorMessage});
}

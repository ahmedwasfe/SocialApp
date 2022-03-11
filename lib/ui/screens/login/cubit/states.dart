import 'package:untitled1/model/user_model.dart';

abstract class LoginStates {}

class LoginInitState extends LoginStates {}

class VisiblePasswordState extends LoginStates {}

class LoginLoadingState extends LoginStates {}

class LoginSuccessState extends LoginStates {
  String? userId;
  LoginSuccessState(this.userId);
}

class LoginFailedState extends LoginStates {
  final String error;

  LoginFailedState(this.error);
}

class GetUserDataSuccessState extends LoginStates {}

class GetUserDataFailedState extends LoginStates {
  String? error;

  GetUserDataFailedState(this.error);
}
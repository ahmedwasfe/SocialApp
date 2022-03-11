
import 'package:firebase_auth/firebase_auth.dart';
import 'package:untitled1/model/user_model.dart';

abstract class RegisterStates {
}

class RegisterInitState extends RegisterStates {}

class VisiblePasswordState extends RegisterStates {}

class RegisterLoadingState extends RegisterStates {}

class RegisterSuccessState extends RegisterStates {}

class RegisterFailedState extends RegisterStates {
  final String error;
  RegisterFailedState(this.error);
}

class CreateUserSuccessState extends RegisterStates {
  String? userId;
  CreateUserSuccessState(this.userId);
}

class CreateUserFailedState extends RegisterStates {
  final String error;
  CreateUserFailedState(this.error);
}
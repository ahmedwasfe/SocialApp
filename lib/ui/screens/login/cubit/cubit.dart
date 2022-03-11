
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:untitled1/model/user_model.dart';
import 'package:untitled1/ui/screens/login/cubit/states.dart';
import 'package:untitled1/utils/components/constants.dart';

class LoginCubit extends Cubit<LoginStates> {
  LoginCubit() : super(LoginInitState());

  bool isPasswordVisible = true;
  IconData passwordVisibleIcon = Icons.visibility_outlined;

  static LoginCubit getCubit(BuildContext context) =>
      BlocProvider.of(context);

  void visiblePassword() {
    isPasswordVisible = !isPasswordVisible;
    passwordVisibleIcon = isPasswordVisible
        ? Icons.visibility_outlined
        : Icons.visibility_off_outlined;
    emit(VisiblePasswordState());
  }

  void loginUser({
    required String email,
    required String password,
}){
    emit(LoginLoadingState());
    FirebaseAuth.instance.signInWithEmailAndPassword(email: email, password: password)
    .then((value) {
      print("User UID: ${value.user!.uid}");
      print("User Email: ${value.user!.email}");
      emit(LoginSuccessState(value.user!.uid, ));
    })
    .catchError((error) {
      print("catchError: ${error.toString()}");
      emit(LoginFailedState(error.toString()));
    });
  }
}

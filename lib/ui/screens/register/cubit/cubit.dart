import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:untitled1/model/user_model.dart';
import 'package:untitled1/ui/screens/register/cubit/states.dart';
import 'package:untitled1/utils/components/constants.dart';

class RegisterCubit extends Cubit<RegisterStates> {
  RegisterCubit() : super(RegisterInitState());

  bool isVisiblePassword = true;
  IconData visiblePassIcon = Icons.visibility_outlined;

  static RegisterCubit getCubit(context) => BlocProvider.of(context);

  void visiblePassword() {
    isVisiblePassword = !isVisiblePassword;
    visiblePassIcon = isVisiblePassword
        ? Icons.visibility_outlined
        : Icons.visibility_off_outlined;
    emit(VisiblePasswordState());
  }

  void registerUser({
    required String name,
    required String phone,
    required String email,
    required String password,
  }) {
    emit(RegisterLoadingState());
    FirebaseAuth.instance
        .createUserWithEmailAndPassword(email: email, password: password)
        .then((value) {
      print("User UID: ${value.user!.uid}");
      print("User Email: ${value.user!.email}");
      saveUserData(uid: value.user!.uid, name: name, phone: phone, email: email);
      // emit(RegisterSuccessState());
    }).catchError((error) {
      print("catchError: ${error.toString()}");
      emit(RegisterFailedState(error.toString()));
    });
  }

  void saveUserData({
    required String uid,
    required String name,
    required String phone,
    required String email,
  }) {
    UserModel user = UserModel(
        userId: uid,
        name: name,
        phone: phone,
        email: email,
       isEmailVerified: false);
    FirebaseFirestore.instance
        .collection(Const.COLLECTION_USERS)
        .doc(uid)
        .set(user.toJson())
        .then((value) {
      emit(CreateUserSuccessState(user.userId));
    }).catchError((error) {
      print("catchError: ${error.toString()}");
      emit(CreateUserFailedState(error.toString()));
    });
  }
}

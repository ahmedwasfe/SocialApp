import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:untitled1/home/cubit/states.dart';
import 'package:untitled1/model/user_model.dart';
import 'package:untitled1/utils/components/constants.dart';

class AppCubit extends Cubit<AppStates> {
  AppCubit() : super(AppInitState());

  UserModel? user;

  static AppCubit getCubit(BuildContext context) => BlocProvider.of(context);

  String _getUserId() {
    return Helper.getCurrentUserId();
  }

  void getUserData() {
    emit(AppLoadingState());
    FirebaseFirestore.instance
        .collection(Const.COLLECTION_USERS)
        .doc(_getUserId())
        .get()
        .then((value) {
      user = UserModel.fromJson(value.data()!);
      print("Values: ${value.data()}");
      updateEmailVerification(_getUserId());
      emit(GetUserDataSuccessState());
    }).catchError((error) {
      print("catchError: ${error.toString()}");
      emit(GetUserDataFailedState(error.toString()));
    });
  }

  void updateEmailVerification(String userId) {
    if (FirebaseAuth.instance.currentUser!.emailVerified) {
      FirebaseFirestore.instance
          .collection(Const.COLLECTION_USERS)
          .doc(userId)
          .update({'isEmailVerified': true}).then((value) {
        emit(UpdateEmailVerificationState());
      });
    }
  }
}

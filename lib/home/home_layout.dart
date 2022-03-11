import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:untitled1/home/cubit/cubit.dart';
import 'package:untitled1/home/cubit/states.dart';
import 'package:untitled1/model/user_model.dart';
import 'package:untitled1/style/colors.dart';
import 'package:untitled1/ui/screens/login/login_screen.dart';
import 'package:untitled1/utils/components/components.dart';
import 'package:untitled1/utils/components/constants.dart';
import 'package:untitled1/utils/local/cache_helper.dart';

class HomeLayout extends StatelessWidget {
  HomeLayout({Key? key}) : super(key: key);

  UserModel _user = UserModel.empty();
  String? _name;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AppCubit()..getUserData(),
      child: BlocConsumer<AppCubit, AppStates>(
        listener: (_, state) {},
        builder: (_, state) {
          AppCubit appCubit = AppCubit.getCubit(_);
          return Scaffold(
            appBar: AppBar(
              title: Text("News Feed"),
              actions: [
                IconButton(
                  icon: Icon(Icons.exit_to_app_outlined),
                  onPressed: () {
                    FirebaseAuth.instance.signOut().then((value) {
                      CacheHelper.removeData(key: Const.KEY_USER).then(
                          (value) => navigateAndFinish(context, LoginScreen()));
                    });
                  },
                )
              ],
            ),
            body: ConditionalBuilder(
              condition: appCubit.user != null,
              builder: (context) {
                if (appCubit.user != null) {
                  _user = appCubit.user!;
                }
                return Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    children: [
                      // if(_user.isEmailVerified != null)
                      if (!FirebaseAuth.instance.currentUser!.emailVerified)
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: 10.0),
                          decoration: BoxDecoration(
                              color: Colors.amber,
                              borderRadius: BorderRadius.circular(10.0)),
                          child: Row(
                            children: [
                              Text(
                                "Please verify your account",
                                style: TextStyle(color: Colors.black),
                              ),
                              Spacer(),
                              TextButton(
                                child: Text(
                                  "VERIFY",
                                  style: TextStyle(color: Colors.black),
                                ),
                                onPressed: () => _sendEmailVerification(),
                              ),
                            ],
                          ),
                        ),
                      SizedBox(
                        height: 50.0,
                      ),
                      Text("${appCubit.user!.name}"),
                      Text("${_user.email}"),
                      Text("${_user.phone}"),
                      Text("${_user.isEmailVerified}"),
                      SizedBox(height: 10.0),
                      Text(
                          "${FirebaseAuth.instance.currentUser!.emailVerified}"),
                    ],
                  ),
                );
              },
              fallback: (context) => Center(child: CircularProgressIndicator()),
            ),
          );
        },
      ),
    );
  }

  void _sendEmailVerification() {
    FirebaseAuth.instance.currentUser!
        .sendEmailVerification()
        .then((value) =>
            showToast(message: "Check your mail", state: ToastStates.SUCCESS))
        .catchError((error) {
      print("catchError: ${error.toString()}");
    });
  }


}

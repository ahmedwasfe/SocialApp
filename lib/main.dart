import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:untitled1/home/cubit/cubit.dart';
import 'package:untitled1/home/cubit/states.dart';
import 'package:untitled1/home/home_layout.dart';
import 'package:untitled1/style/themes.dart';
import 'package:untitled1/ui/screens/login/login_screen.dart';
import 'package:untitled1/utils/components/constants.dart';
import 'package:untitled1/utils/local/cache_helper.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await CacheHelper.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  Widget startApp() {
    if (CacheHelper.getData(key: Const.KEY_USER) != null)
      return HomeLayout();
    else
      return LoginScreen();
  }

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: lightTheme(),
      home: startApp(),
    );
  }
}

import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:untitled1/home/home_layout.dart';
import 'package:untitled1/style/colors.dart';
import 'package:untitled1/ui/screens/login/cubit/cubit.dart';
import 'package:untitled1/ui/screens/login/cubit/states.dart';
import 'package:untitled1/ui/screens/register/register_screen.dart';
import 'package:untitled1/utils/components/components.dart';
import 'package:untitled1/utils/components/constants.dart';
import 'package:untitled1/utils/local/cache_helper.dart';

class LoginScreen extends StatelessWidget {
  var formKey = GlobalKey<FormState>();
  var emailController = TextEditingController();
  var passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => LoginCubit(),
      child: BlocConsumer<LoginCubit, LoginStates>(
        listener: (context, state) {
          if (state is LoginSuccessState) {
            CacheHelper.saveData(key: Const.KEY_USER, value: state.userId)
                .then((value) => navigateAndFinish(context, HomeLayout()));
          }
          if (state is LoginFailedState) {
            showToast(message: state.error, state: ToastStates.FAILED);
          }
        },
        builder: (context, state) {
          LoginCubit loginCubit = LoginCubit.getCubit(context);
          return Scaffold(
            appBar: AppBar(),
            body: Center(
              child: SingleChildScrollView(
                physics: BouncingScrollPhysics(),
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Form(
                    key: formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "LOGIN",
                          style: Theme
                              .of(context)
                              .textTheme
                              .headline4!
                              .copyWith(
                            color: Colors.black,
                          ),
                        ),
                        Text(
                          "Login now to comunication with your friends",
                          style: Theme
                              .of(context)
                              .textTheme
                              .bodyText1!
                              .copyWith(color: Colors.grey),
                        ),
                        SizedBox(
                          height: 30.0,
                        ),
                        CustomFormField(
                          controller: emailController,
                          keyboardType: TextInputType.emailAddress,
                          lable: "Email",
                          prefix: Icons.email_outlined,
                          validate: (value) {
                            if (value!.isEmpty)
                              return "Please enter your email";
                            else if (!Helper.emailValidate().hasMatch(value))
                              return "Please enter email valide";
                            return null;
                          },
                        ),
                        SizedBox(height: 20.0),
                        CustomFormField(
                          controller: passwordController,
                          keyboardType: TextInputType.visiblePassword,
                          lable: "Password",
                          isPassword: loginCubit.isPasswordVisible,
                          prefix: Icons.lock_open_outlined,
                          suffix: loginCubit.passwordVisibleIcon,
                          suffixClick: () => loginCubit.visiblePassword(),
                          validate: (value) {
                            if (value!.isEmpty)
                              return "Please enter the password";
                            else if (value.length < 6)
                              return "The password must be greater than 6 character";
                            return null;
                          },
                        ),
                        SizedBox(height: 20.0),
                        ConditionalBuilder(
                          condition: state is! LoginLoadingState,
                          builder: (_) =>
                              CustomButton(
                                  text: "login",
                                  isUpperCase: true,
                                  background: deepOrangeColor,
                                  radius: 10.0,
                                  click: () {
                                    if (formKey.currentState!.validate()) {
                                      String email = emailController.text;
                                      String password = passwordController.text;
                                      loginCubit.loginUser(
                                          email: email, password: password);
                                      print(
                                          "Email: $email Password: $password");
                                    }
                                  }),
                          fallback: (_) =>
                              Center(child: CircularProgressIndicator()),
                        ),
                        SizedBox(
                          height: 15.0,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text("Don\'t have an account?"),
                            TextButton(
                              onPressed: () =>
                                  navigateTo(context, RegisterScreen()),
                              child: Text("Register now",
                                  style: TextStyle(color: deepOrangeColor)),),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

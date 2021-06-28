import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:socialapp/Screens/register_Screen.dart';
import 'package:socialapp/Screens/social_layout_screen.dart';
import 'package:socialapp/cubit/login_cubit/cubit.dart';
import 'package:socialapp/cubit/login_cubit/states.dart';
import 'package:socialapp/cubit/social_cubit/cubit.dart';
import 'package:socialapp/network/chash_helper.dart';

import '../shared/componnatnts.dart';

// ignore: must_be_immutable
class LoginScreen extends StatelessWidget {
  var formKey = GlobalKey<FormState>();
  var emailController = TextEditingController();
  var passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => SocialLogInCubit(),
      child: BlocConsumer<SocialLogInCubit, SocialLogInStates>(
        listener: (context, state) {
          if (state is SocialLogInErrorState) {
            myToast(state.error.toString(), Colors.red);
          }

          if (state is SocialLogInSuccessState) {
            CacheHelper.saveData(key: "uId", value: state.uId).then((value) {
              uId = CacheHelper.getData(key: 'uId');
              SocialCubit.get(context).getUserData().then((value) {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => LayOutScreen()));
              });
            });
          }
        },
        builder: (context, state) {
          return Scaffold(
            appBar: AppBar(),
            body: Center(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Form(
                    key: formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'LOGIN',
                          style: Theme.of(context).textTheme.headline4.copyWith(
                                color: Colors.black,
                              ),
                        ),
                        Text(
                          'Login now to browse our hot offers',
                          style: Theme.of(context).textTheme.bodyText1.copyWith(
                                color: Colors.grey,
                              ),
                        ),
                        SizedBox(
                          height: 30.0,
                        ),
                        defaultFormField(
                          controller: emailController,
                          type: TextInputType.emailAddress,
                          validate: (String value) {
                            if (value.isEmpty) {
                              return 'please enter your email address';
                            }
                          },
                          label: 'Email Address',
                          prefix: Icons.email_outlined,
                        ),
                        SizedBox(
                          height: 15.0,
                        ),
                        defaultFormField(
                          controller: passwordController,
                          type: TextInputType.visiblePassword,
                          suffix: Icons.vpn_key,
                          onSubmit: (value) {},
                          validate: (String value) {
                            if (value.isEmpty) {
                              return 'password is too short';
                            }
                          },
                          label: 'Password',
                          prefix: Icons.lock_outline,
                        ),
                        SizedBox(
                          height: 30.0,
                        ),
                        state is SocialLogInSuccessLoadingState
                            ? Center(child: CircularProgressIndicator())
                            : Container(
                                width: MediaQuery.of(context).size.width,
                                height: MediaQuery.of(context).size.height / 18,
                                child: ElevatedButton(
                                  onPressed: () {
                                    SocialLogInCubit.get(context).user(
                                        email: emailController.text,
                                        password: passwordController.text);
                                  },
                                  child: Text("LOGIN",
                                      style: TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.w400,
                                          fontFamily: "Quicksand Bold")),
                                ),
                              ),
                        SizedBox(
                          height: 15.0,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'Don\'t have an account?',
                            ),
                            defaultTextButton(
                              function: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            RegisterScreen()));
                              },
                              text: 'register',
                            ),
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

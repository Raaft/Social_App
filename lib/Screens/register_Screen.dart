import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:socialapp/cubit/register_cubit/cubit.dart';
import 'package:socialapp/cubit/register_cubit/states.dart';

import '../shared/componnatnts.dart';
import 'login_Screen.dart';

class RegisterScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var emailController = TextEditingController();
    var phoneController = TextEditingController();
    var nameController = TextEditingController();

    var passwordController = TextEditingController();
    var formKey = GlobalKey<FormState>();
    return BlocProvider(
      create: (BuildContext context) => SocialRegisterCubit(),
      child: BlocConsumer<SocialRegisterCubit, RegisterState>(
          listener: (context, state) {
        if (state is RegisterErrorState)
          myToast(state.error.toString(), Colors.red);
        if (state is CreateSuccessState) {
          Navigator.pushReplacement(
              context, MaterialPageRoute(builder: (context) => LoginScreen()));
        }
      }, builder: (context, state) {
        return Scaffold(
            body: Center(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Form(
                key: formKey,
                child: Column(
                  children: [
                    Text("Register",
                        style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w400,
                            fontFamily: "Quicksand Bold")),
                    SizedBox(
                      height: 10,
                    ),
                    Text("Register now to browse our hot Offers",
                        style: TextStyle(
                            fontSize: 16, fontFamily: "Quicksand Bold")),
                    SizedBox(height: 40),
                    defaultFormField(
                        controller: nameController,
                        label: "name",
                        type: TextInputType.name,
                        prefix: Icons.person,
                        validate: (String value) {
                          if (value.isEmpty) {
                            return "Enter Your Name";
                          } else
                            return null;
                        }),
                    SizedBox(height: 20),
                    defaultFormField(
                        controller: emailController,
                        label: "Email Address",
                        type: TextInputType.emailAddress,
                        prefix: Icons.email_outlined,
                        validate: (String value) {
                          if (value.isEmpty) {
                            return "Enter Your email";
                          } else
                            return null;
                        }),
                    SizedBox(height: 20),
                    defaultFormField(
                        controller: phoneController,
                        label: "phone",
                        type: TextInputType.phone,
                        prefix: Icons.phone,
                        validate: (String value) {
                          if (value.isEmpty) {
                            return "Enter Your phone";
                          } else
                            return null;
                        }),
                    SizedBox(height: 20),
                    defaultFormField(
                        controller: passwordController,
                        label: "Password",
                        type: TextInputType.visiblePassword,
                        prefix: Icons.vpn_key,
                        validate: (String value) {
                          if (value.isEmpty) {
                            return "Enter Your Password";
                          } else
                            return null;
                        }),
                    SizedBox(height: 20),
                    SizedBox(
                      height: 30,
                    ),
                    state is RegisterLoadingState
                        ? Center(child: CircularProgressIndicator())
                        : Container(
                            width: MediaQuery.of(context).size.width,
                            height: MediaQuery.of(context).size.height / 18,
                            child: ElevatedButton(
                              onPressed: () {
                                SocialRegisterCubit.get(context).userRegister(
                                  email: emailController.text,
                                  password: passwordController.text,
                                  name: nameController.text,
                                  phone: passwordController.text,
                                );
                              },
                              child: Text("REGISTER",
                                  style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.w400,
                                      fontFamily: "Quicksand Bold")),
                            ),
                          ),
                    SizedBox(
                      height: 20,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text("Do You have an account ? ",
                            style: TextStyle(
                                fontSize: 16,
                                color: Colors.black,
                                fontFamily: "Quicksand Bold")),
                        TextButton(
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => LoginScreen()));
                            },
                            child: Text("SIGNIN",
                                style: TextStyle(
                                    fontSize: 16,
                                    color: Colors.blue,
                                    fontFamily: "Quicksand Bold")))
                      ],
                    )
                  ],
                ),
              ),
            ),
          ),
        ));
      }),
    );
  }
}

import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:socialapp/cubit/login_cubit/states.dart';

class SocialLogInCubit extends Cubit<SocialLogInStates> {
  SocialLogInCubit() : super(SocialLogInInitialState());

  static SocialLogInCubit get(context) => BlocProvider.of(context);

  void user({@required email, @required password}) {
    emit(SocialLogInSuccessLoadingState());
    FirebaseAuth.instance
        .signInWithEmailAndPassword(email: email, password: password)
        .then((value) {
      print(value.user.email);
      print(value.user.uid);
      emit(SocialLogInSuccessState(value.user.uid));
    }).catchError((error) {
      print(error.toString());
      emit(SocialLogInErrorState(error.toString()));
      FirebaseAuth.instance.signOut();
    });
  }

  Future<void> signOut() async {
    await FirebaseAuth.instance.signOut();
    emit(SocialSignoutState());
  }
}

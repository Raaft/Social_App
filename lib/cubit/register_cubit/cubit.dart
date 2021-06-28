import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:socialapp/cubit/register_cubit/states.dart';
import 'package:socialapp/models/user_model.dart';

class SocialRegisterCubit extends Cubit<RegisterState> {
  SocialRegisterCubit() : super(RegisterInitialState());

  static SocialRegisterCubit get(context) => BlocProvider.of(context);

  void userRegister(
      {@required email, @required password, @required name, @required phone}) {
    emit(RegisterLoadingState());
    FirebaseAuth.instance
        .createUserWithEmailAndPassword(
      email: email,
      password: password,
    )
        .then((value) {
      print(value.user.email);
      print(value.user.uid);
      userCreate(
        uId: value.user.uid,
        email: email,
        name: name,
        phone: phone,
      );
      emit(RegisterSuccessState());
    }).catchError((error) {
      emit(RegisterErrorState(error));
    });
  }

  void userCreate({
    @required email,
    @required uId,
    @required name,
    @required phone,
  }) {
    emit(CreateLoadingState());
    SocialUserModel model = SocialUserModel(
      phone: phone,
      name: name,
      email: email,
      uId: uId,
      image:
          'https://upload.wikimedia.org/wikipedia/commons/thumb/b/bc/Unknown_person.jpg/1200px-Unknown_person.jpg',
      cover:'https://upload.wikimedia.org/wikipedia/commons/thumb/b/bc/Unknown_person.jpg/1200px-Unknown_person.jpg' ,
      bio: "Enter Your Bio",
      isEmailVerified: false,
    );
    FirebaseFirestore.instance
        .collection("users")
        .doc(uId)
        .set(model.toMap())
        .then((value) {
      emit(CreateSuccessState());
    }).catchError((error) {
      emit(CreateErrorState(error));
    });
  }
}

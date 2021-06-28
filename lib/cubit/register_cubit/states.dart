abstract class RegisterState {}

class RegisterInitialState extends RegisterState {}

class RegisterLoadingState extends RegisterState {}

class RegisterSuccessState extends RegisterState {}

class RegisterErrorState extends RegisterState {
  final error;
  RegisterErrorState(this.error);
}

class CreateLoadingState extends RegisterState {}

class CreateSuccessState extends RegisterState {}

class CreateErrorState extends RegisterState {
  final error;
  CreateErrorState(this.error);
}

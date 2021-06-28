
abstract class SocialLogInStates {}

class SocialLogInInitialState extends SocialLogInStates {}

class SocialLogInSuccessLoadingState extends SocialLogInStates {}

class SocialLogInSuccessState extends SocialLogInStates {
  final String uId;

  SocialLogInSuccessState(this.uId);
}

class SocialLogInErrorState extends SocialLogInStates {
  final String error;

  SocialLogInErrorState(this.error);

}


class SocialSignoutState extends SocialLogInStates {}




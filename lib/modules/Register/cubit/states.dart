abstract class SocialRegisterStates{}

class SocialRegisterIntialStates extends SocialRegisterStates{}

class SocialRegisterLoadingStates extends SocialRegisterStates{}

class SocialRegisterSucessStates extends SocialRegisterStates{
  //  final SocialLoginModel LoginModel;

  //  SocialRegisterSucessStates(this.LoginModel);
}

class SocialRegisterErrorStates extends SocialRegisterStates{
  final String error;

  SocialRegisterErrorStates(this.error);
}
class SocialCreateUserSucessStates extends SocialRegisterStates{
  //  final SocialLoginModel LoginModel;

  //  SocialRegisterSucessStates(this.LoginModel);
}

class SocialCreateUserErrorStates extends SocialRegisterStates{
  final String error;

  SocialCreateUserErrorStates(this.error);
}

class ChangePasswordVisibalityState extends SocialRegisterStates{}




class SocialRegisterSucessUserStates extends SocialRegisterStates{}
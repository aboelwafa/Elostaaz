// prevent take object=> abstract
abstract class MotoLoginStates{}
// create 4 states use them in cubit file
class MotoLoginIntialStates extends MotoLoginStates{}

class MotoLoginLoadingStates extends MotoLoginStates{}

class MotoLoginSucessStates extends MotoLoginStates{}

class MotoLoginErrorStates extends MotoLoginStates{
  final String error;

  MotoLoginErrorStates(this.error);
}



// state to know change visible password
class ChangePasswordState extends MotoLoginStates{}

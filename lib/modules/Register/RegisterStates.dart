
abstract class RegisterStates {}

class InitialState extends RegisterStates {}

class RegisterLoadingState extends RegisterStates {}

class RegisterSuccessState extends RegisterStates {
}

class RegisterErrorState extends RegisterStates {
  final String error;
  RegisterErrorState(this.error);
}

class RegisterVisabilityState extends RegisterStates {}

class RegisterCreateUserSuccessState extends RegisterStates {
}

class RegisterCreateUserErrorState extends RegisterStates {
  final String error;
  RegisterCreateUserErrorState(this.error);
}

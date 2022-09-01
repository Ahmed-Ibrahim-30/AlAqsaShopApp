import '../../Model/login.dart';

abstract class SignStates{}
class InitSignState extends SignStates{}
class ChangeFormState extends SignStates{}
class ChangePasswordVisibilityState extends SignStates{}


class LoginLoadingState extends SignStates{}
class LoginSuccessState extends SignStates{
  SignInModel loginResponse;
  LoginSuccessState(this.loginResponse);
}
class LoginErrorState extends SignStates{}

class RegisterLoadingState extends SignStates{}
class RegisterSuccessState extends SignStates{
  SignInModel registerResponse;
  RegisterSuccessState(this.registerResponse);
}
class RegisterErrorState extends SignStates{}


class UpdateLoadingState extends SignStates{}
class UpdateSuccessState extends SignStates{
  bool status;
  String message;
  UpdateSuccessState(this.status,this.message);
}
class UpdateErrorState extends SignStates{
  String message;
  UpdateErrorState(this.message);
}
class ChangeImageState extends SignStates{}
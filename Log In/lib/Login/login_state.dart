
import 'package:login/auth/form_submission_status.dart';

class LoginState{
  final String userName;
  bool get isValidUsername => userName.length>3;   //username validation

  final String password;
  bool get isValidPassword => password.length>6;   //password validation

  final FormSubmissionStatus formStatus;

  LoginState({
     this.userName='',
     this.password='',
    this.formStatus=const InitialFormStatus()
  });

  LoginState copyWith({

  String? userName,
  String? password,
  FormSubmissionStatus? formStatus,

}) {
    return LoginState(
      userName: userName ?? this.userName,
      password: password ?? this.password,
      formStatus: formStatus ?? this.formStatus,
    );
  }

}
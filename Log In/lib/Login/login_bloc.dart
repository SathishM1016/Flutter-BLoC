import 'package:login/Login/login_event.dart';
import 'package:login/Login/login_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:login/auth/auth_repo.dart';
import 'package:login/auth/form_submission_status.dart';

class LoginBloc extends Bloc<LoginEvent,LoginState>{

  final AuthRepo authRepo;

  LoginBloc({required this.authRepo}):super(LoginState());

  @override
  Stream<LoginState> mapEventToState(LoginEvent event) async* {

    if (event is LoginUserNameChanged){

      yield state.copyWith(userName: event.userName);

    } else if (event is LoginPasswordChanged){

      yield state.copyWith(password: event.password);

    }else if (event is LoginSubmitted){

      yield state.copyWith(formStatus: FormSubmitting());

      try{
        await authRepo.login();
        yield state.copyWith(formStatus: SubmissionSuccess());
      }catch(e){
        yield state.copyWith(formStatus: SubmissionFailed(exception:));
      }
    }

  }


}
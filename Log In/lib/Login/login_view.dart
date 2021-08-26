import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:login/Login/login_bloc.dart';
import 'package:login/Login/login_event.dart';
import 'package:login/Login/login_state.dart';
import 'package:login/auth/auth_repo.dart';
import 'package:login/auth/form_submission_status.dart';


class LoginView extends StatelessWidget {

  final formKey= GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:Text("Phonestly-LogIn"),
        centerTitle: true,
      ),
      body: BlocProvider(
        create: (context)=>LoginBloc(authRepo: context.read<AuthRepo>()),
        child: loginForm(),
      ),
    );
  }

  Widget loginForm(){
    return BlocListener<LoginBloc,LoginState>(
        listener: (context,state){
           final formStatus=state.formStatus;
           if(formStatus is SubmissionFailed){
             showSnackBar(context,formStatus.exception.toString());
           }
        },
      child: Form(
        key: formKey,
        child: Padding(
         padding: const EdgeInsets.all(16.0),
           child: Column(
             mainAxisAlignment: MainAxisAlignment.center,
                 children: [userNameField(),passwordField(),loginButton()],
          ),
       ),
      ),
    );

  }

  Widget userNameField(){
   return BlocBuilder<LoginBloc,LoginState>(builder: (context,state){
   return TextFormField(
   decoration: InputDecoration(
   icon: Icon(Icons.person),
   hintText: "User name",
   ),
    validator: (value) => state.isValidUsername? null: "Username is too short" ,
    onChanged: (value)=>context.read<LoginBloc>().add(
      LoginUserNameChanged(userName: value),
    ),
   );
   });

  }

  Widget passwordField(){
    return BlocBuilder<LoginBloc,LoginState>(builder: (context,state){
      return TextFormField(
        obscureText: true,
        decoration: InputDecoration(
          icon: Icon(Icons.security),
          hintText: "Password",
        ),
        validator: (value)=>state.isValidPassword?null:"password should be more than six characters",
        onChanged: (value)=>context.read<LoginBloc>().add(
          LoginPasswordChanged(password: value),
        ),
      );
    });

  }

  Widget loginButton(){
    return BlocBuilder<LoginBloc,LoginState>(builder: (context,state){
      return state.formStatus is FormSubmitting ?
        CircularProgressIndicator():
        ElevatedButton(
        onPressed: (){
          if(formKey.currentState!.validate()){
           context.read<LoginBloc>().add(LoginSubmitted());
          }
        },
        child: Text("Login"),
      );
    });

  }

  void showSnackBar(BuildContext context,String message){

    final snackBar= SnackBar( content: Text(message),);
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }
}

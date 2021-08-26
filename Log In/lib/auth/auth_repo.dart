class AuthRepo{

  Future<void>login()async{
    print("Logging in");
    await Future.delayed(Duration(seconds:3));
    print("Logged in");
    
  }


}
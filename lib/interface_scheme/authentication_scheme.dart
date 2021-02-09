class IAuthenticate {
  Future<void> signUpUser(context, email, name, surname, password) async {}
  Future<void> signOutUser(context) async {}
  Future<void> forgotPassword(context, email) async {}
  Future<void> loginUser(context, email, password) async {}
}

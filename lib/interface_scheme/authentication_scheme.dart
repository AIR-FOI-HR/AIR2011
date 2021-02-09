class IAuthenticate {
  Future<String> signUpUser(email, name, surname, password) async {}
  Future<void> signOutUser() async {}
  Future<bool> forgotPassword(email) async {}
  Future<String> loginUser(email, password) async {}
}

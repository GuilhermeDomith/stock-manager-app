

class LoginBloc {

  bool login(String username, String password) {
    print(username);
    print(password);
    return username != password;
  }
}
class LoginResponse {
  final bool isSuccess;
  final String authToken;
  final String error;
  final String username;

  LoginResponse({
    required this.isSuccess,
    this.authToken = "",
    this.error = "",
    this.username = "",
  });
}

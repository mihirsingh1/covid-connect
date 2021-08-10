class LoginResponse {
  final bool isSuccess;
  final String authToken;
  final String error;

  LoginResponse({
    required this.isSuccess,
    this.authToken = "",
    this.error = "",
  });
}

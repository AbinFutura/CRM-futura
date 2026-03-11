class LoginResponseModel {
  final bool success;
  final String message;
  final String xToken;
  final String? rToken;

  LoginResponseModel({
    required this.success,
    required this.message,
    required this.xToken,
    this.rToken,
  });

  factory LoginResponseModel.fromJson(Map<String, dynamic> json) {
    String? refreshToken;

    if (json["user"] != null && json["user"]["rToken"] != null) {
      refreshToken = json["user"]["rToken"].toString();
    }

    return LoginResponseModel(
      success: json["success"] ?? false,
      message: json["message"] ?? "",
      xToken: json["xToken"] ?? "",
      rToken: refreshToken,
    );
  }
}
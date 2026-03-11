class LoginRequestModel {

  final String mobileNumber;
  final String password;

  LoginRequestModel({
    required this.mobileNumber,
    required this.password,
  });

  Map<String, dynamic> toJson() {
    return {
      "mobileNumber": mobileNumber,
      "password": password,
    };
  }

}
class UserModel {

  final String id;
  final String fullName;
  final String mobileNumber;
  final String role;
  final String status;

  final String companyName;
  final String companyPhone;
  final String companyAddress;

  UserModel({
    required this.id,
    required this.fullName,
    required this.mobileNumber,
    required this.role,
    required this.status,
    required this.companyName,
    required this.companyPhone,
    required this.companyAddress,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {

    final company = json["companyId"];

    return UserModel(
      id: json["_id"],
      fullName: json["fullName"],
      mobileNumber: json["mobileNumber"],
      role: json["role"],
      status: json["status"],
      companyName: company["name"],
      companyPhone: company["phone"],
      companyAddress: company["address"],
    );
  }

}
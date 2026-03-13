class FormValidators {

  static String? required(String? value, String field) {
    if (value == null || value.trim().isEmpty) {
      return "$field is required";
    }
    return null;
  }

  static String? email(String? value) {
    if (value == null || value.isEmpty) {
      return "Email is required";
    }

    final emailRegex =
        RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');

    if (!emailRegex.hasMatch(value)) {
      return "Enter a valid email";
    }

    return null;
  }

  static String? phone(String? value) {
    if (value == null || value.isEmpty) {
      return "Phone number required";
    }

    if (value.length < 8) {
      return "Invalid phone number";
    }

    return null;
  }

}
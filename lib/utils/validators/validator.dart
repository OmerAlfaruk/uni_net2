class OValidator {
  static String? validateEmptyText(String? fieldName,String? value){
    if(value==null||value.isEmpty){
      return('$fieldName is required');

    }
  }
  static String? validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return "Email is required";
    }

    // Regular Expression for email validation
    //final emailRegExp = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
    if (!value.contains('@')) {
      return 'Invalid email address.';
    }
    return null;
  }

  static String? validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Password is required';
    }
    //check for minimum password length
    if (!value.contains(RegExp(r'[A-Z]'))) {
      return 'Password must be at least One Upper Case.';
    }
    if (!value.contains(RegExp(r'[0-9]'))) {
      return 'Password must be at least One number.';
    }
    if (!value.contains(RegExp(r'[!@#$%^&*(),.?":{}|<>]'))) {
      return 'Password must be at least spacial character.';
    }
    return null;
  }

  static String? validatePhoneNumber(String? value){
    if(value==null || value.isEmpty){
      return 'Phone number is required';
    }
    // regular expression for phone number validation (assuming 10 digit UsA phone number format)
    final phoneRegExpr=RegExp(r'^\d{10}$');
    if(!phoneRegExpr.hasMatch(value)){
      return 'Invalid phone number format (10 digits required)';
    }
    return null;
  }
}

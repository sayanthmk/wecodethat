class CustomValidator {
  static String? validatePinput(String? value) {
    if (value == null || value.length != 4) {
      return 'Please enter a 4-digit PIN';
    }
    return null;
  }
}

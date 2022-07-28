class ValidatorsPassword {
  static bool isLengthValid(String? value, int minLength) =>
      value!.length >= minLength;

  static bool hasUpperCaseCharacter(String? value) {
    if (value!.isEmpty) {
      return false;
    }

    const String regexExp = r'.*[A-Z].*';
    return RegExp(regexExp).hasMatch(value);
  }

  static bool hasNumberCharacter(String? value) {
    if (value!.isEmpty) {
      return false;
    }

    const String regexExp = r'[0-9]';
    return RegExp(regexExp).hasMatch(value);
  }
}

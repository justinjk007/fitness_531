class Helper {
  static String validateIfNumber(String value) {
    if (value.isEmpty) {
      return '\t\t\t\t\t\tPlease enter some text';
    }
    final n = num.tryParse(value);
    if (n == null) {
      return '\t\t\t\t\t\tPlease enter a number';
    } else {
      return null; // return null or the analyzer will complaint
    }
  }
}

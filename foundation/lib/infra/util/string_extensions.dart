extension StringParsing on String {
  String capitalize() {
    if (isEmpty) {
      return this;
    }
    return this[0].toUpperCase() + substring(1).toLowerCase();
  }

  String capitalizeEachWord() {
    final List<String> splittedText = replaceAll(RegExp(' +'), ' ').split(' ');

    if (isEmpty) {
      return this;
    }

    return splittedText.map((String str) => str.capitalize()).join(' ');
  }

  String restrictWordCharacters(int maxLength) {
    if (isEmpty) {
      return this;
    }

    return '${substring(0, maxLength)}...';
  }

  String removeAllHtmlTags() {
    final RegExp exp = RegExp(
      '<[^>]*>',
      multiLine: true,
    );

    return replaceAll(exp, '');
  }
}

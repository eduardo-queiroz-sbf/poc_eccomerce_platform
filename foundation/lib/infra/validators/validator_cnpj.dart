import '../util/formatter.dart';

class CoreValidatorCNPJ {
  static const List<String> blacklist = <String>[
    '00000000000000',
    '11111111111111',
    '22222222222222',
    '33333333333333',
    '44444444444444',
    '55555555555555',
    '66666666666666',
    '77777777777777',
    '88888888888888',
    '99999999999999'
  ];

  static int _verifierDigit(String cnpj) {
    int index = 2;

    final List<int> reverse =
        cnpj.split('').map(int.parse).toList().reversed.toList();

    int sum = 0;
    for (final int number in reverse) {
      sum += number * index;
      index = index == 9 ? 2 : index + 1;
    }

    final int mod = sum % 11;

    return mod < 2 ? 0 : 11 - mod;
  }

  static bool isValid(String? cnpj, [stripBeforeValidation = true]) {
    if (cnpj == null || cnpj.isEmpty) {
      return false;
    }

    if (stripBeforeValidation) {
      cnpj = strip(cnpj);
    }

    if (cnpj.length != 14) {
      return false;
    }

    if (blacklist.contains(cnpj)) {
      return false;
    }

    String numbers = cnpj.substring(0, 12);
    numbers += _verifierDigit(numbers).toString();
    numbers += _verifierDigit(numbers).toString();

    return numbers.substring(numbers.length - 2) ==
        cnpj.substring(cnpj.length - 2);
  }
}

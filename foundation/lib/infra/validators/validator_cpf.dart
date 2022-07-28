import '../util/formatter.dart';

class CoreValidatorCPF {
  static const List<String> blacklist = <String>[
    '00000000000',
    '11111111111',
    '22222222222',
    '33333333333',
    '44444444444',
    '55555555555',
    '66666666666',
    '77777777777',
    '88888888888',
    '99999999999',
    '12345678909'
  ];

  static int _verifierDigit(String cpf) {
    final List<int> numbers = cpf
        .split('')
        .map((String number) => int.parse(number, radix: 10))
        .toList();

    final int modulus = numbers.length + 1;

    final List<int> multiplied = <int>[];

    for (int i = 0; i < numbers.length; i++) {
      multiplied.add(numbers[i] * (modulus - i));
    }

    final int mod =
        multiplied.reduce((int buffer, int number) => buffer + number) % 11;

    return mod < 2 ? 0 : 11 - mod;
  }

  static bool isValid(String? cpf, [bool stripBeforeValidation = true]) {
    if (cpf == null || cpf.isEmpty) {
      return false;
    }

    if (stripBeforeValidation) {
      cpf = strip(cpf);
    }

    if (cpf.length != 11) {
      return false;
    }

    if (blacklist.contains(cpf)) {
      return false;
    }

    String numbers = cpf.substring(0, 9);
    numbers += _verifierDigit(numbers).toString();
    numbers += _verifierDigit(numbers).toString();

    return numbers.substring(numbers.length - 2) ==
        cpf.substring(cpf.length - 2);
  }
}

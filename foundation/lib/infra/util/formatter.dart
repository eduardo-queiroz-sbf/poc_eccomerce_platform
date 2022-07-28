import 'package:intl/intl.dart';

final NumberFormat currencyFormatter = NumberFormat.currency(
  locale: 'pt-BR',
  decimalDigits: 2,
  name: r'R$',
);

String formatStringCurrency(String? currency) {
  if (currency == null) {
    return '';
  }
  final double? doubleCurrency = double.tryParse(
    currency.replaceAll(',', '.'),
  );
  if (doubleCurrency == null) {
    return '';
  }
  return currencyFormatter.format(doubleCurrency);
}

const String stripRegex = r'[^\d]';

String formatCPF(String cpf) {
  final RegExp regExp = RegExp(r'^(\d{3})(\d{3})(\d{3})(\d{2})$');

  return strip(cpf)
      .replaceAllMapped(regExp, (Match m) => '${m[1]}.${m[2]}.${m[3]}-${m[4]}');
}

String strip(String value) {
  final RegExp regExp = RegExp(stripRegex);

  return value.replaceAll(regExp, '');
}

String formatCNPJ(String cnpj) {
  final RegExp regExp = RegExp(r'^(\d{2})(\d{3})(\d{3})(\d{4})(\d{2})$');

  return strip(cnpj).replaceAllMapped(
    regExp,
    (Match m) => '${m[1]}.${m[2]}.${m[3]}/${m[4]}-${m[5]}',
  );
}

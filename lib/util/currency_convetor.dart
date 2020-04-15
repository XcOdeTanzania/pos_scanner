import 'package:flutter/foundation.dart';
import 'package:intl/intl.dart';

class CurrencyCovertor {
  final int decimalDigits;
  final String currency;

  CurrencyCovertor({@required this.decimalDigits, @required this.currency});
  String currencyCovertor({@required double amount}) {
    final formatter = NumberFormat.simpleCurrency(
        decimalDigits: decimalDigits, name: currency);
    return '${formatter.format(amount)} /-';
  }
}

///currency converter
CurrencyCovertor currencyCovertor = CurrencyCovertor(
  decimalDigits: 0,
  currency: 'TZ\t',
);

import 'package:currency_text_input_formatter/currency_text_input_formatter.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';

import '../data/enum/currencies.dart';
import '../data/repository/coin_repository.dart';

class MainViewmodel extends ChangeNotifier {
  late Currencies selectedCurrency = Currencies.brl;
  final CoinRepository coinRepository = CoinRepository(dio: Dio());
  final TextEditingController controller = TextEditingController();
  final CurrencyTextInputFormatter currencyFormatter =
      CurrencyTextInputFormatter.currency(
          locale: 'pt_BR', decimalDigits: 2, symbol: '');

  void updateSelectedCurrency(Currencies newCurrency) {
    selectedCurrency = newCurrency;
    notifyListeners();
  }

  void handleTextChange(String value) {
    currencyFormatter.getFormattedValue();
    controller.text = currencyFormatter.getFormattedValue().toString();
    notifyListeners();
  }
}

import 'package:currency_text_input_formatter/currency_text_input_formatter.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';

import '../data/enum/currencies.dart';
import '../data/model/coin_model.dart';
import '../data/repository/coin_repository.dart';

class MainViewmodel extends ChangeNotifier {
  late Currencies inputCurrency = Currencies.brl;
  late Currencies outputCurrency = Currencies.eur;
  final CoinRepository coinRepository = CoinRepository(dio: Dio());
  final TextEditingController controller = TextEditingController();
  final CurrencyTextInputFormatter currencyFormatter =
      CurrencyTextInputFormatter.currency(
          locale: 'pt_BR', decimalDigits: 2, symbol: '');

  void updateInputCurrency(Currencies newCurrency) {
    inputCurrency = newCurrency;
    notifyListeners();
  }

  void updateOutputCurrency(Currencies newCurrency) {
    outputCurrency = newCurrency;
    notifyListeners();
  }

  void handleTextChange(String value) {
    currencyFormatter.getFormattedValue();
    controller.text = currencyFormatter.getFormattedValue().toString();
    notifyListeners();
  }

  Future<CoinModel> getCoinConversion(String code, String codeIn) async {
    return await coinRepository.getConversion(code, codeIn);
  }
}

import 'dart:developer';

import 'package:currency_converter/data/model/coin_model.dart';
import 'package:dio/dio.dart';

class CoinRepository {
  final Dio dio;
  CoinRepository({required this.dio});

  Future<CoinModel> getConversion(String code, String codeIn) async {
    try {
      final apiResponse =
          await dio.get('https://economia.awesomeapi.com.br/all/$code-$codeIn');
      return CoinModel.fromJson(apiResponse.data);
    } catch (error, stackTrace) {
      log(
        'Ocorreu um erro ao buscar as informações da Conversão das Moedas',
        error: error,
        stackTrace: stackTrace,
      );
      rethrow;
    }
  }
}

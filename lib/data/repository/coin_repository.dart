import 'dart:developer';

import 'package:currency_converter/data/model/coin_model.dart';
import 'package:dio/dio.dart';

class CoinRepository {
  final Dio dio;
  final String code;
  final String codeIn;
  CoinRepository({required this.dio, required this.code, required this.codeIn});

  Future<CoinModel> getConversion(code, codeIn) async {
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

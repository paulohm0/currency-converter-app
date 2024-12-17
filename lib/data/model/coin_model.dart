class CoinModel {
  CoinModel({
    required this.conversions,
  });

  final Map<String, CurrencyConversion> conversions;

  factory CoinModel.fromJson(Map<String, dynamic> json) {
    Map<String, CurrencyConversion> temporaryMap = {};

    json.forEach((key, value) {
      if (value is Map<String, dynamic>) {
        temporaryMap[key] = CurrencyConversion.fromJson(value);
      }
    });

    return CoinModel(
      conversions: temporaryMap,
    );
  }
}

class CurrencyConversion {
  CurrencyConversion({
    required this.code,
    required this.codein,
    required this.name,
    required this.high,
    required this.low,
    required this.varBid,
    required this.pctChange,
    required this.bid,
    required this.ask,
    required this.timestamp,
    required this.createDate,
  });

  final String? code;
  final String? codein;
  final String? name;
  final String? high;
  final String? low;
  final String? varBid;
  final String? pctChange;
  final String? bid;
  final String? ask;
  final String? timestamp;
  final DateTime? createDate;

  factory CurrencyConversion.fromJson(Map<String, dynamic> json) {
    return CurrencyConversion(
      code: json["code"],
      codein: json["codein"],
      name: json["name"],
      high: json["high"],
      low: json["low"],
      varBid: json["varBid"],
      pctChange: json["pctChange"],
      bid: json["bid"],
      ask: json["ask"],
      timestamp: json["timestamp"],
      createDate: DateTime.tryParse(json["create_date"] ?? ""),
    );
  }
}

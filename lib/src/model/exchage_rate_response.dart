
class ExchangeRateResponse {

  
  final String id;
  final String currencyCode;
  final String name;
  final double rate;

  ExchangeRateResponse({
    required this.id,
    required this.currencyCode,
    required this.name,
    required this.rate,
  });

  factory ExchangeRateResponse.fromJson(Map<String, dynamic> json) {
    return ExchangeRateResponse(
      id: json['id'] as String,
      currencyCode: json['currency_code'] as String,
      name: json['name'] as String,
      rate: (json['rate'] as num).toDouble(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'currency_code': currencyCode,
      'name': name,
      'rate': rate,
    };
  }
}
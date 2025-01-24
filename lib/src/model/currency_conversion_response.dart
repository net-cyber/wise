
class CurrencyConversionResponse {
  final double amount;
  final double convertedAmount;
  final String from;
  final double rate;
  final String to;

  CurrencyConversionResponse({
    required this.amount,
    required this.convertedAmount,
    required this.from,
    required this.rate,
    required this.to,
  });

  factory CurrencyConversionResponse.fromJson(Map<String, dynamic> json) {
    return CurrencyConversionResponse(
      amount: double.parse(json['amount']),
      convertedAmount: double.parse(json['converted_amount']),
      from: json['from'],
      rate: double.parse(json['rate']),
      to: json['to'],
    );
  }
}

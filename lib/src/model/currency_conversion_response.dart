
class CurrencyConversionResponse {
  final int amount;
  final double convertedAmount;
  final String from;
  final double rate;

  CurrencyConversionResponse({
    required this.amount,
    required this.convertedAmount,
    required this.from,
    required this.rate,
 
  });

  factory CurrencyConversionResponse.fromJson(Map<String, dynamic> json) {
    return CurrencyConversionResponse(
      amount: json['amount'],
      convertedAmount: json['converted_amount'],
      from: json['from'],
      rate: json['rate'],
    );
  }
}

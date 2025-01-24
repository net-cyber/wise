class TransactionResponse {
  final int amount;
  final String from;
  final String message;
  final String to;
  final String transactionId;

  TransactionResponse({required this.amount, required this.from, required this.message, required this.to, required this.transactionId});

  factory TransactionResponse.fromJson(Map<String, dynamic> json) {
    return TransactionResponse(
      amount: json['amount'],
      from: json['from'],
      message: json['message'],
      to: json['to'],
      transactionId: json['transaction_id'],
    );
  }
}


class TransactionHistoryResponse {
  final List<TransactionList> transactions;

  TransactionHistoryResponse({required this.transactions});

  factory TransactionHistoryResponse.fromJson(Map<String, dynamic> json) {
    return TransactionHistoryResponse(
      transactions: (json['transactions'] as List).map((i) => TransactionList.fromJson(i)).toList(),
    );
  }
}

class TransactionList {
  final double amount;
  final String counterparty;
  final String id;
  final String status;
  final String timestamp;
  final String type;

  TransactionList({
    required this.amount, 
    required this.counterparty, 
    required this.id, 
    required this.status, 
    required this.timestamp, 
    required this.type
  });

  factory TransactionList.fromJson(Map<String, dynamic> json) {
    return TransactionList(
      amount: double.parse(json['amount'].toString()),
      counterparty: json['counterparty'],
      id: json['id'],
      status: json['status'],
      timestamp: json['timestamp'],
      type: json['type'],
    );
  }
}
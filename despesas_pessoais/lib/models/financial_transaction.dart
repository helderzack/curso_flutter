class FinancialTransaction {
  final int? id;
  final String title;
  final double value;
  final DateTime date;

  FinancialTransaction({
    this.id,
    required this.title,
    required this.value,
    required this.date,
  });

  factory FinancialTransaction.fromMap(Map<String, dynamic> json) =>
    new FinancialTransaction(
      id: json['id'],
      title: json['title'],
      value: json['value'],
      date: DateTime.parse(json['date']),
    );

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'value': value,
      'date': date.toIso8601String()
    };
  }
}

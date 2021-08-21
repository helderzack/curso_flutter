class Transaction {
  final int id;
  final String title;
  final double value;
  final DateTime date;

  Transaction({
    required this.id,
    required this.title,
    required this.value,
    required this.date,
  });

  factory Transaction.fromJson(Map<int, dynamic> json) {
    return Transaction(
      id: int.parse(json['id']),
      title: json['title'],
      value: double.parse(json['value']),
      date: DateTime.parse(json['date']),
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'title': title,
        'value': value,
        'date': date.toIso8601String(),
  };
}

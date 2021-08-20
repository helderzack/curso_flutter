import 'dart:convert';

import 'package:http/http.dart' as http;
import '../models/transaction.dart';

class TransactionService {
  List<Transaction> transactions = [];

  Future<List<Transaction>> getTransactions() async {

    var response = await http.get(
        Uri.parse('http://192.168.1.6:9090/api/transactions/'),
        headers: {'Accept': 'application/json'});

    if (response.statusCode == 200) {
      var jsonData = jsonDecode(response.body);

      for (var data in jsonData) {
        Transaction transaction = Transaction(
            id: data['id'],
            title: data['title'],
            value: data['value'],
            date: DateTime.parse(data['date']));
        transactions.add(transaction);
      }

      return transactions;
    } else {
      throw Exception('Failed to fetch transactions');
    }
  }

  List<Transaction> get fetchedTransanctions {
    return transactions;
  }
}

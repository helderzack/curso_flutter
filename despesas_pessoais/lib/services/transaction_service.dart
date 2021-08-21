import 'dart:convert';

import 'package:http/http.dart' as http;
import '../models/transaction.dart';

class TransactionService {
  String baseUrl = 'http://192.168.1.6:9090/api/transactions/';

  Future<List<Transaction>> getTransactions() async {
    List<Transaction> transactions = [];

    var response = await http
        .get(Uri.parse(baseUrl), headers: {'Accept': 'application/json'});

    if (response.statusCode == 200) {
      var jsonData = jsonDecode(response.body);

      print(jsonData);

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

  Future<http.Response> postTransaction(Transaction transaction) async {
    return await http.post(
      Uri.parse(baseUrl),
      headers: {'Content-Type': 'application/json; charset=UTF-8'},
      body: jsonEncode(transaction.toJson()),
    );
  }

  Future<http.Response> deleteTransaction(int id) async {
    String url = baseUrl + '${id.toString()}';
    return await http.delete(Uri.parse(url));
  }
}

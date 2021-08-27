import 'dart:io';

import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import '../models/financial_transaction.dart';

class DatabaseHelper {
  DatabaseHelper._privateConstructor();
  static final DatabaseHelper instance = DatabaseHelper._privateConstructor();
  static Database? _database;

  Future<Database> get database async => _database ??= await _initDB();

  Future<Database> _initDB() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, 'expenses.db');

    return await openDatabase(
      path,
      version: 1,
      onCreate: _onCreate,
    );
  }

  Future _onCreate(Database db, int version) async {
    await db.execute('''
      CREATE TABLE financial_transaction(
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        title TEXT,
        value REAL,
        date TEXT
      )
    ''');
  }

  Future<List<FinancialTransaction>> getFinancialTransaction() async {
    Database db = await instance.database;
    var fetchedData = await db.query('financial_transaction', orderBy: 'id');
    List<FinancialTransaction> financialTransactions = fetchedData.isNotEmpty
        ? fetchedData.map((data) => FinancialTransaction.fromMap(data)).toList()
        : [];
    return financialTransactions;
  }

  Future<int> addFinancialTransaction(
      FinancialTransaction newTransaction) async {
    Database db = await instance.database;
    return await db.insert('financial_transaction', newTransaction.toMap());
  }

  Future<int> removeFinancialTransaction(int id) async {
    Database db = await instance.database;
    return await db.delete('financial_transaction', where: 'id = ?', whereArgs: [id]);
  }
}

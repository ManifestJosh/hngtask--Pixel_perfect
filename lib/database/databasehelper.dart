import 'dart:convert';

import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import '../controller/ordercontroller.dart';

class DatabaseHelper {
  static final DatabaseHelper _instance = DatabaseHelper._internal();
  factory DatabaseHelper() => _instance;
  DatabaseHelper._internal();

  static Database? _database;

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, 'orders.db');

    return await openDatabase(
      path,
      version: 1,
      onCreate: (db, version) async {
        await db.execute('''
          CREATE TABLE orders (
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            date TEXT,
            totalPrice REAL,
            items TEXT
          )
        ''');
      },
    );
  }

  Future<void> insertOrder(Order order) async {
    final db = await database;
    await db.insert('orders', {
      'date': order.date.toIso8601String(),
      'totalPrice': order.totalPrice,
      'items': jsonEncode(order.items), // JSON string
    });
  }

  Future<List<Order>> getOrderHistory() async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query('orders');

    return List.generate(maps.length, (i) {
      return Order(
        items: parseItems(maps[i]['items']),
        totalPrice: maps[i]['totalPrice'],
        date: DateTime.parse(maps[i]['date']),
      );
    });
  }

  List<Map<String, dynamic>> parseItems(String itemsString) {
    try {
      return List<Map<String, dynamic>>.from(jsonDecode(itemsString));
    } catch (e) {
      print('Error parsing items: $e');
      return [];
    }
  }
}

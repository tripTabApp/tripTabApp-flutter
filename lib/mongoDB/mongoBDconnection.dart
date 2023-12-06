/*import 'dart:developer';

import 'package:flutter_application_1/mongoDB/mongoDB.dart';

import 'package:mongo_dart/mongo_dart.dart';

class DatabaseConnection {
  static final DatabaseConnection _instance = DatabaseConnection._internal();
  late Db _db;

  factory DatabaseConnection() {
    return _instance;
  }

  DatabaseConnection._internal();

  Future<void> connect() async {
    final connection = ConnectionString(
        'mongodb+srv://myapp:myapp@cluster0.vr1jci4.mongodb.net/flutter?retryWrites=true&w=majority');
    _db = await Db.create(ConnectionString.MONGO_CONN_URL);
    await _db.open();
  }

  Future<void> close() async {
    await _db.close();
  }

  Future<void> saveCredentials(String username, String password) async {
    final collection = _db.collection('credentials');
    await collection.save({'username': username, 'password': password});
  }
}
*/
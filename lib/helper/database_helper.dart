import 'dart:io';
import 'dart:typed_data';

import 'package:code_cards/model/code_card.dart';
import 'package:flutter/services.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

import 'database_constants.dart' as dbc;

class DatabaseHelper {
  static DatabaseHelper _databaseHelper;
  static Database _database;
  DatabaseHelper._createInstance();

  Future<Database> get database async {
    if (_database == null) {
      _database = await initializeDatabase();
    }
    return _database;
  }

  factory DatabaseHelper() {
    if (_databaseHelper == null) {
      _databaseHelper = DatabaseHelper._createInstance();
    }
    return _databaseHelper;
  }

  Future<Database> initializeDatabase() async {
    var dbDir = await getDatabasesPath();
    var dbPath = join(dbDir, dbc.databaseName);
    bool dbExists = await databaseExists(dbPath);
    if (!dbExists) {
      await _createNewDB(dbPath);
    }
    var db = await openDatabase(dbPath, version: 1);
    return db;
  }

  Future<void> _createNewDB(String dbPath) async {
    if (dbPath == null || dbPath.isEmpty) {
      return;
    }
    await deleteDatabase(dbPath);
    ByteData data = await rootBundle.load("assets/db/code_cards_database.db");
    List<int> bytes =
        data.buffer.asUint8List(data.offsetInBytes, data.lengthInBytes);
    await File(dbPath).writeAsBytes(bytes);
    await createTable();
  }

  Future<List<CodeCard>> getCards() async {
    List<CodeCard> _cards = [];
    var db = await this.database;
    var result = await db.query(dbc.tableName);
    result.forEach((element) {
      var _codeCard = CodeCard.fromJson(element);
      _cards.add(_codeCard);
    });
    return _cards;
  }

  Future<List<CodeCard>> getRandomCards(
      {List<String> filters = const []}) async {
    if (filters == null || filters.isEmpty) {
      return await _getAllRandomCards();
    }
    return await _getFilteredRandomCards(filters);
  }

  Future<List<CodeCard>> _getAllRandomCards() async {
    final db = await database;
    var result = await db.query(
      dbc.tableName,
      orderBy: 'RANDOM()',
      limit: 10,
    );
    List<CodeCard> cards =
        result.map((element) => CodeCard.fromJson(element)).toList();
    return cards;
  }

  Future<List<CodeCard>> _getFilteredRandomCards(List<String> filters) async {
    List<String> lowerCaseFilters =
        filters.map((filter) => filter.toLowerCase()).toList();
    final db = await database;
    var result = await db.query(dbc.tableName,
        orderBy: 'RANDOM()',
        limit: 10,
        where:
            '${dbc.tag} In (${lowerCaseFilters.map((e) => "?").toList().join(',')})',
        whereArgs: lowerCaseFilters);
    List<CodeCard> cards =
        result.map((element) => CodeCard.fromJson(element)).toList();
    return cards;
  }

  Future<void> updateCard(Map<String, dynamic> values, int id) async {
    final db = await database;
    await db
        .update(dbc.tableName, values, where: '${dbc.id} = ?', whereArgs: [id]);
  }

  Future<CodeCard> updateFav(bool isFav, int id) async {
    final db = await database;
    await db.update(dbc.tableName, {dbc.fav: isFav ? 1 : 0},
        where: '${dbc.id} = ?', whereArgs: [id]);
    List cards =
        await db.query(dbc.tableName, where: "${dbc.id} = ?", whereArgs: [id]);
    return CodeCard.fromJson(cards[0]);
  }

  Future<CodeCard> updateKnown(bool isKnown, int id) async {
    final db = await database;
    await db.update(dbc.tableName, {dbc.known: isKnown ? 1 : 0},
        where: '${dbc.id} = ?', whereArgs: [id]);
    List cards =
        await db.query(dbc.tableName, where: "${dbc.id} = ?", whereArgs: [id]);
    return CodeCard.fromJson(cards[0]);
  }

  Future<List<CodeCard>> loadFavorites() async {
    final db = await database;
    var result = await db.query(dbc.tableName, where: '${dbc.fav} = 1');
    List<CodeCard> cards =
        result.map((element) => CodeCard.fromJson(element)).toList();
    return cards;
  }

  Future<CodeCard> updateAppearCount(int count, int id) async {
    final db = await database;
    await db.update(dbc.tableName, {dbc.appearCount: count},
        where: '${dbc.id} = ?', whereArgs: [id]);
    List cards =
        await db.query(dbc.tableName, where: "${dbc.id} = ?", whereArgs: [id]);
    return CodeCard.fromJson(cards[0]);
  }

  // MY CARDS TABLE
  static String myCards = 'my_cards';
  createTable() async {
    final db = await database;
    await db.execute(
        '''CREATE TABLE $myCards(${dbc.id} INTEGER PRIMARY KEY AUTOINCREMENT, 
        ${dbc.question} TEXT, 
        ${dbc.answer} TEXT, 
        ${dbc.type} TEXT,
        ${dbc.tag} TEXT,
        ${dbc.childTag} TEXT,
        ${dbc.answeredCount} INTEGER,
        ${dbc.appearCount} INTEGER,
        ${dbc.fav} INTEGER,
        ${dbc.known} INTEGER,
        )''');
  }
}

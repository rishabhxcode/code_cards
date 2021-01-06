import 'dart:io';
import 'dart:typed_data';

import 'package:code_cards/model/code_card.dart';
import 'package:flutter/services.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseHelper {
  static DatabaseHelper _databaseHelper;
  static Database _database;
  DatabaseHelper._createInstance();

  String tableName = 'code_cards';
  String id = 'id';
  String question = 'question';
  String answer = 'answer';
  String tag = 'tag';
  String childTag = 'child_tag';
  String type = 'type';
  String star = 'star';
  String unAnsweredCount = 'un_answered_count';
  String appearCount = 'appear_count';
  String isKnown = 'is_known';

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


  // void createDb(Database db, int version) async {
  //   await db.execute('''CREATE TABLE $tableName(
  //         $id INTEGER PRIMARY KEY AUTOINCREMENT,
  //         $question TEXT,
  //         $answer TEXT,
  //         $type TEXT,
  //         $tag TEXT,
  //         $childTag TEXT,
  //         $unAnsweredCount INTEGER,
  //         $appearCount INTEGER,
  //         $star INTEGER,
  //         $isKnown INTEGER,
  //         )''');
  // }

  Future<Database> initializeDatabase() async {
    var dbDir = await getDatabasesPath();
    var dbPath = join(dbDir, "code_cards_database.db");
    // await deleteDatabase(dbPath);
    ByteData data = await rootBundle.load("assets/db/code_cards_database.db");
    List<int> bytes =
        data.buffer.asUint8List(data.offsetInBytes, data.lengthInBytes);
    await File(dbPath).writeAsBytes(bytes);
    var db = await openDatabase(dbPath);
    return db;
  }

  Future<List<CodeCard>> getCards() async {
    List<CodeCard> _cards = [];
    var db = await this.database;
    var result = await db.query(tableName);
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
      tableName,
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
    var result = await db.query(tableName,
        orderBy: 'RANDOM()',
        limit: 10,
        where:
            'tag In (${lowerCaseFilters.map((e) => "?").toList().join(',')})',
        whereArgs: lowerCaseFilters);
    List<CodeCard> cards =
        result.map((element) => CodeCard.fromJson(element)).toList();
    return cards;
  }

  Future<void> updateCard(Map<String, dynamic> values, int id) async {
    final db = await database;
    await db.update(tableName, values, where: 'id = ?', whereArgs: [id]);
  }

  Future<bool> updateFav(bool isFav, int id) async {
    final db = await database;
    await db.update(tableName, {'star': isFav ? 1 : 0},
        where: 'id = ?', whereArgs: [id]);
    return isFav;
  }
}

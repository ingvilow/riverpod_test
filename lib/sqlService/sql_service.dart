import 'package:flutter/cupertino.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:path/path.dart';
import 'package:riverpod_test/models/posts_model.dart';
import 'package:sqflite/sqflite.dart';

final sqlServiceProvider = ChangeNotifierProvider((ref) => SQLService());

class SQLService extends ChangeNotifier {
  Future <Database> initializeDB() async {
    String path = await getDatabasesPath();

    return openDatabase(
      join(path, 'database.db'),
      onCreate: (database, version) async {
        await database.execute(
            "CREATE TABLE PostsModel(id INTEGER PRIMARY KEY AUTOINCREMENT, text TEXT NOT NULL, title TEXT NOT NULL)");
      },
      version: 1,
    );
  }

  Future<int> createItem(PostsModel model) async {
    int result = 0;
    Database db = await initializeDB();
    final id = await db.insert('PostsModel', model.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace);
    throw Exception("e");
  }

  Future<List<PostsModel>>? getPosts() async {
    final db = await initializeDB();
    final List<Map<String, Object?>> queryResult =
        await db.query('PostsModel');
    print(queryResult);
    return queryResult.map((e) => PostsModel.fromMap(e)).toList();
  }

 /* void deletePosts() async{

  }*/

}

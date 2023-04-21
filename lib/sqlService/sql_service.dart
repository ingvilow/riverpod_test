import 'package:path/path.dart';
import 'package:riverpod_test/models/posts_model.dart';
import 'package:sqflite/sqflite.dart';

class SQLService {
/*  static final SQLService db = SQLService._();

  SQLService._();*/

  List<Map<String, Object?>> queryResult = [{}];
  Future<Database> initializeDB() async {
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

  Future<List<PostsModel>> allPosts() async {
    final db = await initializeDB();
     queryResult = await db.query('PostsModel');
    return queryResult.map((e) => PostsModel.fromMap(e)).toList();
  }


  Future<void> deletePosts(int id) async {
    final db = await initializeDB();
    await db.delete(
      'PostsModel',
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  Future<PostsModel> insertPosts(PostsModel postsModel) async {
    Database db = await initializeDB();
    await db.insert('PostsModel', postsModel.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace);
    print(postsModel.toMap());
    throw UnimplementedError();
  }

  Future<void> updatePosts(PostsModel postsModel) async {
    final db = await initializeDB();
    await db.update(
      'PostsModel',
      postsModel.toMap(),
      where: 'id = ?',
      whereArgs: [postsModel.id],
    );
  }
}

import 'package:assignment_ravikant/book.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart' as sql;

class DBUtil {
  static Future<void> createTables(sql.Database database) async {
    await database.execute("""CREATE TABLE books (
        id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
        title TEXT,
        edition TEXT,
        author TEXT,
        publisher TEXT,
        publishedOn TEXT
      )
      """);
  }

  static Future<sql.Database> db() async {
    print('createing databse');
    final documentsDirectory = await getApplicationDocumentsDirectory();

    final path = join(documentsDirectory.path, 'books.db');
    print('path is $path');
    return sql.openDatabase(
      path,
      version: 1,
      onCreate: (sql.Database database, int version) async {
        await createTables(database);
      },
    );
  }

  static Future<int> upsert(Book book) async {
    final db = await DBUtil.db();
    if (book.edition!.isNotEmpty) {
      book.edition = "${book.edition!.replaceAll("edition", "").replaceAll("Edition", "").trim()} Edition";
    }
    final id = await db.insert('books', book.toMap(),
        conflictAlgorithm: sql.ConflictAlgorithm.replace);
    return id;
  }

  static Future<List<Map<String, dynamic>>> getBooks() async {
    final db = await DBUtil.db();
    return db.query('books', orderBy: "id desc");
  }

  static Future<int> deleteBook(Book book) async {
    final db = await DBUtil.db();
    return db.delete('books', where: 'id=?', whereArgs: [book.id]);
  }
}

import 'package:flutter_books/database/database_provider.dart';
import 'package:flutter_books/database/models/book_item.dart';

class BookDao {
  final dbProvider = DatabaseProvider.dbProvider;

  Future<int> insertBook(BookItem bookItem) async {
    final db = await dbProvider.database;

    int res = await db.insert(DB_NAME, bookItem.toMap());
    return res;
  }
  Future<List<BookItem>> getBooks() async {
    final db = await dbProvider.database;

    List<Map> list = await db.rawQuery("Select * from $DB_NAME");
    List<BookItem> bookList = new List();
    for (int i = 0; i < list.length; i++){
      var book = BookItem((b) => b..bookName = list[i]["bookname"]
      ..aboutBook = list[i]["aboutbook"]);
      bookList.add(book);
    }
    return bookList;
  }
  Future<int> deleteBook(BookItem bookItem) async {
    final db = await dbProvider.database;

    int res = await db
      .rawDelete("Delete From $DB_NAME where id = ?", [bookItem.id]);
    return res;
  }
  Future<bool> update(BookItem bookItem) async {
    final db = await dbProvider.database;

    int res = await db.update(DB_NAME, bookItem.toMap(),
      where: "id = ? ", whereArgs: <int>[bookItem.id]);
    return res > 0 ? true : false;
  }
}
import 'package:flutter_books/dao/book_item.dart';
import 'package:flutter_books/database/models/book_item.dart';

class BookRepository {
  final bookDao = BookDao();

  Future getAllBooks() => bookDao.getBooks();

  Future insertBook(BookItem bookItem) => bookDao.insertBook(bookItem);

  Future updateBook(BookItem bookItem) => bookDao.update(bookItem);

  Future deleteBook(BookItem bookItem) => bookDao.deleteBook(bookItem);
}
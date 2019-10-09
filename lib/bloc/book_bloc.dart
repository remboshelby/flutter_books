import 'dart:async';

import 'package:flutter_books/database/models/book_item.dart';
import 'package:flutter_books/repository/book_repository.dart';

class BookBloc {
  final _bookRepository = BookRepository();

  final _bookController = StreamController<List<BookItem>>.broadcast();

  get books => _bookController.stream;

  BookBloc(){
    getBooks();
  }

  void getBooks() async{
    _bookController.sink.add(await _bookRepository.getAllBooks());
  }

  addBook(BookItem bookItem) async {
    await _bookRepository.insertBook(bookItem);
    getBooks();
  }
  updateBook(BookItem bookItem) async {
    await _bookRepository.updateBook(bookItem);
    getBooks();
  }
  deleteBook(BookItem bookItem) async {
    await _bookRepository.deleteBook(bookItem);
    getBooks();
  }
  dispose(){
    _bookController.close();
  }
}
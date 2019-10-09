import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_books/bloc/book_bloc.dart';
import 'package:flutter_books/database/models/book_item.dart';
import 'package:flutter_books/ui/add_book_view.dart';
import 'package:flutter_books/ui/book_list.dart';

import 'add_book_view.dart';

class BookListScreen extends StatefulWidget {
  static const routeName = "/list";

  final BookBloc bookBloc;

  BookListScreen(this.bookBloc);

  @override
  _BookListScreenState createState() => _BookListScreenState();
}

class _BookListScreenState extends State<BookListScreen> {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          centerTitle: true,
          title: _buildTitle(context),
          actions: _buildActions(),
        ),
        body: StreamBuilder(
          stream: widget.bookBloc.books,
          builder: (context, AsyncSnapshot<List<BookItem>> snapshot) {
            if (snapshot.hasData) {
              return snapshot.data.length != 0
                  ? new BookList(snapshot.data, widget.bookBloc)
                  : noBookMessageWidget();
            } else {
              return loadingData();
            }
          },
        ),
      ),
    );
  }

  Widget _buildTitle(BuildContext context) {
    return new InkWell(
      child: new Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12.0),
        child: new Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            new Text(
              "Мои книги",
              style: new TextStyle(
                  fontWeight: FontWeight.bold, color: Colors.black),
            )
          ],
        ),
      ),
    );
  }

  List<Widget> _buildActions() {
    return <Widget>[
      new FlatButton(
          textColor: Colors.lightGreenAccent,
          child: Text(
            "Добавить",
            style: TextStyle(fontSize: 18),
          ),
          shape: CircleBorder(side: BorderSide(color: Colors.transparent)),
          onPressed: _openAddBookDiaglog),
    ];
  }

  Future _openAddBookDiaglog() async {
    Navigator.pushNamed(context, AddBookView.routeName,
        arguments: BookArguments(false, null));
  }

  Widget noBookMessageWidget() {
    return Container(
        child: Center(
            child: Text("Книг Нэт :(",
            style: TextStyle(fontSize: 19, fontWeight: FontWeight.w500),
            )
        )
    );
  }

  Widget loadingData() {
    widget.bookBloc.books;
    return Center(
      child: Container(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              CircularProgressIndicator(),
              Text("Загрузка...",
                style: TextStyle(fontSize: 19, fontWeight: FontWeight.w500),)
            ],
          ),
        ),
      ),
    );
  }
}

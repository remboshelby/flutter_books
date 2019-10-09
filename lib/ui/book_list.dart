import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_books/bloc/book_bloc.dart';
import 'package:flutter_books/database/models/book_item.dart';
import 'package:flutter_books/ui/add_book_view.dart';

class BookList extends StatefulWidget {
  List<BookItem> bookList;
  BookBloc bookBloc;

  BookList(
    this.bookList,
    this.bookBloc,
  );

  @override
  _BookListState createState() => _BookListState();
}

class _BookListState extends State<BookList> {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return new ListView.builder(
        itemCount: widget.bookList == null ? 0 : widget.bookList.length,
        itemBuilder: (BuildContext context, int index) {
          return new Card(
            elevation: 0,
            child: new Container(
              child: Row(
                children: <Widget>[
                  new Expanded(
                    child: new Padding(
                      padding: EdgeInsets.all(10.0),
                      child: new Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          new Text(
                            widget.bookList[index].bookName,
                            style: new TextStyle(
                                fontSize: 22.0,
                                color: Colors.black,
                                fontWeight: FontWeight.bold),
                          ),
                          new Text(widget.bookList[index].bookName,
                              style: new TextStyle(
                                  fontSize: 22.0,
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold))
                        ],
                      ),
                    ),
                  ),
                  new Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      new IconButton(
                          icon: const Icon(
                            Icons.edit,
                            color: Colors.blueAccent,
                          ),
                          onPressed: () => editBook(widget.bookBloc,
                              widget.bookList[index], context)),
                      new IconButton(
                          icon: const Icon(
                            Icons.delete_forever,
                            color: Colors.blueAccent,
                          ),
                          onPressed: () => widget.bookBloc
                              .deleteBook(widget.bookList[index])),
                    ],
                  )
                ],
              ),
            ),
          );
        });
  }

  editBook(BookBloc bookBloc, BookItem bookItem, BuildContext context) {
    Navigator.push(
        context,
        new MaterialPageRoute(
            builder: (context) => new AddBookView(
                isEdit: true, bookItem: bookItem, bookBloc: bookBloc)));
  }
}

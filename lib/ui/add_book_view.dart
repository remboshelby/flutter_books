import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_books/bloc/book_bloc.dart';
import 'package:flutter_books/database/models/book_item.dart';

class AddBookView extends StatefulWidget {
  static const routeName = "/addBook";

  final bool isEdit;
  final BookItem bookItem;
  final BookBloc bookBloc;

  const AddBookView({Key key,
    @required this.isEdit,
    @required this.bookItem,
    @required this.bookBloc})
      : super(key: key);

  @override
  _AddBookView createState() => _AddBookView();
}


class _AddBookView extends State<AddBookView> {
  BookBloc bookBloc;

  final teBookName = TextEditingController();
  final teAboutBook = TextEditingController();

  bool isEdit;
  BookItem bookItem;

  @override
  void initState() {
    bookBloc = widget.bookBloc;
    isEdit = widget.isEdit;
    if (widget.bookItem != null) {
      bookItem = widget.bookItem;
      teBookName.text = widget.bookItem.bookName;
      teAboutBook.text = widget.bookItem.aboutBook;
    }
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.white,
        title: Text(
          isEdit ? "Редактировать книгку" : "Добавить книгу",
          style: TextStyle(color: Colors.black),
        ),
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: Colors.black,
          ),
          onPressed: () => Navigator.pop(context, false),
        ),
      ),
      body: new Container(
        child: new Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            getTextField("Название книги", teBookName),
            getTextField("О книге", teAboutBook),
            new GestureDetector(
              onTap: (){
                addBook(isEdit);
                Navigator.of(context).pop();
              },
              child: new Container(
                margin: EdgeInsets.all(10.0),
                child: getAppBorderButton(isEdit ? "Изменить книгу" : "Добавить"),
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget getTextField(String inputBoxName,
      TextEditingController inputBoxController) {
    var textField = new Padding(padding: const EdgeInsets.all(10.0),
      child: new TextFormField(
        controller: inputBoxController,
        decoration: new InputDecoration(
          enabledBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: Colors.grey, width: 1),
            borderRadius: new BorderRadius.all(const Radius.circular(6.0)),
          ),
          hintText: inputBoxName,
          prefixText: ' ',
        ),
      ),);
    return textField;
  }
  Future addBook(bool isEdit) async {
    if (isEdit){
      var book = BookItem((b)=> b..bookName = teBookName.text
        ..aboutBook = teAboutBook.text
        ..id = bookItem.id);
      await bookBloc.updateBook(book);
    }else{
      var book = BookItem((b)=> b..bookName = teBookName.text
        ..aboutBook = teAboutBook.text);
      await bookBloc.addBook(book);
    }
  }

  getAppBorderButton(String buttonLabel) {
    var btn = new Container(
      padding: EdgeInsets.all(14.0),
      alignment: FractionalOffset.center,
      decoration: new BoxDecoration(
        color: Colors.lightBlue,
        borderRadius: new BorderRadius.all(const Radius.circular(6.0)),
      ),
      child: new Text(
        buttonLabel,
        style: new TextStyle(
          color: Colors.white,
          fontSize: 20.0,
          fontWeight: FontWeight.w300,
          letterSpacing: 0.3,
        ),
      ),
    );
    return btn;
  }
}
class BookArguments{
  final bool isEdit;
  final BookItem bookItem;

  BookArguments(this.isEdit, this.bookItem);

}
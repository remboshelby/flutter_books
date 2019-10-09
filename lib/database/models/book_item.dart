import 'package:built_value/built_value.dart';

part 'book_item.g.dart';

abstract class BookItem implements Built<BookItem, BookItemBuilder>{
  @nullable
  int get id;
  @nullable
  String get bookName;
  @nullable
  String get aboutBook;

  BookItem._();

  Map<String, dynamic> toMap(){
    var map = new Map<String, dynamic>();
    map["bookname"] = bookName;
    map["aboutbook"] = aboutBook;
    return map;
  }

  factory BookItem([updates(BookItemBuilder b)]) = _$BookItem;
}
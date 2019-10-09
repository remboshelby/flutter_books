import 'package:flutter/material.dart';
import 'package:flutter_books/bloc/book_bloc.dart';
import 'package:flutter_books/ui/add_book_view.dart';
import 'package:flutter_books/ui/book_list_screen.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  var bookBloc = new BookBloc();

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark(),
      routes: {
        '/': (BuildContext context) => new BookListScreen(bookBloc),
      },
      onGenerateRoute: _getRoute,
    );
  }

  Route <dynamic> _getRoute(RouteSettings settings) {
    if (settings.name == AddBookView.routeName) {
      final BookArguments arguments = settings.arguments;

      return _buildRoute(
          settings,
          new AddBookView(isEdit: arguments.isEdit,
              bookItem: arguments.bookItem,
              bookBloc: bookBloc)
      );
    }
    return null;
  }
  MaterialPageRoute _buildRoute(RouteSettings settings, Widget builder){
    return new MaterialPageRoute(builder: (ctx) => builder, settings: settings);
  }
}

import 'package:flutter/material.dart';

class FavoritesPage extends StatefulWidget {
  FavoritesPage({Key key}) : super(key: key);

  _FavoritesPageState createState() => _FavoritesPageState();
}

class _FavoritesPageState extends State<FavoritesPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("Página de favoritos"),
      ),
      body: Container(
        child: Center(
          child: Text("página de favoritos"),
        ),
      ),
    );
  }
}
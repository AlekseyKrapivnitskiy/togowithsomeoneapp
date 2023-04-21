import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

// Здесь все довольно очевидно
class AlbumListPage extends StatefulWidget {
  @override
  _AlbumListPageState createState() => _AlbumListPageState();
}

class _AlbumListPageState extends State<AlbumListPage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Album List Page"),
        ),
        body: Container()
    );
  }
}
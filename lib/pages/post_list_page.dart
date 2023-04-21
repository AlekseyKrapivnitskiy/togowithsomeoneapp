import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

// Здесь все довольно очевидно
class PostListPage extends StatefulWidget {
  @override
  _PostListPageState createState() => _PostListPageState();
}

class _PostListPageState extends State<PostListPage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Post List Page"),
        ),
        body: Container()
    );
  }
}
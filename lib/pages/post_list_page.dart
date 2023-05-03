import 'package:flutter/material.dart';
import 'package:mvc_pattern/mvc_pattern.dart';

import '../controllers/post_controller.dart';
import '../models/post.dart';
import 'post_add_page.dart';

class PostListPage extends StatefulWidget {
  @override
  _PostListPageState createState() => _PostListPageState();
}

// не забываем расширяться от StateMVC
class _PostListPageState extends StateMVC {

  // ссылка на наш контроллер
  PostController? _controller;

  // передаем наш контроллер StateMVC конструктору и
  // получаем на него ссылку
  _PostListPageState() : super(PostController()) {
    _controller = controller as PostController;
  }

  // после инициализации состояния
  // мы запрашивает данные у сервера
  @override
  void initState() {
    super.initState();
    _controller!.init();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Post List Page"),
      ),
      body: _buildContent(),
      // в первой части мы уже рассматривали FloatingActionButton
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          // then возвращает объект Future
          // на который мы подписываемся и ждем результата
          Navigator.push(context, MaterialPageRoute(
              builder: (context) => PostDetailPage()
          )).then((value) {
            if (value is PostAddSuccess) {
              // SnackBar - всплывающее сообщение
              ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text("Пост был успешно добавлен"))
              );
            }
          });
        },
      ),
    );
  }

  Widget _buildContent() {
    // первым делом получаем текущее состояние
    final state = _controller!.currentState;
    if (state is PostResultLoading) {
      // загрузка
      return Center(
        child: CircularProgressIndicator(),
      );
    } else if (state is PostResultFailure) {
      // ошибка
      return Center(
        child: Text(
            state.error,
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.headlineMedium!.copyWith(color: Colors.red)
        ),
      );
    } else {
      // отображаем список постов
      final posts = (state as PostResultSuccess).postList.posts;
      return Padding(
        padding: EdgeInsets.all(10),
        // ListView.builder создает элемент списка
        // только когда он видим на экране
        child: ListView.builder(
          itemCount: posts.length,
          itemBuilder: (context, index) {
            return _buildPostItem(posts[index]);
          },
        ),
      );
    }
  }

  // элемент списка
  Widget _buildPostItem(Post post) {
    return Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(15)),
            border: Border.all(color: Colors.grey.withOpacity(0.5), width: 0.3)
        ),
        margin: EdgeInsets.only(bottom: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(topLeft: Radius.circular(15), topRight: Radius.circular(15)),
                color: Theme.of(context).primaryColor,
              ),
              padding: EdgeInsets.all(10),
              child: Text(
                post.title,
                textAlign: TextAlign.left,
                style: Theme.of(context).textTheme.headlineSmall!.copyWith(color: Colors.white),),
            ),
            Container(
              child: Text(
                post.body,
                style: Theme.of(context).textTheme.bodyMedium,
              ),
              padding: EdgeInsets.all(10),
            ),
          ],
        )
    );
  }
}
import 'package:flutter/material.dart';
import 'package:mvc_pattern/mvc_pattern.dart';

import '../controllers/post_controller.dart';
import '../models/post.dart';

class PostDetailPage extends StatefulWidget {
  @override
  _PostDetailPageState createState() => _PostDetailPageState();
}

// не забываем поменять на StateMVC
class _PostDetailPageState extends StateMVC {

  // _controller может быть null
  PostController? _controller;

  // получаем PostController
  _PostDetailPageState() : super(PostController()) {
    _controller = controller as PostController;
  }

  // TextEditingController'ы позволят нам получить текст из полей формы
  final TextEditingController titleController = TextEditingController();
  final TextEditingController contentController = TextEditingController();

  // _formKey нужен для валидации формы
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Post Add Page"),
        actions: [
          // пункт меню в AppBar
          IconButton(
            icon: Icon(Icons.check),
            onPressed: () {
              // сначала запускаем валидацию формы
              if (_formKey.currentState!.validate()) {
                // создаем пост
                // получаем текст через TextEditingController'ы
                final post = Post(
                    -1, -1, titleController.text, contentController.text
                );
                // добавляем пост
                _controller!.addPost(post, (status) {
                  if (status is PostAddSuccess) {
                    // если все успешно то возвращаемя
                    // на предыдущую страницу и возвращаем
                    // результат
                    Navigator.pop(context, status);
                  } else {
                    // в противном случае сообщаем об ошибке
                    // SnackBar - всплывающее сообщение
                    ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text("Произошла ошибка при добавлении поста"))
                    );
                  }
                });
              }
            },
          )
        ],
      ),
      body: Padding(
        padding: EdgeInsets.all(15),
        child: _buildContent(),
      ),
    );
  }

  Widget _buildContent() {
    // построение формы
    return Form(
      key: _formKey,
      // у нас будет два поля
      child: Column(
        children: [
          // поля для ввода заголовка
          TextFormField(
            // указываем для поля границу,
            // иконку и подсказку (hint)
            decoration: InputDecoration(
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.face),
                hintText: "Заголовок"
            ),
            // указываем TextEditingController
            controller: titleController,
            // параметр validator - функция которая,
            // должна возвращать null при успешной проверки
            // и строку при неудачной
            validator: (value) {
              // здесь мы для наглядности добавили 2 проверки
              if (value == null || value.isEmpty) {
                return "Заголовок пустой";
              }
              if (value.length < 3) {
                return "Заголовок должен быть не короче 3 символов";
              }
              return null;
            },
          ),
          // небольшой отступ между полями
          SizedBox(height: 10),
          // Expanded означает, что мы должны
          // расширить наше поле на все доступное пространство
          Expanded(
            child: TextFormField(
              // maxLines: null и expands: true
              // указаны для расширения поля
              maxLines: null,
              expands: true,
              textAlignVertical: TextAlignVertical.top,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                hintText: "Содержание",
              ),
              // указываем TextEditingController
              controller: contentController,
              // также добавляем проверку поля
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return "Содержание пустое";
                }
                return null;
              },
            ),
          )
        ],
      ),
    );
  }
}
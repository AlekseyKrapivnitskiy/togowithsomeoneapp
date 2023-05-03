// AlbumController очень поход на PostController
import 'package:mvc_pattern/mvc_pattern.dart';

import '../data/repository.dart';
import '../models/photo.dart';

class AlbumController extends ControllerMVC {
  final Repository repo = Repository();

  // текущее состояние
  PhotoResult currentState = PhotoResultLoading();

  void init() async {
    try {
      // получение картинок
      final photoList = await repo.fetchPhotos();
      // успешно
      setState(() => currentState = PhotoResultSuccess(photoList));
    } catch (error) {
      // произошла ошибка
      setState(() => currentState = PhotoResultFailure("Нет интернета"));
    }
  }
}
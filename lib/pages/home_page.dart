import 'package:flutter/material.dart';
import 'package:mvc_pattern/mvc_pattern.dart';

import '../../controllers/home_controller.dart';

import '../models/bottom_navigation.dart';
import '../models/tab_navigator.dart';
import '../models/tab.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

// наше состояние теперь расширяет специальный класс
// StateMVC из пакета mvc_pattern
class _HomePageState extends StateMVC {

  // ссылка на наш контроллер
  late HomeController _con;

  // super вызывает конструктор StateMVC и
  // передает ему наш контроллер
  _HomePageState() : super(HomeController()) {
    // получаем ссылку на наш контроллер
    _con = HomeController.controller!;
  }


  // здесь почти ничего не изменилось
  // только currentTab и selectTab теперь
  // являются частью нашего контроллера
  @override
  Widget build(BuildContext context) {
    // WillPopScope переопределяет поведения
    // нажатия кнопки Back
    return WillPopScope(
      // логика обработки кнопки back может быть разной
      // здесь реализована следующая логика:
      // когда мы находимся на первом пункте меню (посты)
      // и нажимаем кнопку Back, то сразу выходим из приложения
      // в противном случае выбранный элемент меню переключается
      // на предыдущий: c заданий на альбомы, с альбомов на посты,
      // и после этого только выходим из приложения
      onWillPop: () async {
        if (_con.currentTab != TabItem.POSTS) {
          if (_con.currentTab == TabItem.TODOS) {
            _con.selectTab(TabItem.ALBUMS);
          } else {
            _con.selectTab(TabItem.POSTS);
          }
          return false;
        } else {
          return true;
        }

      },
      child: Scaffold(
        // Stack размещает один элемент над другим
        // Проще говоря, каждый экран будет находится
        // поверх другого, мы будем только переключаться между ними
        body: Stack(children: <Widget>[
          _buildOffstageNavigator(TabItem.POSTS),
          _buildOffstageNavigator(TabItem.ALBUMS),
          _buildOffstageNavigator(TabItem.TODOS),
        ]),
        // MyBottomNavigation мы создадим позже
        bottomNavigationBar: MyBottomNavigation(
          currentTab: _con.currentTab,
          onSelectTab: _con.selectTab,
        ),
      ),);
  }

  // Создание одного из экранов - посты, альбомы или задания
  Widget _buildOffstageNavigator(TabItem tabItem) {
    return Offstage(
      // Offstage работает следующим образом:
      // если это не текущий выбранный элемент
      // в нижнем меню, то мы его скрываем
      offstage: _con.currentTab != tabItem,
      // TabNavigator мы создадим позже
      child: TabNavigator(
        navigatorKey: _con.navigatorKeys[tabItem],
        tabItem: tabItem,
      ),
    );
  }

}
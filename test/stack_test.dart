import 'package:flutter_test/flutter_test.dart';
import 'package:togowithsomeoneapp/helpers/stack.dart';

void main() {
  // группа тестов
  group("Stack", () {
    // первый тест на пустой стек
    test("Stack should be empty", () {
      // expect принимает текущее значение
      // и сравнивает его с правильным
      // если значения не совпадают, тест не пройден
      expect(Stack().isEmpty, true);
    });
    test("Stack shouldn't be empty", () {
      final stack = Stack<int>();
      stack.push(5);
      expect(stack.isEmpty, false);
    });
    test("Stack should be popped", () {
      final stack = Stack<int>();
      stack.push(5);
      expect(stack.pop(), 5);
    });
    test("Stack should be work correctly", () {
      final stack = Stack<int>();
      stack.push(1);
      stack.push(2);
      stack.push(5);
      expect(stack.pop(), 5);
      expect(stack.pop(), 2);
      expect(stack.isEmpty, false);
    });
  });
}
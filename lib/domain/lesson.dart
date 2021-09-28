import 'package:meta/meta.dart';

abstract class LessonRepository {
  Future<Lesson>? getLesson({@required int? number});
}

class Lesson {
  final String? title;
  final String? description;

  Lesson({@required this.title, @required this.description});
}

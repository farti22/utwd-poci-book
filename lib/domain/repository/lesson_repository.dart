import 'package:meta/meta.dart';
import 'package:flutter_poci_book/domain/model/lesson.dart';

abstract class LessonRepository {
  Future<Lesson>? getLesson({@required int? number});
}

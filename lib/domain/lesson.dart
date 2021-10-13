// import 'package:meta/meta.dart';

// abstract class LessonRepository {
//   Future<Lesson>? getLesson({@required int? number});
// }

// class Lesson {
//   final String? title;
//   final String? description;

//   Lesson({@required this.title, @required this.description});
// }

import 'package:cloud_firestore/cloud_firestore.dart';

class DBService{

  final CollectionReference test = FirebaseFirestore.instance.collection('test');

  Stream<QuerySnapshot> get tests{
    return test.snapshots();
  }
}

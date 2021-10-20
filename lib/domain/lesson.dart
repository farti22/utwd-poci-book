import 'package:cloud_firestore/cloud_firestore.dart';

class Lesson{

  late int id;
  late String name;
  //late String description;
  late String content;

  Lesson({
    required this.id,
    required this.name,
    //required this.description,
    required this.content
  });
}

class DatabaseService {

  
  final lectureCollection = FirebaseFirestore.instance.collection("lectures");

  Future<List<Lesson>> getData() async {
    
    List<Lesson> listData = [];
    await lectureCollection.get().then((querySnapshot){
      for (var doc in querySnapshot.docs) {
      
        Lesson lesson = Lesson( // the first issue
          id: doc.data()['id'],
          name: doc.data()['Name'],
          //description: doc['Description'],
          content: doc.data()['Content'],// ?? "Pusto",
        );
        listData.add(lesson); // the second issue
      }
    });
    return listData;
  }

}
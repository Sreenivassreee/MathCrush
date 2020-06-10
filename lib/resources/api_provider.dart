import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/category.dart';
import '../models/question.dart';

// var db = new Mysql();
String _level;
Future<List<Question>> getQuestions(Category category) async {
  List<Question> list = List();
  List<Question> list2 = List();
  _level = category.level;
  try {
    final levelReference = Firestore.instance.collection("AllLevels");
    QuerySnapshot documentSnapshot = await levelReference
        .document("M5xgqSw5RA2VaBkQEP5N")
        .collection("Level-" + _level)
        .getDocuments();
    documentSnapshot.documents.forEach((e) {
      Question levelP = Question.fromMap(e.data);
      list.add(levelP);
    });
  } catch (e) {}
  for (var i = 1; i <= 15; i++) {
    list2.add(list[i]);
  }
  list2.shuffle();
  print(list.length);
  print(list2.length);
  return list2;
}

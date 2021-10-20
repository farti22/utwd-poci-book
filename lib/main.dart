import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_poci_book/application.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_poci_book/domain/lesson.dart';

List<Lesson> listData = [];


void main() async {
  
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
  await DatabaseService().getData().then((value) => listData = value);
  runApp(const Application());
}

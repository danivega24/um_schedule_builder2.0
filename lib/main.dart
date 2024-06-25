import 'package:flutter/material.dart';
import 'package:schedule_builder_um/pages/home_page.dart';
import 'package:schedule_builder_um/database/class_database_helper.dart';


final ClassDatabaseHelper _class_database = ClassDatabaseHelper.instance;
ClassDatabaseHelper get classDatabase {return _class_database; }

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {

  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomePage(),
    );
  }
}

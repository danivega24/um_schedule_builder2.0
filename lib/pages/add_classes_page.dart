import 'package:flutter/material.dart';
import 'package:schedule_builder_um/database/class.dart';
import 'package:schedule_builder_um/main.dart';
import 'package:schedule_builder_um/pages/home_page.dart';

class AddClassesPage extends StatefulWidget {
  const AddClassesPage({super.key});

  @override
  State<AddClassesPage> createState() => _AddClassesPageState();
}

class _AddClassesPageState extends State<AddClassesPage> {

  String department = "";
  int courseNumber = 0;
  int credits = 0;
  bool isHU = false;
  bool isULCS = false;
  bool isIB = false;
  bool isFlexTech = false;


  Widget _addClassButton(){
    return FloatingActionButton(onPressed: (){
      showDialog(
        context: context,
        builder: (_) => AlertDialog(
          title: const Text('Add Class'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
          children: [ 
            TextField(
              onChanged: (value){
              setState(() {
                  department = value;
                });
              }, 
              decoration: const InputDecoration( 
                border: OutlineInputBorder(),
                hintText:'department',
              ), 
            ) ,
            TextField(
              onChanged: (value){
              setState(() {
                  courseNumber = int.parse(value);
                });
              }, 
              decoration: const InputDecoration( 
                border: OutlineInputBorder(),
                hintText:'course number',
              ), 
            ) ,
            TextField(
              onChanged: (value){
              setState(() {
                  credits = int.parse(value);
                });
              }, 
              decoration: const InputDecoration( 
                border: OutlineInputBorder(),
                hintText:'credits',
              ), 
            ) ,

            TextField(
              onChanged: (value){
              setState(() {
                  isHU = bool.parse(value);
                });
              }, 
              decoration: const InputDecoration( 
                border: OutlineInputBorder(),
                hintText:'is humanities {true, false}',
              ), 
            ) ,

            TextField(
              onChanged: (value){
              setState(() {
                  isIB = bool.parse(value);
                });
              }, 
              decoration: const InputDecoration( 
                border: OutlineInputBorder(),
                hintText:'is IB {true, false}',
              ), 
            ) ,

            TextField(
              onChanged: (value){
              setState(() {
                  isULCS = bool.parse(value);
                });
              }, 
              decoration: const InputDecoration( 
                border: OutlineInputBorder(),
                hintText:'is ULCS {true, false}',
              ), 
            ) ,
            
            TextField(
              onChanged: (value){
              setState(() {
                  isFlexTech = bool.parse(value);
                });
              }, 
              decoration: const InputDecoration( 
                border: OutlineInputBorder(),
                hintText:'is flex tech {true, false}',
              ), 
            ) ,
            
            MaterialButton(
              child: Text("Add Class"),
              onPressed: ()
              {
                if (department == "" || courseNumber == 0 || credits == 0) return;
                  classDatabase.addClass(Class(department: department, courseNumber: courseNumber, credits: credits, prereqs: "", isHU: isHU ? 1 : 0, isFlexTech: isFlexTech ? 1 : 0, isIB: isIB ? 1 : 0, isULCS: isULCS ? 1 : 0)!);
                setState(() {
                  department = "";
                  courseNumber = 0;
                  credits = 0;
                  isHU = false;
                  isIB = false;
                  isFlexTech = false;
                  isULCS = false;
                });
                Navigator.pop(context);
              },
            ),
            ],
          ),
        ),
      );
    }, 
    child: const Icon(Icons.add),);
  }

  Widget _classList()
  {
    return FutureBuilder(future: classDatabase.getAllClasses(), builder: (context, snapshot) {
        return ListView.builder(
          itemCount: snapshot.data?.length ?? 0,
          itemBuilder: (context, index){
            Class classItem = snapshot.data![index];
            return ListTile(
              title: Text(classItem.department + classItem.courseNumber.toString()),
            );
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:  _classList(),
      floatingActionButton: _addClassButton(), 
    );
  }
}
import 'package:flutter/material.dart';
import 'package:schedule_builder_um/main.dart';
import 'package:schedule_builder_um/database/class.dart';

class FilteredPage extends StatefulWidget {
  const FilteredPage({super.key});

  @override
  State<FilteredPage> createState() => _FilteredPageState();
}

class _FilteredPageState extends State<FilteredPage> {

  String department = "";
  int courseNumber = 0;
  int credits = 0;
  bool isHU = false;
  bool isULCS = false;
  bool isIB = false;
  bool isFlexTech = false;
  int id = -1;

  String courseNumberin = "";
  String isHUstr = "";
  String isULCSstr = "";
  String isIBstr = "";
  String isFlexTechstr = "";
  String idin = "";


Widget filteredclassList()
  {
    return FutureBuilder(future: classDatabase.getAllClassesThatMeetReqs(minimumCourseNumber:courseNumber, minimumCredits: credits, isHU: isHU, isFlexTech: isFlexTech, isIB: isIB, isULCS: isULCS, idNumber:id), builder: (context, snapshot) {
        return ListView.builder(
          itemCount: snapshot.data?.length ?? 0,
          itemBuilder: (context, index){
            Class classItem = snapshot.data![index];
            return ListTile(
              title: Text(classItem.toString()),
            );
          },
        );
      },
    );
  }

  Widget _addClassButton(){
    return FloatingActionButton(onPressed: (){
      showDialog(
        context: context,
        builder: (_) => AlertDialog(
          title: const Text('Filter'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
          children: [ 
            TextField(
              onChanged: (value){
              setState(() {
                  courseNumberin = value;
                });
              }, 
              decoration: const InputDecoration( 
                border: OutlineInputBorder(),
                hintText:'minimum course number',
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
                  isHUstr = value;
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
                  isIBstr = value;
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
                  isULCSstr = value;
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
                  isFlexTechstr = value;
                });
              }, 
              decoration: const InputDecoration( 
                border: OutlineInputBorder(),
                hintText:'is flex tech {true, false}',
              ), 
            ) ,

            TextField(
              onChanged: (value){
              setState(() {
                  idin = value;
                });
              }, 
              decoration: const InputDecoration( 
                border: OutlineInputBorder(),
                hintText:'class id',
              ), 
            ) ,
            
            MaterialButton(
              child: const Text("Add Filter"),
              onPressed: ()
              {
                setState(() {
                  courseNumber = courseNumberin == "" ? 0 : int.parse(courseNumberin);
                  isHU = isHUstr == "" ? false : bool.parse(isHUstr);
                  isULCS = isULCSstr == "" ? false :bool.parse(isULCSstr);
                  isIB = isIBstr == "" ? false :bool.parse(isIBstr);
                  isFlexTech = isFlexTechstr == "" ? false :bool.parse(isFlexTechstr);
                  id = (idin == "") ? -1 : int.parse(idin);

                  courseNumberin = "";
                  isHUstr = "";
                  isULCSstr = "";
                  isIBstr = "";
                  isFlexTechstr = "";
                  idin = "";
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: filteredclassList(),
      floatingActionButton: _addClassButton(),
    );
  }
}
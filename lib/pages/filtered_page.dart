import 'package:flutter/material.dart';
import 'package:schedule_builder_um/main.dart';
import 'package:schedule_builder_um/database/class.dart';

class FilteredPage extends StatelessWidget {
  const FilteredPage({super.key});

Widget filteredclassList()
  {
    return FutureBuilder(future: classDatabase.getAllClassesThatMeetReqs(isIB: true), builder: (context, snapshot) {
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
      body: filteredclassList(),
    );
  }
}
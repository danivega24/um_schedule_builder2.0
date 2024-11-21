//testing and debugging algorithm.dart
import '../lib/algorithm/algorithm.dart';
import '../lib/database/major.dart';
import '../lib/database/class.dart';
import '../lib/database/class_database_helper.dart';

final ClassDatabaseHelper _class_database = ClassDatabaseHelper.instance;
ClassDatabaseHelper get classDatabase {return _class_database; }

void main() async {
  AlgorithmTesting tester = AlgorithmTesting(16, 16, 16, classDatabase);
  List<Class> _sequence = await tester.class_sequence();
  for(int i = 0; i < _sequence.length; i++)
  {
    String id = _sequence[i].id.toString();
    String dept = _sequence[i].department;
    String number = _sequence[i].courseNumber.toString();

    print('id: $id, dept: $dept, number: $number\n'); 
  }
  
  print('Hello World!');
}
//for the github
//more for the github
//another one for the culture
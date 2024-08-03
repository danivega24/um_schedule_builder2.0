/*1.) Finding prerequisite chain


//2.) Finding remaining credits needed
modifies class variables for remaining needed requirements, ex 12 flex techs remaining, 16 IB remaining etc


//3.) Building schedule with remaining credits needed
returns list of classes that need to be taken, in any order. add in 4 credit chunks requirement credits as a class as a placeholder. (ex. make a class that is just a generic flex tech with 4 credits that is used whenever a flex tech is needed)


//4.) Assemble the classes in a usable order
take the list of classes, and make them into a schedule.
first add in classes, preceded by prerequisites, then fill in with all of the other random credits (you don't necessarily have to do the steps in that order, just that way of looking at things)
//make requirements generalizable
 //make a function that get requirements
 //in the future the major database would come in where we would search
//have access to a function that gives any class for requirements
*/

import 'dart:collection';
import '../database/class.dart';
import '../database/class_database_helper.dart';
import '../database/major.dart';
//import 'int_wrapper.dart';
//I beleive future we will pass in a single final_class where we will use the prereqs to make our prereq chain

//search for all the requirements that you haven't met yet
class AlgorithmTesting {
  int total_credits_remaining = 128;
  final int coe_core_credits = 39;
  int intellectual_breadth;
  int ulcs_credits;
  int flex_credits;
  ClassDatabaseHelper database;
  
  List<int> seed = [];

  Set<Class> current_class_list = {};

  AlgorithmTesting(this.ulcs_credits,
                   this.intellectual_breadth,
                   this.flex_credits,
                   this.database
                  );

  Future<List<Class>> class_sequence() async {
    //develop class sequence>
    make_seed();
    List<Class> _class_sequence = [];
    //seed is how we are searching data base
    HashMap<int, String> all_prereqs = new HashMap<int, String>();

    List<Class> _seed_class = await database.getAllClassesThatMeetReqs(idNumber: seed[0]);

    all_prereqs[seed[0]] = _seed_class[0].prereqs;

    Queue<Class> search = Queue<Class>();
    search.add(_seed_class[0]); //will eventually be passed in
    current_class_list.add(_seed_class[0]);

    while(search.isNotEmpty){
      Class curr_class = search.first;
      search.removeFirst();

      if(all_prereqs.containsKey(curr_class.id)){
          //replace with data base search for curr_class_id prereqs
          List<int> curr_class_id_prereqs = getPrereqs_Class(curr_class);
          for(int i = 0; i < curr_class_id_prereqs.length; i++){
            if(!current_class_list.contains(curr_class_id_prereqs[i]))
            {
              Class _prereq_search = (await database.getAllClassesThatMeetReqs(idNumber: curr_class_id_prereqs[i]))[0];
              search.add(_prereq_search);
              current_class_list.add(_prereq_search);
              _class_sequence.add(_prereq_search);
              
              //add curr class to a running tally of courses
              total_credits_remaining -= _prereq_search.credits;
            }
          }
      }
    }
    return _class_sequence;
    //find out how many of each type of credit still needed
    //search data base for classes that fit class type
  }
  //pass in a class, gets the prereq string and breaks the string into individual prereqs
  //using the class id and returning a list<class_ids>
  List<int> getPrereqs_Class(Class class_name){
    String original = class_name.prereqs;
    return getPrereqs_string(original);
  }
  
  List<int> getPrereqs_string(String string_prereqs){
    List<int> prereqs = [];

    String add_coma = ',';

    String combined = '$string_prereqs$add_coma';

    int begin_string = 0;
    for(int i = 0; i < combined.length; i++) //will add all prereqs except for the last one
    {
      if(combined[i] == ','){
        //parsing string and casting it to int to add to prereq list of ints
        String new_id = string_prereqs.substring(begin_string, i);
        begin_string = i+1;
        try{
          int new_id_int = int.parse(new_id);
          prereqs.add(new_id_int);
        } on FormatException{
          print('String cannot be converted');
        }
      }
    }
    return prereqs;
  }
 
  //MVP: Just CS COE program requirements, brute force add for now
  List<int> getProgramRequirements(/*major, minor*/){
    List<int> progreqs = [];

    //will add EECS course ID's
             //183, 203, 280, 281, 370, 376, 496
    //will add COE requiremetns course ID's

    return progreqs;
  }
  void make_seed()
  {
    //hard code a seed
    //testing with 1234567, 1234678, 1234789, 2233123, 2233234, 2233345
    seed.add(0000496);
  }
  void print_class_sequence(List<int> classes)
  {
    for(int i = 0; i < classes.length; i++)
    {
      print('1: ${classes[i]}\n');
    }
  }
//  List<Class> getListOfClasses(/*reqs needed*/) {


//  }

}

//passing in seed, build chain and find out how many credits you need left in each department. EX: ULCS, IB, GE
//searching the remaining classes with the data base

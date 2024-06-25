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
//import 'int_wrapper.dart';
//I beleive future we will pass in a single final_class where we will use the prereqs to make our prereq chain
 int algorithm(List<Class> prereqs){
  
  int total_credits = 0;
  HashMap<int, String> all_prereqs = new HashMap<int, String>();

  for(int i = 0; i < prereqs.length; i++){
    all_prereqs[prereqs[i].id] = prereqs[i].prereqs;
  }

  Queue<Class> search = Queue<Class>();
  search.add(prereqs[0]); //will eventually be passed in

  while(search.isNotEmpty){
    Class curr_class = search.first;
    search.removeFirst();

    if(all_prereqs.containsKey(curr_class)){
      /*this section will iterate through the string of prereqs and add them to search
      
      for(int i = 0; i < all_prereqs[curr_class].second.length; i++
      {

        search.add(course name);

      }


      */
    
    //add curr class to a running tally of courses
      total_credits += curr_class.credits;
    }
  }
  return 128 - total_credits; //returning remaining credits needed after sequence
 }

<<<<<<< HEAD
=======
import '/database/class.dart';
>>>>>>> c3541c4 (made simple test ui and implemented database functions)
class AlgorithmTesting {


 //algorithm data
 //-------------------------------------------
 //functions
<<<<<<< HEAD
//  List<Class> getPrereqs(Class &class) {


//     //pull in from the "prereqs" string.


//     //now break the string into the classes that are needed
//     List<String> prereqNames; //edit later to make it 2-D for classes that complete the same prereq
//     int depth = 0;
//     int curr_begin = 0;
//     for(int i = 0; i < class.prereqs.length; i++){
//       if(class.prereqs[i] == ';' || class.prereqs[i] == ','){
//         prereqNames.add(class.prereqs.substring(curr_begin, i));
//       }
//     } 

//     //then search data base for associated class


//     //add class to List


//     //return the new List of classes

//  }
 
//  List<Class> getProgramRequirements(/*major, minor*/){

=======
 List<Class> getPrereqs(Class classInput) {
  return List.empty();
 }


 List<Class> getProgramRequirements(/*major, minor*/){
  return List.empty();
 }


 List<Class> getListOfClasses(/*reqs needed*/) {
  return List.empty();
>>>>>>> c3541c4 (made simple test ui and implemented database functions)

//  }

//  List<Class> getListOfClasses(/*reqs needed*/) {


//  }




}


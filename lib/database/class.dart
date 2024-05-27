class Class
{
  //basic class information
  final String department; //EX: EECS
  final int courseNumber; //EX: 281
  final int credits; //EX: 4
  final String prereqs; //list of prereqs as string. ';' seperating different requirements ',' seperating classes that would fufil the same req

  
  //COE 
  final int isFlexTech; //number of required credits
  final int isIB; //number of required credits


  //CS
  final int isULCS; //number of required credits
  
  //TODO: Expand program to include LSA REQS
  // 
  // LSA
  // final int isCE; // number of required credits
  final int isHU; // number of required credits
  // final int isID; // number of required credits
  // final int isMSA; //number of required credits  
  // final int isNS; //number of required credits
  // final int isSS; //number of required credits

  //LSA Skill requirements
  // final int isFYWR; //number of required credits
  // final int isULWR; //number of required credits
  // final int isRE; //number of required credits
  // final int isQR1; //number of required credits  
  // final int isQR2; //number of required credits
  // final int isLANGREQ; //number of required credits



  Class({
    required this.department,
    required this.courseNumber,
    required this.credits,
    required this.prereqs,
    // required this.isCE,
    required this.isHU,
    // required this.isID,
    // required this.isMSA,
    // required this.isNS,
    // required this.isSS,
    // required this.isFYWR,
    // required this.isULWR,
    // required this.isRE,
    // required this.isQR1,
    // required this.isQR2,
    // required this.isLANGREQ,
    required this.isFlexTech,
    required this.isIB,
    required this.isULCS,
  });
}
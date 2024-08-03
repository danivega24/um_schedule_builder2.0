import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'class.dart';

class ClassDatabaseHelper {

  static Database? _db;
  static final ClassDatabaseHelper instance = ClassDatabaseHelper._constructor();

  final String _classIdColumnName = "id";
  final String _classTableName = "classes";
  final String _classDepartmentColumnName = "department";
  final String _classCourseNumberColumnName = "courseNumber";
  final String _classCreditsColumnName = "credits";
  final String _classPrereqsColumnName = "prereqs";
  final String _classIsHUColumnName = "isHU";
  final String _classIsFlexTechColumnName = "isFlexTech";
  final String _classIsIBTechColumnName = "isIB";
  final String _classIsULCSColumnName = "isULCS";

  ClassDatabaseHelper._constructor();


  Future<Database> get database async {
    if (_db != null) return _db!;
    _db = await getDatabase();
    return _db!;
  }

  Future<Database> getDatabase() async {
    final databaseDirPath = await getDatabasesPath();
    final databasePath = join(databaseDirPath, "class_database.db");
    final database = await openDatabase(
      databasePath, 
      version: 4,
      onCreate: (db, version) {
        db.execute('''
        CREATE TABLE $_classTableName (
          $_classIdColumnName INTEGER NOT NULL, 
          $_classDepartmentColumnName TEXT NOT NULL, 
          $_classCourseNumberColumnName INTEGER NOT NULL, 
          $_classCreditsColumnName INTEGER NOT NULL, 
          $_classPrereqsColumnName TEXT,
          $_classIsHUColumnName INTEGER,
          $_classIsFlexTechColumnName INTEGER,
          $_classIsIBTechColumnName INTEGER,
          $_classIsULCSColumnName INTEGER
        )
        ''');

        // ALL CODE FOR ON CREATE
        dataOnCreate();
      },
      onUpgrade: (db, oldVersion, newVersion) {
        db.execute("DELETE FROM $_classTableName");
        dataOnCreate();
      },
    
    );
    return database;
  }

  void dataOnCreate()
  {
    addClass(Class(department: "EECS", courseNumber: 183, credits: 4, prereqs: ""               , isHU: 0, isFlexTech: 0, isIB: 0, isULCS: 0, id: 0000183));
    addClass(Class(department: "EECS", courseNumber: 203, credits: 4, prereqs: "0000183"        , isHU: 0, isFlexTech: 0, isIB: 0, isULCS: 0, id: 0000203));
    addClass(Class(department: "EECS", courseNumber: 280, credits: 4, prereqs: "0000183"        , isHU: 0, isFlexTech: 0, isIB: 0, isULCS: 0, id: 0000280));
    addClass(Class(department: "EECS", courseNumber: 281, credits: 4, prereqs: "0000203,0000280", isHU: 0, isFlexTech: 0, isIB: 0, isULCS: 0, id: 0000281));
    addClass(Class(department: "EECS", courseNumber: 370, credits: 4, prereqs: "0000203,0000280", isHU: 0, isFlexTech: 0, isIB: 0, isULCS: 0, id: 0000370));
    addClass(Class(department: "EECS", courseNumber: 376, credits: 4, prereqs: "0000203,0000280", isHU: 0, isFlexTech: 0, isIB: 0, isULCS: 0, id: 0000376));
    addClass(Class(department: "EECS", courseNumber: 496, credits: 4, prereqs: "0000376,0000370", isHU: 0, isFlexTech: 0, isIB: 0, isULCS: 0, id: 0000496));

  }

  void addClass(Class classToInsert) async 
  {

    final db = await database;
    await db.insert(
      _classTableName, 
      {
        _classIdColumnName: classToInsert.id,
        _classDepartmentColumnName: classToInsert.department, 
        _classCourseNumberColumnName: classToInsert.courseNumber,
        _classCreditsColumnName: classToInsert.credits, 
        _classPrereqsColumnName: classToInsert.prereqs, 
        _classIsHUColumnName: classToInsert.isHU, 
        _classIsFlexTechColumnName: classToInsert.isFlexTech, 
        _classIsIBTechColumnName: classToInsert.isIB, 
        _classIsULCSColumnName: classToInsert.isULCS,
      },
    );
  }

  //converts the sqlite output to a list
  List<Class> convertQueryToList(List<Map<String, Object?>> query)
  {
    return query.map((e) => Class(
      department: e[_classDepartmentColumnName] as String, 
      courseNumber: e[_classCourseNumberColumnName] as int, 
      credits: e[_classCreditsColumnName] as int, 
      prereqs: e[_classPrereqsColumnName] as String, 
      isHU: e[_classIsHUColumnName] as int, 
      isFlexTech: e[_classIsFlexTechColumnName] as int, 
      isIB: e[_classIsIBTechColumnName] as int, 
      isULCS: e[_classIsULCSColumnName] as int, 
      )).toList();
  }

  //returns a complete list of all classes
  Future<List<Class>> getAllClasses() async {
    final db = await database;
    final data = await db.query(_classTableName);
    List<Class> tasks = convertQueryToList(data);
    return tasks;
  }

  //returns list of all classes that meet a raw sqlite query
  Future<List<Class>> getListFromQuery(String SQLiteQuery) async
  {
    final db = await database;
    final data = await db.rawQuery(SQLiteQuery);
    return convertQueryToList(data);
  }

  Future<List<Class>> getAllClassesThatMeetReqs ({
    int minimumCourseNumber = 0, 
    int minimumCredits = 0, 
    bool isHU = false, 
    bool isFlexTech = false, 
    bool isIB = false, 
    bool isULCS = false, 
    int idNumber = -1}) async
    {
      int huNumber = isHU ? 1 : 0;
      int flexTechNumber = isFlexTech ? 1 : 0;
      int ibNumber = isIB ? 1 : 0;
      int ulcsNumber = isULCS ? 1 : 0;

      String query = '''SELECT * FROM $_classTableName
      WHERE $_classCourseNumberColumnName >= $minimumCourseNumber
      AND $_classCreditsColumnName >= $minimumCredits
      AND $_classIsHUColumnName >= $huNumber
      AND $_classIsHUColumnName >= $huNumber
      AND $_classIsFlexTechColumnName >= $flexTechNumber
      AND $_classIsIBTechColumnName >= $ibNumber
      AND $_classIsULCSColumnName >= $ulcsNumber
      ''';

      if (idNumber != -1)
      {
        query = "$query AND $_classIdColumnName = $idNumber";
      }

      return getListFromQuery(query);
    }
}
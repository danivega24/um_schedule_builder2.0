import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'class.dart';
import 'major.dart';

class ClassDatabaseHelper {

  static Database? _db;
  static final ClassDatabaseHelper instance = ClassDatabaseHelper._constructor();

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
    final databasePath = join(databaseDirPath, "class_db.db");
    final database = await openDatabase(
      databasePath, 
      version: 1,
      onCreate: (db, version) {
        db.execute('''
        CREATE TABLE $_classTableName (
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
      },
    );
    return database;
  }

  void addClass({
    required String department, 
    required int courseNumber, 
    required int credits,
    String prereqs = "",
    int isHU = 0, 
    int isFlexTech = 0,
    int isIB = 0,
    int isULCS = 0  
    }) async 
  {

    final db = await database;
    await db.insert(
      _classTableName, 
      {
        _classDepartmentColumnName: department, 
        _classCourseNumberColumnName: courseNumber,
        _classCreditsColumnName: credits, 
        _classPrereqsColumnName: prereqs, 
        _classIsHUColumnName: isHU, 
        _classIsFlexTechColumnName: isFlexTech, 
        _classIsIBTechColumnName: isIB, 
        _classIsULCSColumnName: isULCS,
      },
    );
  }

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

  Future<List<Class>> getAllClasses() async {
    final db = await database;
    final data = await db.query(_classTableName);
    List<Class> tasks = convertQueryToList(data);
    return tasks;
  }

  Future<List<Class>> getQueryFromList(String SQLiteQuery) async
  {
    final db = await database;
    final data = await db.rawQuery(SQLiteQuery);
    return convertQueryToList(data);
  }
}
import 'package:learningplatformapp/AllClass/course.dart';
import 'package:learningplatformapp/AllClass/portal.dart';
import 'package:learningplatformapp/AllClass/trainer.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class SqlDb {
  static Future<Database> _openDatabase() async {
    final databasePath = await getDatabasesPath();
    final path = join(databasePath, 'platform.db');
    print(databasePath);
    return openDatabase(path, version: 16, onCreate: _CreateDatabase);
  }

  static Future<void> _CreateDatabase(Database db, int version) async {
    await db.execute('''
       CREATE TABLE "Portal" (
	      "PortalID"	INTEGER,
	      "PortalName"	TEXT,
	      "PortalDescription"	TEXT,
	      "IsActive"	INTEGER,
	       PRIMARY KEY("PortalID" AUTOINCREMENT)
     )
      ''');
    await db.execute('''
        CREATE TABLE "Trainer" (
        "TrainerID"	INTEGER,
        "TrainerFName"	TEXT,
        "TrainerLName"	TEXT,
        "TrainerProfilePic"	TEXT,
        "TrainerTelephone"	TEXT,
        "TrainerEmail"	TEXT,
        "IsActive"	INTEGER,
        PRIMARY KEY("TrainerID" AUTOINCREMENT)
    )
    ''');
    await db.execute('''
  CREATE TABLE "Course" (
    "CourseID"          INTEGER,
    "CourseName"        TEXT,
    "CourseDescription" TEXT,
    "CoursePrice"       NUMERIC,
    "TrainerShareRate"  NUMERIC,
    "CreateDate"        TEXT,
    "IsActive"          INTEGER,  -- Corrected column name
    "TrainerID"         INTEGER,
    "PortalID"          INTEGER,
    PRIMARY KEY("CourseID" AUTOINCREMENT),
    FOREIGN KEY("TrainerID") REFERENCES "Trainer"("TrainerID"),
    FOREIGN KEY("PortalID") REFERENCES "Portal"("PortalID")
  )
     ''');
  }

  //static Future<List<Course>> getCoursesByPortal(int portalID) async {
  //  final db = await _openDatabase();
  //  final List<Map<String, dynamic>> courseMapList = await db.query(
  //    'Course',
  //    where: 'PortalID = ?',
  //    whereArgs: [portalID],
  //  );
  //  return courseMapList.map((map) => Course.fromMap(map)).toList();
  //}

//  static Future<List<Trainer>> getTrainer() async {
  //  final db = await _openDatabase();
    //final List<Map<String, dynamic>> TrainerMapList = await db.query('Trainer');
    //return TrainerMapList.map((map) => Trainer.fromMap(map)).toList();
 // }
}


import 'package:flutter_sqflite_sample/employee.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseHelper {
  static final DatabaseHelper _instance = DatabaseHelper.internal();
  static Database? _database;

  factory DatabaseHelper() {
    return _instance;
  }

  DatabaseHelper.internal();

  Future<Database> get database async {
    if (_database != null) {
      return _database!;
    }
    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    final documentDirectory = await getApplicationDocumentsDirectory();
    final path = join(documentDirectory.path, 'employee_database.db');

    return await openDatabase(
      path,
      version: 1,
      onCreate: (db, version) async {
        await db.execute(
          "CREATE TABLE Employees(id INTEGER PRIMARY KEY AUTOINCREMENT, name TEXT, age INTEGER)",
        );
      },
    );
  }

  Future<void> insertEmployee(Employee employee) async {
    final db = await database;
    await db.insert(
      'Employees',
      employee.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<List<Employee>> getEmployeeList() async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query('Employees');

    return List.generate(
      maps.length,
      (index) => Employee(
        id: maps[index]['id'],
        name: maps[index]['name'],
        age: maps[index]['age'],
      ),
    );
  }

  Future<void> updateEmployee(Employee employee) async {
    final db = await database;
    await db.update(
      'Employeees',
      employee.toMap(),
      where: 'id = ?',
      whereArgs: [employee.id],
    );
  }

  Future<void> deleteEmployee(int id) async {
    final db = await database;
    await db.delete('Employees', where: 'id = ?', whereArgs: [id]);
  }
}

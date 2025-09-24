import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_sqflite_sample/database_helper.dart';
import 'package:flutter_sqflite_sample/employee.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      home: const MyHomePage(title: 'Flutter Sqflite Demo'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final DatabaseHelper _dbHelper = DatabaseHelper();
  List<Employee> _employeeList = [];

  @override
  void initState() {
    super.initState();
    _loadEmployeeList();
  }

  int getRandomNumber({int min = 0, int max = 100}) {
    if (min > max) {
      throw ArgumentError('min should be less than or equal to max');
    }
    final random = Random();
    return min + random.nextInt(max - min + 1);
  }

  Future<void> _loadEmployeeList() async {
    final EmployeeList = await _dbHelper.getEmployeeList();
    setState(() {
      _employeeList = EmployeeList;
    });
  }

  Future<void> addEmployee() async {
    final newEmployee = Employee(
      name: "Employee: ${getRandomNumber()}",
      age: getRandomNumber(max: 100),
    );
    await _dbHelper.insertEmployee(newEmployee);
    _loadEmployeeList();
  }

  Future<void> updateEmployee(Employee employee) async {
    final updatedEmployee = Employee(
      id: employee.id,
      name: '${employee.name}*',
      age: employee.age,
    );
    await _dbHelper.updateEmployee(updatedEmployee);
    _loadEmployeeList();
  }

  Future<void> deleteEmployee(int id) async {
    await _dbHelper.deleteEmployee(id);
    _loadEmployeeList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,

        title: Text(widget.title),
      ),
      body: _employeeList.isEmpty
          ? const Center(child: Text("No Employees found. Add some!"))
          : ListView.builder(
              itemCount: _employeeList.length,
              itemBuilder: (BuildContext context, int index) {
                final employee = _employeeList[index];

                return ListTile(
                  title: Text(employee.name),
                  subtitle: Text("Age: ${employee.age}"),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        onPressed: () => updateEmployee(employee),
                        icon: Icon(Icons.edit),
                      ),
                      IconButton(
                        onPressed: () => deleteEmployee(employee.id!),
                        icon: Icon(Icons.delete),
                      ),
                    ],
                  ),
                );
              },
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => addEmployee(),
        tooltip: 'Add Employee',
        child: const Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}

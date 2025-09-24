class Employee {
  final int? id;
  final String name;
  final int age;

  Employee({this.id, required this.name, required this.age});

  Map<String, dynamic> toMap() {
    return {'id': id, 'name': name, 'age': age};
  }

  @override
  String toString() {
    return 'Employee{id: $id, name: $name, age: $age}';
  }
}

# Flutter Sqflite Demo App

A simple **Flutter** application demonstrating CRUD (Create, Read, Update, Delete) operations using **Sqflite**, a SQLite plugin for Flutter.

This app allows you to **add, update, and delete employees** with a random age and name.

---

## Features

- Add a new employee with a random name and age.
- Update an employee's name.
- Delete an employee.
- Persistent local storage using SQLite (`sqflite`).
- Simple and clean UI using Flutter Material widgets.

---

## Screenshots

### Home Screen (No Employees)

![No Employees Screenshot](screenshots/no_employees.png)

### Employee List

![Employee List Screenshot](screenshots/employee_list.png)

---

## Getting Started

### Prerequisites

- Flutter SDK >= 3.35.4
- Dart SDK >= 3.0.0
- Android Studio or VS Code

---

### Installation

1. Clone the repository:

```bash
git clone https://github.com/yourusername/flutter_sqflite_sample.git
cd flutter_sqflite_sample
```

2. Install Dependencies:

```bash
flutter pub get
```

3. Run the app:

```bash
flutter run
```

### Project Structure

```bash
lib/
├── main.dart          # Main application file
├── employee.dart      # Employee model
├── database_helper.dart # Sqflite database helper class
```

### main.dart

- Initializes the app and sets up the home page.
- Contains the main CRUD logic.
- Uses ListView.builder to display employee list.

### employee.dart

- Defines the Employee model.
- Contains helper methods like toMap() for database storage.

### database_helper.dart

- Manages SQLite database.
- Provides methods:

  - insertEmployee(Employee employee)
  - getEmployeeList()
  - updateEmployee(Employee employee)
  - deleteEmployee(int id)

### Usages

- Add Employee: Tap the "+" floating button.
- Update Employee: Tap the edit icon next to an employee.
- Delete Employee: Tap the delete icon next to an employee.
  - The app automatically updates the list after each operation.

### Dependencies

- [sqflite](https://pub.dev/packages/sqflite) – SQLite plugin for Flutter.
- [path](https://pub.dev/packages/path) – For handling file paths.
- [path_provider](https://pub.dev/packages/path_provider) – To get application document directory.

### Add them in your pubspec.yaml:

```bash
dependencies:
  flutter:
    sdk: flutter
  sqflite: ^2.2.8+4
  path: ^1.8.4
  path_provider: ^2.0.16
```

### Notes

- Random numbers are generated for employee names and ages.
- Employee names are updated by appending \* when edited.
- Database is persistent across app restarts.

### Future Improvements

- Add search functionality.
- Add sorting by age or name.
- Add form validation for employee details.
- Implement better UI for adding/updating employees.

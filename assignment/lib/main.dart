import 'package:assignment/utils/db_helper.dart';
import 'package:flutter/material.dart';
import 'employee_list/employee_list_screen.dart';
void main(){
  WidgetsFlutterBinding.ensureInitialized();
  ///opening DB ):
  DBHelper.dbhOpenDatabase();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: EmployeeListPage(),
    );
  }
}


import 'package:assignment/employee_list/data_classes.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class DetailScreenPage extends StatefulWidget {
  final Employee employee;
  DetailScreenPage({Key key,this.employee}) : super(key: key);
  @override
  _DetailScreenPageState createState() => _DetailScreenPageState();
}

class _DetailScreenPageState extends State<DetailScreenPage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Text(
            'You have pushed the button this many times:',
          ),
          Text(widget.employee?.username??""),
          Text(widget.employee?.email??""),
          Text(widget.employee.address?.zipcode??""),
          Text(widget.employee.address?.zipcode??""),
          Text(widget.employee.address?.zipcode??""),

        ],
      ),
      // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}

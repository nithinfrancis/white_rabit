import 'package:assignment/employee_list/data_classes.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class DetailScreenPage extends StatefulWidget {
  final Employee employee;

  DetailScreenPage({Key key, this.employee}) : super(key: key);

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
          (null != widget.employee && null != widget.employee.profileImage)
              ? Container(
                  width: 55.0,
                  height: 55.0,
                  decoration: new BoxDecoration(
                    borderRadius: BorderRadius.circular(55),
                    color: Colors.transparent,
                    image: DecorationImage(
                      image: NetworkImage(widget.employee.profileImage),
                      fit: BoxFit.fill,
                    ),
                  ),
                  margin: const EdgeInsets.symmetric(horizontal: 8.0),
                )
              : Container(
                  width: 55.0,
                  height: 55.0,
                  decoration: new BoxDecoration(
                    borderRadius: BorderRadius.circular(55),
                    color: Colors.transparent,
                  ),
                  margin: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: Center(child: Text(widget.employee?.name?.substring(0, 1) ?? "A")),
                ),
          Text(widget.employee?.username ?? ""),
          Text(widget.employee?.email ?? ""),
          Text(widget.employee?.address?.zipcode ?? ""),
          Text(widget.employee?.address?.city ?? ""),
          Text(widget.employee?.address?.suite ?? ""),
          Text(widget.employee?.phone ?? ""),
          Text(widget.employee?.website ?? ""),
          Text(widget.employee?.company?.name ?? ""),
          Text(widget.employee?.company?.catchPhrase ?? ""),
        ],
      ),
      // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}

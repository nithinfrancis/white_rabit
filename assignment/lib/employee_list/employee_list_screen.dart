import 'package:assignment/employee_screen/employee_detail_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'data_classes.dart';
import 'employee_list_bloc.dart';

class EmployeeListPage extends StatefulWidget {
  EmployeeListPage({Key key}) : super(key: key);

  @override
  _EmployeeListPageState createState() => _EmployeeListPageState();
}

class _EmployeeListPageState extends State<EmployeeListPage> {
  EmployeeBloc _bloc = EmployeeBloc();

  List<Employee> _employeeList = new List();
  List<Employee> _tempEmployeeList = new List();

  final _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _bloc.add(LoadEmployeeEvent());
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<EmployeeBloc, EmployeeScreenState>(
      bloc: _bloc,
      listener: (context, state) {
        print(state);
        if (state is EmployeeLoadingState) {
        } else if (state is EmployeeLoadErrorState) {
        } else if (state is EmployeeLoadedState) {
          _employeeList.addAll(state.employeeList.employeeList);
          _tempEmployeeList.addAll(state.employeeList.employeeList);
        }
      },
      child: BlocBuilder(
        bloc: _bloc,
        builder: (BuildContext context, EmployeeScreenState state) {
          return Scaffold(
            appBar: AppBar(
              title: Text("List"),
            ),
            body: Column(
              children: <Widget>[
                Container(
                  height: 150,
                  child: Padding(
                    padding: const EdgeInsets.only(left: 40.0, right: 40.0, bottom: 20),
                    child: TextField(
                      onSubmitted: (value) {
                        _tempEmployeeList.clear();
                        for (Employee emp in _employeeList) {
                          if (emp != null && emp.name != null && emp.email != null) {
                            if (emp.name.startsWith(value) || emp.email.startsWith(value)) {
                              _tempEmployeeList.add(emp);
                            }
                          }
                        }
                        setState(() {});
                      },
                      textAlign: TextAlign.start,
                      keyboardType: TextInputType.text,
                      cursorColor: Colors.black87,
                      decoration: InputDecoration(
                        isDense: true,
                        suffixIcon: Icon(
                          Icons.keyboard_arrow_down,
                          color: Color(0xff),
                        ),
                        contentPadding: EdgeInsets.all(8),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5),
                          borderSide: BorderSide(color: Colors.black, width: 1.0),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5),
                          borderSide: BorderSide(color: Colors.grey, width: 1.0),
                        ),
                        hintText: "search by username or email",
                      ),
                      controller: _searchController,
                    ),
                  ),
                ),
                Expanded(
                  child: (_tempEmployeeList != null && _tempEmployeeList.isNotEmpty)
                      ? ListView.builder(
                          scrollDirection: Axis.vertical,
                          itemCount: _tempEmployeeList.length,
                          itemBuilder: (context, i) {
                            return Padding(
                              padding: const EdgeInsets.only(left: 10.0, right: 10.0, bottom: 10.0),
                              child: InkWell(
                                onTap: () {
                                  Navigator.push(context, new MaterialPageRoute(builder: (context) => new DetailScreenPage(employee: _tempEmployeeList[i])));
                                },
                                child: Card(
                                  child: (Container(
                                    height: 100,
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                      children: <Widget>[
                                        (null != _tempEmployeeList[i] && null != _tempEmployeeList[i].profileImage)
                                            ? Container(
                                                width: 55.0,
                                                height: 55.0,
                                                decoration: new BoxDecoration(
                                                  borderRadius: BorderRadius.circular(55),
                                                  color: Colors.transparent,
                                                  image: DecorationImage(
                                                    image: NetworkImage(_tempEmployeeList[i].profileImage),
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
                                                child: Center(child: Text(_tempEmployeeList[i]?.name?.substring(0, 1) ?? "A")),
                                              ),
                                        Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          children: <Widget>[
                                            Text(_tempEmployeeList[i]?.name ?? "name"),
                                            Text(_tempEmployeeList[i]?.username ?? "user name"),
                                          ],
                                        ),
                                      ],
                                    ),
                                  )),
                                ),
                              ),
                            );
                          },
                        )
                      : Center(
                          child: Text("Empty data"),
                        ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}

import 'dart:async';
import 'package:assignment/utils/api.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';

import 'data_classes.dart';

class EmployeeBloc extends Bloc<EmployeeScreenEvent, EmployeeScreenState> {
  @override
  EmployeeScreenState get initialState => InitialEmployeeScreenState();

  @override
  Stream<EmployeeScreenState> mapEventToState(EmployeeScreenEvent event) async* {
    if (event is LoadEmployeeEvent) {
      try {
        yield EmployeeLoadingState();
        EmployeeList listOfEmployee = new EmployeeList();
        List<Employee> _employeeList = await EmployeeList.fillFromTable();
        if (null != _employeeList && _employeeList.isEmpty) {
          listOfEmployee = await API().getListFromServer();
        } else {
          listOfEmployee.employeeList.addAll(_employeeList);
        }
        yield EmployeeLoadedState(listOfEmployee);
      } catch (e) {
        print(e);
        await Future.delayed(Duration(milliseconds: 1000));
        yield EmployeeLoadErrorState(errorMessage(e.toString()));
      }
    }
  }
}

@immutable
abstract class EmployeeScreenEvent {}

class LoadEmployeeEvent extends EmployeeScreenEvent {
  final DateTime fromDate;
  final DateTime toDate;

  LoadEmployeeEvent({this.fromDate, this.toDate});
}

@immutable
abstract class EmployeeScreenState {}

class InitialEmployeeScreenState extends EmployeeScreenState {}

class EmployeeLoadingState extends EmployeeScreenState {}

class EmployeeLoadedState extends EmployeeScreenState {
  final EmployeeList employeeList;

  EmployeeLoadedState(this.employeeList);
}

class EmployeeLoadErrorState extends EmployeeScreenState {
  final String errorMessage;

  EmployeeLoadErrorState(this.errorMessage);
}

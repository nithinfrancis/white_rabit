import 'package:assignment/utils/db_helper.dart';
import 'package:sqflite/sqflite.dart';

class EmployeeList {
  List<Employee> employeeList = new List();

  EmployeeList();

  /// Parse the server response
  EmployeeList.fromJsonMap(List<dynamic> responseMap) {
    if (null != responseMap && responseMap.isNotEmpty) {
      for (dynamic result in responseMap) {
        Employee _employee = new Employee.fromJson(result);
        if (null != _employee) {
          employeeList.add(_employee);
          Employee.insertEmployeeToDB(_employee);
        }
      }
    }
  }

  static Future<List<Employee>> fillFromTable() async {
    List<Map> userResult = await DBHelper.dbhQuery(Employee.tableName);

    List<Employee> tableContent = new List<Employee>();
    if (userResult.length > 0) {
      for (Map map in userResult) {
        tableContent.add(new Employee.fromJson(map));
      }
    }
    return tableContent;
  }

  static Future<void> insertAllToDb(List<Employee> list) async {
//    List<Map<String, dynamic>> employeeInsertMaps = List<Map<String, dynamic>>();
    for (Employee employee in list) {
      var insertMap = employee.getDBInsertMap();
      if (null != insertMap) {}
    }
    return -1;
  }
}

class Employee {
  static String tableName = "employee";
  int id;
  String name;
  String username;
  String email;
  String profileImage;
  Address address;
  String phone;
  String website;
  Company company;

  Employee({this.id, this.name, this.username, this.email, this.profileImage, this.address, this.phone, this.website, this.company});

  ///Employee table create DB query
  static createTable() {
    return "CREATE TABLE $tableName (id INTEGER PRIMARY KEY, name TEXT, username TEXT, email TEXT, profile_image TEXT, street TEXT,suite TEXT,city TEXT,zipcode TEXT,lat TEXT,lng TEXT,phone TEXT,website TEXT,companyName TEXT,catchPhrase TEXT,bs TEXT)";
  }

  ///Method used for getting the insert map
  Map<String, dynamic> getDBInsertMap() {
    Map<String, dynamic> values = new Map<String, dynamic>();
    values["id"] = id;
    values["name"] = name;
    values["email"] = email;
    values["userName"] = username;
    values["profile_image"] = profileImage;
    values["street"] = address?.street ?? "";
    values["suite"] = address?.suite ?? "";
    values["city"] = address?.city ?? "";
    values["zipcode"] = address?.zipcode ?? "";
    values["lat"] = address?.geo?.lat ?? "";
    values["lng"] = address?.geo?.lng ?? "";
    values["phone"] = phone ?? "";
    values["website"] = website ?? "";
    values["companyName"] = company?.name ?? "";
    values["catchPhrase"] = company?.catchPhrase ?? "";
    values["bs"] = company?.bs ?? "";
    return values;
  }

  static Future<void> insertEmployeeToDB(Employee employee) async {
    DBHelper.dbhInsert(tableName, employee.getDBInsertMap());
  }

  Employee.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    username = json['username'];
    email = json['email'];
    profileImage = json['profile_image'];
    address = json['address'] != null ? new Address.fromJson(json['address']) : null;
    if (address == null) {
      address = Address(zipcode: json['zipcode'], city: json['city'], street: json['street']);
    }
    phone = json['phone'];
    website = json['website'];
    company = json['company'] != null ? new Company.fromJson(json['company']) : null;
    if (company == null) {
      company = Company(name: json['companyName'], bs: json['bs'], catchPhrase: json['catchPhrase']);
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['username'] = this.username;
    data['email'] = this.email;
    data['profile_image'] = this.profileImage;
    if (this.address != null) {
      data['address'] = this.address.toJson();
    }
    data['phone'] = this.phone;
    data['website'] = this.website;
    if (this.company != null) {
      data['company'] = this.company.toJson();
    }
    return data;
  }
}

class Address {
  String street;
  String suite;
  String city;
  String zipcode;
  Geo geo;

  Address({this.street, this.suite, this.city, this.zipcode, this.geo});

  Address.fromJson(Map<String, dynamic> json) {
    street = json['street'];
    suite = json['suite'];
    city = json['city'];
    zipcode = json['zipcode'];
    geo = json['geo'] != null ? new Geo.fromJson(json['geo']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['street'] = this.street;
    data['suite'] = this.suite;
    data['city'] = this.city;
    data['zipcode'] = this.zipcode;
    if (this.geo != null) {
      data['geo'] = this.geo.toJson();
    }
    return data;
  }
}

class Geo {
  String lat;
  String lng;

  Geo({this.lat, this.lng});

  Geo.fromJson(Map<String, dynamic> json) {
    lat = json['lat'];
    lng = json['lng'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['lat'] = this.lat;
    data['lng'] = this.lng;
    return data;
  }
}

class Company {
  String name;
  String catchPhrase;
  String bs;

  Company({this.name, this.catchPhrase, this.bs});

  Company.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    catchPhrase = json['catchPhrase'];
    bs = json['bs'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['catchPhrase'] = this.catchPhrase;
    data['bs'] = this.bs;
    return data;
  }
}

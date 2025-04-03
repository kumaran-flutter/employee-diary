import 'package:hive_flutter/adapters.dart';
part 'employee_model.g.dart';

@HiveType(typeId: 0)
class EmployeeModel extends HiveObject {
  @HiveField(0)
  final String employeeId;

  @HiveField(1)
  final String employeeName;

  @HiveField(2)
  final String employeeRole;

  @HiveField(3)
  final String employeeStartDate;

  @HiveField(4)
  final String employeeEndDate;

  EmployeeModel({
    required this.employeeId,
    required this.employeeName,
    required this.employeeRole,
    required this.employeeStartDate,
    required this.employeeEndDate,
  });

  Map<String, dynamic> toJson() {
    return {
      'employeeId': employeeId,
      'employeeName': employeeName,
      'employeeRole': employeeRole,
      'employeeStartDate': employeeStartDate,
      'employeeEndDate': employeeEndDate,
    };
  }

  factory EmployeeModel.fromJson(Map<String, dynamic> json) {
    return EmployeeModel(
      employeeId: json['employeeId'] as String,
      employeeName: json['employeeName'] as String,
      employeeRole: json['employeeRole'] as String,
      employeeStartDate: json['employeeStartDate'] as String,
      employeeEndDate: json['employeeEndDate'] as String,
    );
  }

  @override
  String toString() {
    return 'EmployeeModel{employeeId: $employeeId, employeeName: $employeeName, employeeRole: $employeeRole, employeeStartDate: $employeeStartDate, employeeEndDate: $employeeEndDate}';
  }
}

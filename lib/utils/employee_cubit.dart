import 'package:bloc/bloc.dart';
import 'package:hive_flutter/hive_flutter.dart';
import '../models/employee_model.dart';
import 'employee_state.dart';

class EmployeeCubit extends Cubit<EmployeeState> {
  final Box<EmployeeModel> employeeBox;

  EmployeeCubit(this.employeeBox) : super(EmployeeLoading()) {
    loadEmployees();
  }

  void loadEmployees() {
    try {
      final employees = employeeBox.values.toList();
      emit(EmployeeLoaded(employees));
    } catch (e) {
      emit(EmployeeError("Failed to load employees"));
    }
  }

  void addEmployee(EmployeeModel employee) async {
    try {
      await employeeBox.put(employee.employeeId, employee);
      loadEmployees();
    } catch (e) {
      emit(EmployeeError("Failed to add employee"));
    }
  }

  void deleteEmployee(String employeeId) async {
    try {
      await employeeBox.delete(employeeId);
      loadEmployees();
    } catch (e) {
      emit(EmployeeError("Failed to delete employee"));
    }
  }

  void updateEmployee(EmployeeModel employee) async {
    try {
      await employeeBox.put(employee.employeeId, employee);
      loadEmployees();
    } catch (e) {
      emit(EmployeeError("Failed to update employee"));
    }
  }
}

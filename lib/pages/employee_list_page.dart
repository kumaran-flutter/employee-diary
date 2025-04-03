import 'package:employee_diary/common_widgets/common_widgets.dart';
import 'package:employee_diary/styles/styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../models/employee_model.dart';
import '../utils/utils.dart';
import 'pages.dart';

class EmployeeListPage extends StatefulWidget {
  const EmployeeListPage({super.key});

  @override
  State<EmployeeListPage> createState() => _EmployeeListPageState();
}

class _EmployeeListPageState extends State<EmployeeListPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.lightGray,
      appBar: CommonAppBar(title: 'Employee List', centerTitle: false),
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(bottom: 32),
        child: FloatingActionButton(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
          onPressed: () => _navigateToAddEmployeePage(context),
          backgroundColor: AppColors.twitterBlue,
          child: const Icon(Icons.add, color: Colors.white, size: 30),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endContained,
      body: BlocBuilder<EmployeeCubit, EmployeeState>(
        builder: (context, state) {
          if (state is EmployeeLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is EmployeeLoaded) {
            return _buildEmployeeLists(context, state.employees);
          } else if (state is EmployeeError) {
            return const Center(child: Text("Something went wrong"));
          }
          return const SizedBox.shrink();
        },
      ),
    );
  }

  void _navigateToAddEmployeePage(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder:
            (context) => BlocProvider.value(
              value: context.read<EmployeeCubit>(),
              child: const AddEmployeePage(),
            ),
      ),
    );
  }

  Widget _buildEmployeeLists(
    BuildContext context,
    List<EmployeeModel> employees,
  ) {
    final currentEmployees =
        employees.where((e) => !_isEmployeeExpired(e)).toList();
    final previousEmployees =
        employees.where((e) => _isEmployeeExpired(e)).toList();

    return currentEmployees.isEmpty && previousEmployees.isEmpty
        ? NoDataWidget()
        : Column(
          children: [
            _buildEmployeeSection("Current Employees", currentEmployees),
            _buildEmployeeSection("Previous Employees", previousEmployees),
            ListTile(
              contentPadding: EdgeInsets.only(left: 16, right: 16, bottom: 16),
              title: Text(
                "Swipe left to delete",
                style: PrimaryTextStyle.primaryStyle8,
              ),
            ),
          ],
        );
  }

  Widget _buildEmployeeSection(String title, List<EmployeeModel> employees) {
    return Expanded(
      child: Column(
        children: [
          ListTile(title: Text(title, style: PrimaryTextStyle.primaryStyle1)),
          Expanded(
            child: ListView.separated(
              separatorBuilder:
                  (context, index) => const Divider(
                    color: AppColors.lightGray,
                    height: 1,
                    thickness: 1,
                  ),
              itemCount: employees.length,
              itemBuilder: (context, index) {
                final employee = employees[index];
                return _buildEmployeeCard(context, employee);
              },
            ),
          ),
        ],
      ),
    );
  }

  bool _isEmployeeExpired(EmployeeModel employee) {
    return employee.employeeEndDate.isNotEmpty &&
        employee.employeeEndDate != "No date" &&
        CommonUtils.isExpired(employee.employeeEndDate);
  }

  String _getEmployeeDateRange(EmployeeModel employee) {
    return _isEmployeeExpired(employee)
        ? "${CommonUtils.formatDate(employee.employeeStartDate)} - ${CommonUtils.formatDate(employee.employeeEndDate)}"
        : "From ${CommonUtils.formatDate(employee.employeeStartDate)}";
  }

  Widget _buildEmployeeCard(BuildContext context, EmployeeModel employee) {
    return Dismissible(
      key: Key(employee.employeeId),
      direction: DismissDirection.endToStart,
      background: Container(
        color: Colors.red,
        alignment: Alignment.centerRight,
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: const Icon(Icons.delete, color: Colors.white),
      ),
      onDismissed: (direction) {
        final cubit = context.read<EmployeeCubit>();
        final dismissedEmployee = employee; // Store the dismissed employee

        cubit.deleteEmployee(employee.employeeId);

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text("Employee data has been deleted"),
            action: SnackBarAction(
              label: 'Undo',
              textColor: AppColors.twitterBlue,
              onPressed: () {
                cubit.addEmployee(dismissedEmployee);
              },
            ),
          ),
        );
      },
      child: Container(
        color: AppColors.whiteColor,
        padding: const EdgeInsets.symmetric(vertical: 8),

        child: ListTile(
          onTap:
              () => Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => AddEmployeePage(employee: employee),
                ),
              ),
          title: Text(
            employee.employeeName,
            style: PrimaryTextStyle.primaryStyle6,
          ),
          subtitle: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                employee.employeeRole,
                style: PrimaryTextStyle.primaryStyle7,
              ),
              const SizedBox(width: 8, height: 4),
              Text(
                _getEmployeeDateRange(employee),
                style: PrimaryTextStyle.primaryStyle9,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

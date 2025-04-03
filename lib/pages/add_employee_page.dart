import 'package:employee_diary/styles/styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../common_widgets/common_widgets.dart';
import '../models/models.dart';
import '../utils/employee_cubit.dart';
import 'package:uuid/uuid.dart';

class AddEmployeePage extends StatefulWidget {
  const AddEmployeePage({super.key, this.employee});
  final EmployeeModel? employee;

  @override
  State<AddEmployeePage> createState() => _AddEmployeePageState();
}

class _AddEmployeePageState extends State<AddEmployeePage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _roleController = TextEditingController();
  final TextEditingController _startDateController = TextEditingController();
  final TextEditingController _endDateController = TextEditingController();

  @override
  void initState() {
    if (widget.employee != null) {
      _nameController.text = widget.employee!.employeeName;
      _roleController.text = widget.employee!.employeeRole;
      _startDateController.text = widget.employee!.employeeStartDate;
      _endDateController.text = widget.employee!.employeeEndDate;
    }
    super.initState();
  }

  @override
  void dispose() {
    _nameController.dispose();
    _roleController.dispose();
    _startDateController.dispose();
    _endDateController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CommonAppBar(title: 'Add Employee Details', centerTitle: false),
      body: Form(
        key: _formKey,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,

          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                spacing: 24,
                children: [
                  TextFieldWidget(
                    controller: _nameController,
                    hintText: 'Employee Name',
                    prefixIcon: const Icon(
                      Icons.person_outline_rounded,
                      color: AppColors.twitterBlue,
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter employee name';
                      }
                      return null;
                    },
                  ),

                  TextFieldWidget(
                    controller: _roleController,
                    hintText: 'Select Role',
                    readOnly: true,
                    suffixIcon: const Icon(
                      Icons.arrow_drop_down_rounded,
                      color: AppColors.twitterBlue,
                      size: 38,
                    ),
                    prefixIcon: const Icon(
                      Icons.work_outline_rounded,
                      color: AppColors.twitterBlue,
                    ),
                    onTap: () async {
                      final selectedRole = await showModalBottomSheet<String>(
                        context: context,
                        builder: (context) => const RoleSelectionBottomSheet(),
                      );
                      if (selectedRole != null) {
                        setState(() {
                          _roleController.text = selectedRole;
                        });
                      }
                    },
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please select a role';
                      }
                      return null;
                    },
                  ),

                  Row(
                    spacing: 16,
                    children: [
                      Flexible(
                        child: DateFieldWidget(
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return '';
                            }
                            return null;
                          },
                          controller: _startDateController,
                        ),
                      ),
                      Icon(
                        Icons.arrow_forward_rounded,
                        color: AppColors.twitterBlue,
                        size: 18,
                      ),

                      Flexible(
                        child: DateFieldWidget(
                          controller: _endDateController,
                          isEndDate: true,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Column(
              children: [
                Divider(height: 0),
                Padding(
                  padding: const EdgeInsets.all(16),
                  child: ActionButton(
                    onCancelPressed: () {
                      Navigator.pop(context);
                    },
                    onSavePressed: () {
                      if (_formKey.currentState!.validate()) {
                        final String employeeId =
                            widget.employee?.employeeId ?? const Uuid().v4();
                        final EmployeeModel employee = EmployeeModel(
                          employeeId: employeeId,
                          employeeName: _nameController.text,
                          employeeRole: _roleController.text,
                          employeeStartDate: _startDateController.text,
                          employeeEndDate: _endDateController.text,
                        );
                        if (widget.employee != null) {
                          context.read<EmployeeCubit>().updateEmployee(
                            employee,
                          );
                        } else {
                          context.read<EmployeeCubit>().addEmployee(employee);
                        }
                        Navigator.pop(context);
                      }
                    },
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class RoleSelectionBottomSheet extends StatelessWidget {
  const RoleSelectionBottomSheet({super.key});

  @override
  Widget build(BuildContext context) {
    // List of role options
    final List<String> roles = [
      'Product Designer',
      'Flutter Developer',
      'QA Tester',
      'Product Owner',
    ];

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(16),
          topRight: Radius.circular(16),
        ),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: List.generate(roles.length, (index) {
          return Column(
            children: [
              InkWell(
                onTap: () {
                  Navigator.pop(context, roles[index]);
                },
                borderRadius: BorderRadius.circular(8),
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    vertical: 8,
                    horizontal: 16.0,
                  ),
                  child: Text(
                    roles[index],
                    style: PrimaryTextStyle.primaryStyle4,
                  ),
                ),
              ),
              if (index < roles.length - 1)
                const Divider(color: AppColors.borderGray, thickness: 1),
            ],
          );
        }),
      ),
    );
  }
}

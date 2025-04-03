import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'models/employee_model.dart';
import 'pages/pages.dart';
import 'utils/employee_cubit.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  Hive.registerAdapter(EmployeeModelAdapter());
  final employeeBox = await Hive.openBox<EmployeeModel>('employees');
  runApp(
    BlocProvider(
      create: (context) => EmployeeCubit(employeeBox),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: EmployeeListPage(),
    );
  }
}

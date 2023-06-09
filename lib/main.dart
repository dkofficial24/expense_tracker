import 'package:expense_tracker/core/models/dependency_injector.dart';
import 'package:expense_tracker/expense_tracker/provider/expense_provider.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:expense_tracker/expense_tracker/ui/screens/create_expense_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  DI.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Expense Tracker',debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: MultiProvider(providers: [
          Provider<ExpenseProvider>(create: (_) => DI.expenseProvider),
        ], child: const CreateExpenseScreen()));
  }
}

import 'package:expense_tracker/expense_tracker/models/expense_info_model.dart';
import 'package:expense_tracker/expense_tracker/repository/expense_repository.dart';
import 'package:flutter/cupertino.dart';

class ExpenseProvider extends ChangeNotifier {
  ExpenseProvider({required this.expenseRepository});

  ExpenseRepository expenseRepository;

  //Dependency Injection

  Future addExpense(ExpenseInfo expenseInfo) async {
    await expenseRepository.addExpense(expenseInfo);
  }

  Future deleteExpense(int id) async {}
}

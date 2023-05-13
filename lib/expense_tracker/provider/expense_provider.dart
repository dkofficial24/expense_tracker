import 'package:expense_tracker/expense_tracker/repository/expense_repository.dart';
import 'package:flutter/cupertino.dart';

class ExpenseProvider extends ChangeNotifier {
  ExpenseProvider({required this.expenseRepository});

  ExpenseRepository expenseRepository;
}

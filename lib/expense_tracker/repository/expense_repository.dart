import 'package:expense_tracker/expense_tracker/models/expense_info_model.dart';
import 'package:expense_tracker/expense_tracker/services/firebase_service.dart';

class ExpenseRepository {
  ExpenseRepository({required this.firebaseService});

  FirebaseService firebaseService;

  Future addExpense(ExpenseInfo expenseInfo) async {
    await firebaseService.addExpense(expenseInfo);
  }

  Future<List<ExpenseInfo>> getAllExpense() async {
    return firebaseService.getAllExpense();
  }

//todo delete functionality

// todo update functionality
}

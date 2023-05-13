import 'package:expense_tracker/expense_tracker/provider/expense_provider.dart';
import 'package:expense_tracker/expense_tracker/repository/expense_repository.dart';
import 'package:expense_tracker/expense_tracker/services/firebase_service.dart';

/// DI means Dependency Injection
class DI {
  static late ExpenseProvider _expenseProvider;
  static late ExpenseRepository _expenseRepository;
  static late FirebaseService _firebaseService;

  static init() {
    _firebaseService = FirebaseService();
    _expenseRepository = ExpenseRepository(firebaseService: _firebaseService);
    _expenseProvider = ExpenseProvider(expenseRepository: _expenseRepository);
  }

  static ExpenseProvider get expenseProvider => _expenseProvider;

  static ExpenseRepository get expenseRepository => _expenseRepository;

  static FirebaseService get firebaseService => _firebaseService;
}

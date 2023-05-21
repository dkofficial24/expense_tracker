import 'package:expense_tracker/expense_tracker/models/category_item.dart';

class CreateExpenseUtil {
  static int calculateTotalAmount(Map<String, CategoryItem> itemMap) {
    int totalAmount = 0;
    itemMap.forEach((key, value) {
      totalAmount += value.amount;
    });
    return totalAmount;
  }
}

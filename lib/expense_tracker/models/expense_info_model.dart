class ExpenseCategoryInfo {
  double amount;
  String category;

  ExpenseCategoryInfo(this.amount, this.category);
}

class ExpenseInfo {
  List<ExpenseCategoryInfo> categoryData;
  int total;
  int id;
  int date;

  ExpenseInfo(
      {required this.id,
      required this.categoryData,
      required this.total,
      required this.date});
}

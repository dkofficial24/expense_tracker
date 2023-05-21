import 'package:expense_tracker/expense_tracker/models/category_item.dart';
import 'package:flutter/material.dart';

typedef CategoryTapCallback = Function(CategoryItem item);

class CategoryChipWidget extends StatelessWidget {
  const CategoryChipWidget({
    required this.categoryItem,
    required this.categoryTapCallback,
    Key? key,
  }) : super(key: key);

  final CategoryItem categoryItem;
  final CategoryTapCallback categoryTapCallback;

  @override
  Widget build(BuildContext context) {
    return _renderCategoryChip(categoryItem);
  }

  Widget _renderCategoryChip(CategoryItem item) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 4.0),
      child: ElevatedButton(
        onPressed: () {
          categoryTapCallback(item);
        },
        child: Text(
          item.name,
          style: TextStyle(
            color: item.isSelected ? Colors.red : Colors.white,
          ),
        ),
      ),
    );
  }
}

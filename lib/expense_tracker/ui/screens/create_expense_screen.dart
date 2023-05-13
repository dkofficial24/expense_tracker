import 'package:expense_tracker/expense_tracker/models/category_item.dart';
import 'package:expense_tracker/expense_tracker/ui/widgets/custom_text_field.dart';
import 'package:flutter/material.dart';

class CreateExpenseScreen extends StatefulWidget {
  const CreateExpenseScreen({Key? key}) : super(key: key);

  @override
  State<CreateExpenseScreen> createState() => _CreateExpenseScreenState();
}

class _CreateExpenseScreenState extends State<CreateExpenseScreen> {
  int totalAmount = 0;
  final TextEditingController _amountEditingController =
      TextEditingController();

  bool isCategorySelected = false;

  Map<String, CategoryItem> itemMap = {
    "Party": CategoryItem(),
    "Movie": CategoryItem(),
    "Trip": CategoryItem(),
    "Club": CategoryItem(),
    "Fruits": CategoryItem(),
  };

  CategoryItem? currentCategoryItem;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding:
            const EdgeInsets.only(top: 40, left: 16, right: 16, bottom: 16),
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                totalAmount.toString(),
                textAlign: TextAlign.start,
                style:
                    const TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
              ),
              const SizedBox(
                height: 16,
              ),
              Wrap(
                children: itemMap.keys.map((e) {
                  itemMap[e]?.name = e;
                  return _renderChip(itemMap[e]!);
                }).toList(),
              ),
              const SizedBox(
                height: 16,
              ),
              Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8),
                  child: CustomTextFieldWidget(
                    controller: _amountEditingController,
                    isEnabled: currentCategoryItem != null,
                    onChanged: (value) {
                      if (value.isEmpty) return;
                      currentCategoryItem?.amount = int.parse(value);
                      setState(() {});
                    },
                  )),
              const SizedBox(
                height: 16,
              ),
              Flexible(
                child: GridView.count(
                  crossAxisCount: 5,
                  shrinkWrap: true,
                  childAspectRatio: 1,
                  children: List.generate(10, (index) {
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: ElevatedButton(
                          onPressed: currentCategoryItem != null
                              ? () {
                                  if (_amountEditingController.text == '0') {
                                    _amountEditingController.clear();
                                  }
                                  _amountEditingController.text +=
                                      index.toString();
                                  currentCategoryItem?.amount =
                                      int.parse(_amountEditingController.text);
                                  totalAmount +=
                                      currentCategoryItem?.amount ?? 0;
                                  setState(() {});
                                  setCursorPosition();
                                }
                              : null,
                          child: Text(index.toString())),
                    );
                  }),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  void setCursorPosition() {
    _amountEditingController.selection =
        TextSelection.fromPosition(TextPosition(
      offset: _amountEditingController.text.length,
    ));
  }

  Widget _renderChip(CategoryItem item) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 4.0),
      child: ElevatedButton(
        onPressed: () {
          _amountEditingController.clear();
          currentCategoryItem = item;
          itemMap.forEach((key, value) {
            if (key != currentCategoryItem?.name) {
              value.isSelected = false;
            } else {
              value.isSelected = true;
            }
          });
          _amountEditingController.text = item.amount.toString();
          setState(() {});
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

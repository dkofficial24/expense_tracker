import 'package:expense_tracker/core/core.dart';
import 'package:expense_tracker/expense_tracker/models/category_item.dart';
import 'package:expense_tracker/expense_tracker/ui/create_expense.util.dart';
import 'package:expense_tracker/expense_tracker/ui/ui.dart';
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
    StringConstant.party: CategoryItem(),
    StringConstant.movie: CategoryItem(),
    StringConstant.trip: CategoryItem(),
    StringConstant.club: CategoryItem(),
    StringConstant.fruits: CategoryItem(),
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

            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                '${StringConstant.party} - $totalAmount',
                textAlign: TextAlign.start,
                style:
                    const TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
              ),
              const SizedBox(
                height: 16,
              ),
              Flexible(
                child: Wrap(
                  children: itemMap.keys.map((e) {
                    itemMap[e]?.name = e;
                    return CategoryChipWidget(
                      categoryItem: itemMap[e]!,
                      categoryTapCallback: (CategoryItem item) {
                        onCategoryTap(item);
                      },
                    );
                  }).toList(),
                ),
              ),
              const SizedBox(
                height: 16,
              ),
              Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8),
                  child: CustomTextFieldWidget(
                    controller: _amountEditingController,
                    isEnabled: currentCategoryItem != null,
                    onBackspace: onBackButtonTap,
                    onChanged: (value) {
                      if (value.isEmpty) return;
                      currentCategoryItem?.amount = int.parse(value);
                      setState(() {});
                    },
                  )),
              const SizedBox(
                height: 16,
              ),
              GridView.count(
                crossAxisCount: 3,
                shrinkWrap: true,
                childAspectRatio: 2,
                children: List.generate(
                  11,
                  (index) {
                    index = index + 1;

                    ///Info: To place the last item in the center
                    if (index == 10) {
                      return const SizedBox();
                    }
                    ///Info: To Place the zero at the last
                    if (index == 11) {
                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: numberButtonWidget(0),
                      );
                    }
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: numberButtonWidget(index),
                    );
                  },
                ),
              ),
          const Spacer(),
              Padding(
                padding: const EdgeInsets.only(bottom: 16),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    ElevatedButton(
                        onPressed: resetData,
                        child: const Text(StringConstant.reset)),
                    ElevatedButton(
                        onPressed: () {},
                        child: const Text(StringConstant.save)),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  ElevatedButton numberButtonWidget(int index) {
    return ElevatedButton(
        onPressed: currentCategoryItem != null
            ? () {
                onNumberTap(index);
              }
            : null,
        child: Text(index.toString()));
  }

  ///-------------------Functionalities Methods---------------------------------

  void onCategoryTap(CategoryItem item) {
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
  }

  void onNumberTap(int index) {
    if (_amountEditingController.text == '0') {
      _amountEditingController.clear();
    }
    _amountEditingController.text += index.toString();
    currentCategoryItem?.amount = int.parse(_amountEditingController.text);

    totalAmount = 0;
    totalAmount = CreateExpenseUtil.calculateTotalAmount(itemMap);
    setState(() {});
    setCursorPosition();
  }

  onBackButtonTap() {
    setState(() {
      currentCategoryItem?.amount = _amountEditingController.text.isNotEmpty
          ? int.parse(_amountEditingController.text)
          : 0;
      totalAmount = 0;
      totalAmount = CreateExpenseUtil.calculateTotalAmount(itemMap);
    });
  }

  void resetData() {
    setState(() {
      _amountEditingController.clear();
      totalAmount = 0;
      currentCategoryItem = null;
      itemMap.forEach((key, value) {
        value.amount = 0;
        value.isSelected = false;
      });
    });
  }

  void setCursorPosition() {
    _amountEditingController.selection =
        TextSelection.fromPosition(TextPosition(
      offset: _amountEditingController.text.length,
    ));
  }
}

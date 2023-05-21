import 'package:flutter/material.dart';

class CustomTextFieldWidget extends StatefulWidget {
  final TextEditingController controller;
  final bool isEnabled;
  final ValueChanged<String>? onChanged;
  final Function? onBackspace;

  const CustomTextFieldWidget({
    required this.controller,
    this.isEnabled = true,
    this.onChanged,
    this.onBackspace,
    Key? key,
  }) : super(key: key);

  @override
  State<CustomTextFieldWidget> createState() => _CustomTextFieldWidgetState();
}

class _CustomTextFieldWidgetState extends State<CustomTextFieldWidget> {
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: widget.controller,
      onChanged: widget.onChanged,
      readOnly: true,
      showCursor: true,
      enabled: widget.isEnabled,
      keyboardType: TextInputType.number,
      //style: const TextStyle(),
      decoration: InputDecoration(
        hintText: "Enter amount",
        suffixIcon: GestureDetector(
            child: const Icon(Icons.arrow_back),
            onLongPress: () {
              widget.controller.clear();
            },
            onTap: () {
              removeValueOneByOne();
              if (widget.onBackspace != null) {
                widget.onBackspace!();
              }
              //_amountEditingController.clear();
            }),
      ),
    );
  }

  void removeValueOneByOne() {
    int cursorPosition = widget.controller.selection.baseOffset;
    if (cursorPosition > 0) {
      // If the cursor is not at the beginning of the text, remove the character before it
      widget.controller.text =
          widget.controller.text.substring(0, cursorPosition - 1) +
              widget.controller.text.substring(cursorPosition);
      setCursorPosition();
    }
  }

  void setCursorPosition() {
    widget.controller.selection = TextSelection.fromPosition(TextPosition(
      offset: widget.controller.text.length,
    ));
  }
}

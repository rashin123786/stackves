import 'package:flutter/material.dart';

class TextFieldWidget extends StatelessWidget {
  const TextFieldWidget({
    super.key,
    required this.widget,
    required this.textEditingController,
    required this.validator,
    required this.keyboardType,
    this.label,
  });
  final Widget widget;
  final TextEditingController textEditingController;
  final String? Function(String?) validator;
  final TextInputType keyboardType;
  final String? label;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          CircleAvatar(
            child: widget,
          ),
          const SizedBox(
            width: 10,
          ),
          Expanded(
            child: TextFormField(
              keyboardType: keyboardType,
              validator: validator,
              controller: textEditingController,
              decoration: InputDecoration(
                  border: const OutlineInputBorder(), labelText: label),
            ),
          )
        ],
      ),
    );
  }
}

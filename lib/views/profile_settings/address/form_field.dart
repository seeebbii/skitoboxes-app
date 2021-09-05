import 'package:flutter/material.dart';

class formField extends StatelessWidget {
  formField({
    Key? key,
    required this.controller,
    this.inputType,
    required this.hintText,
    required this.title,
  }) : super(key: key);

  final TextEditingController? controller;
  final TextInputType? inputType;
  final String? hintText;
  final String? title;

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        child: TextFormField(
          controller: controller,
          keyboardType: inputType ?? TextInputType.text,
          style: Theme.of(context).textTheme.bodyText1,
          decoration: InputDecoration(
            hintText: hintText,
            hintStyle: Theme.of(context)
                .textTheme
                .bodyText1!
                .copyWith(fontSize: 14, color: Colors.grey.shade500),
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.grey),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.black, width: 1.5),
            ),
            labelText: title,
            labelStyle: Theme.of(context).textTheme.bodyText1,
          ),
          validator: (value) {
            if (value!.isEmpty && title != 'ZipCode') {
              return 'This field can\'t be empty';
            }
          },
        ));
  }
}

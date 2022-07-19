import 'package:flutter/material.dart';
class FormText extends StatelessWidget {
  final String textLabel;
  final TextEditingController controller;
  final ValueChanged<String?> method;
  final bool isEnabled;
  final bool? emptyField;
  final int? keyForm;

  const FormText({
    Key? key,
    required this.textLabel,
    required this.controller,
    required this.method,
    required this.isEnabled,
    this.emptyField = false,
    this.keyForm,
  }) : super(key: key);

  String? get _errorText {
    // at any time, we can get the text from _controller.value.text
    final text = controller.value.text;
    // Note: you can do your own custom validation here
    // Move this logic this outside the widget for more testable code
    if (text.isEmpty) {
      return "$textLabel tidak boleh kosong";
    }
    // return null if the text is valid
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return TextField(
      autofocus: false,
      controller: controller,
      onChanged: method,
      readOnly: isEnabled,
      enableInteractiveSelection: true,
      decoration: InputDecoration(
          border: const OutlineInputBorder(),
          labelText: textLabel,
          errorText: emptyField == true && controller.hashCode == keyForm ? "$textLabel tidak boleh kosong" : null,
          labelStyle: const TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.bold
          )
      ),
    );
  }
}
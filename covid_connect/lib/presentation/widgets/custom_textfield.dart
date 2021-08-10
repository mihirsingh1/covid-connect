import 'package:flutter/material.dart';

class CustomTextField extends StatefulWidget {
  final TextEditingController controller;
  final String hint;
  final TextInputType inputType;
  final bool autoFocus;

  const CustomTextField(this.hint, this.controller,
      {this.inputType = TextInputType.text, this.autoFocus = false});

  @override
  _CustomTextFieldState createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  bool _isEmpty = false;

  @override
  void initState() {
    super.initState();

    _isEmpty = widget.controller.text == "";
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Material(
        borderRadius: BorderRadius.circular(10.0),
        child: TextField(
          controller: widget.controller,
          onChanged: (v) {
            setState(() {
              _isEmpty = (v == "");
            });
          },
          autofocus: widget.autoFocus,
          style: TextStyle(fontSize: 14.0),
          keyboardType: widget.inputType,
          decoration: InputDecoration(
            filled: true,
            hintText: widget.hint,
            labelText: _isEmpty ? null : widget.hint,
            hintStyle: TextStyle(color: Colors.grey),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(6.0),
              borderSide: BorderSide(color: Colors.grey.shade200, width: 1),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(6.0),
            ),
          ),
        ),
      ),
    );
  }
}


import 'package:flutter/material.dart';

class CustomLoginTextField extends StatelessWidget {
  const CustomLoginTextField({
    Key? key,
    required TextEditingController controller,
    required String hint,
    TextInputType keyboardType = TextInputType.name,
    bool isSecurity = false,
    bool autoFocus = false,
  }) : _controller = controller, 
      _hint = hint,
      _keyboardType = keyboardType,
      _isSecurity = isSecurity,
      _autoFocus = autoFocus,
      super(key: key);

  final TextEditingController _controller;
  final String _hint;
  final TextInputType _keyboardType;
  final bool _isSecurity;
  final bool _autoFocus;

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: _controller,
      obscureText: _isSecurity,
      autofocus: _autoFocus,
      keyboardType: _keyboardType,
      textInputAction: TextInputAction.next,
      cursorColor: Colors.black,
      decoration: InputDecoration(
        contentPadding: const EdgeInsets.fromLTRB(32, 20, 20, 16),
        border: const OutlineInputBorder( borderRadius: BorderRadius.all(Radius.circular(32)) ),
        filled: true,
        fillColor: Colors.white,
        hintText: _hint,
        hintStyle: const TextStyle(color: Colors.grey, fontSize: 14),
        floatingLabelBehavior: FloatingLabelBehavior.never
      ),
    );
  }
}
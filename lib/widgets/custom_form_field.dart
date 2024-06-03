import 'package:flutter/material.dart';

class CustomFormField extends StatefulWidget {
  final String hintText;
  final IconData icon;
  final double height;
  final RegExp validationRegEx;
  final bool obscureText;
  final String labelText;
  final void Function(String?) onSaved;

  const CustomFormField({
    this.obscureText = false,
    super.key,
    required this.height,
    required this.hintText,
    required this.icon,
    required this.onSaved,
    required this.validationRegEx,
    required this.labelText,
  });

  @override
  State<CustomFormField> createState() {
    return _CustomFormFieldState();
  }
}

class _CustomFormFieldState extends State<CustomFormField> {
  bool hidden = true;

  @override
  void initState() {
    hidden = widget.obscureText;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: widget.height,
      child: TextFormField(
        onSaved: widget.onSaved,
        obscureText: hidden,
        validator: (value) {
          if (value != null && widget.validationRegEx.hasMatch(value)) {
            return null;
          }
          return "Enter a valid ${widget.hintText.toLowerCase()}";
        },
        decoration: InputDecoration(
          labelText: widget.labelText,
          suffixIcon: widget.icon == Icons.remove_red_eye_rounded
              ? IconButton(
                  onPressed: () {
                    setState(() {
                      hidden = !hidden;
                    });
                  },
                  icon: Icon(
                    hidden ? Icons.visibility_off : Icons.visibility,
                  ),
                )
              : Icon(widget.icon),
          hintText: widget.hintText,
        ),
      ),
    );
  }
}

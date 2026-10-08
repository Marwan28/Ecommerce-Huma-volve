import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  final String hintText;
  bool obscureText;
  final IconData prefixIcon;
  final bool isPasswordField;
  final VoidCallback? onSuffixIconPressed;
  final TextEditingController? controller;
  final String? Function(String?)? validator;

  CustomTextField({
    super.key,
    required this.hintText,
    this.obscureText = false,
    required this.prefixIcon,
    this.onSuffixIconPressed,
    this.isPasswordField = false,
    this.controller,
    this.validator,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withValues(alpha: 0.05),
            spreadRadius: 2,
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: TextFormField(
        obscureText: obscureText,
        controller: controller,
        validator: validator,
        decoration: InputDecoration(
          hintText: hintText,
          hintStyle: TextStyle(color: Colors.grey.shade400),
          prefixIcon: Icon(prefixIcon, color: Colors.grey.shade600),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16),
            borderSide: BorderSide.none,
          ),
          suffixIcon: isPasswordField
              ? IconButton(
                  onPressed: onSuffixIconPressed,
                  icon: obscureText
                      ? Icon(
                          Icons.visibility_outlined,
                          color: Colors.grey.shade600,
                        )
                      : Icon(
                          Icons.visibility_off_outlined,
                          color: Colors.grey.shade600,
                        ),
                )
              : null,
          filled: true,
          fillColor: Colors.transparent,
          contentPadding: const EdgeInsets.symmetric(vertical: 20),
        ),
      ),
    );
  }
}

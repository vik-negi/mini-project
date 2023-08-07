import 'package:evika/utils/constants.dart';
import 'package:flutter/material.dart';

class TextFormFieldContaier extends StatelessWidget {
  final TextEditingController controller;
  final double width;
  final Widget label;
  final Widget? suffixIcon;
  final String? errorText;
  final String hintText;
  final bool obscure;
  final Function(String)? onChanged;
  const TextFormFieldContaier({
    super.key,
    required this.controller,
    required this.width,
    required this.label,
    this.suffixIcon,
    this.errorText,
    required this.hintText,
    required this.obscure,
    this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment:
          width < 300 ? CrossAxisAlignment.center : CrossAxisAlignment.start,
      children: [
        label,
        Container(
          width: width < Constants.mwidth ? 280 : 300,
          margin: const EdgeInsets.symmetric(horizontal: 20),
          child: TextField(
            controller: controller,
            obscureText: obscure,
            onChanged: onChanged,
            decoration: InputDecoration(
              suffixIcon: suffixIcon,
              hintText: hintText,
              errorText: errorText,
              hintStyle: const TextStyle(
                fontSize: 14,
                fontFamily: 'Poppins',
                fontWeight: FontWeight.w500,
              ),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(50),
                borderSide: const BorderSide(
                  color: Color.fromRGBO(0, 0, 0, 1),
                ),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(50),
                borderSide: const BorderSide(
                  color: Color.fromRGBO(0, 0, 0, 1),
                ),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(50),
                borderSide: const BorderSide(
                  color: Color.fromRGBO(0, 0, 0, 1),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

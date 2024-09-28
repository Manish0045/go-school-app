import 'package:flutter/material.dart';
import 'package:go_school_application/constants/constant_colors.dart';

class RoundedInput extends StatelessWidget {
  final String hintText;
  final Icon? prefixIcon;
  final Icon? suffixIcon;
  final String? labelText;
  final TextEditingController controller;
  final bool isPassword;
  final ValueChanged<String>? onChanged;
  final FormFieldValidator<String>? validator;

  const RoundedInput({
    super.key,
    required this.controller,
    this.isPassword = false,
    required this.hintText,
    this.prefixIcon,
    this.suffixIcon,
    this.labelText,
    this.onChanged,
    this.validator,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 600,
      padding: const EdgeInsets.symmetric(vertical: 5.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(25.0),
      ),
      child: TextFormField(
        obscureText: isPassword,
        style: const TextStyle(
          fontSize: 16.0,
          color: textColor,
        ),
        decoration: InputDecoration(
          contentPadding:
              const EdgeInsets.symmetric(horizontal: 16.0, vertical: 14.0),
          hintText: hintText,
          hintStyle: const TextStyle(color: Colors.grey),
          prefixIcon: prefixIcon,
          labelText: labelText,
          suffixIcon: suffixIcon != null
              ? IconButton(
                  onPressed: () {
                    onChanged?.call(controller.text);
                  },
                  icon: suffixIcon!,
                )
              : null,
          labelStyle: const TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.amber,
          ),
          filled: true,
          fillColor: Colors.black,
          enabledBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: Colors.grey),
            borderRadius: BorderRadius.circular(25.0),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: Colors.amber, width: 2.0),
            borderRadius: BorderRadius.circular(25.0),
          ),
        ),
        controller: controller,
        onChanged: onChanged,
        validator: validator,
      ),
    );
  }
}

class RoundedButton extends StatelessWidget {
  final String buttonText;
  final VoidCallback onPressed;
  final Color color; // Added color parameter

  const RoundedButton({
    super.key,
    required this.buttonText,
    required this.onPressed,
    this.color = Colors.amber, // Default color
  });

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      height: 25.0,
      minWidth: 600,
      color: color, // Use the provided color
      padding: const EdgeInsets.symmetric(vertical: 15.0),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20.0),
      ),
      onPressed: onPressed,
      child: Text(buttonText),
    );
  }
}

class MyAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;

  const MyAppBar({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      automaticallyImplyLeading: false,
      centerTitle: true,
      title: Text(
        title,
        style: const TextStyle(
          fontWeight: FontWeight.bold,
          color: scaffoldColor,
        ),
      ),
    );
  }

  @override
  Size get preferredSize =>
      const Size.fromHeight(kToolbarHeight); // Set the height of the AppBar
}

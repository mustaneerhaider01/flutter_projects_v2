import 'package:fastify_app/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class InputFormField extends StatelessWidget {
  final String hintText;
  final bool obscureText;
  final String assetPath;
  final TextInputType keyboardType;
  final String? Function(String?)? validator;
  final void Function(String?)? onSaved;

  const InputFormField({
    super.key,
    required this.hintText,
    required this.assetPath,
    this.keyboardType = TextInputType.text,
    this.obscureText = false,
    this.validator,
    this.onSaved,
  });

  OutlineInputBorder getOutlineInputBorder(Color color) {
    return OutlineInputBorder(
      borderSide: BorderSide(
        width: 1,
        color: color,
      ),
      borderRadius: BorderRadius.circular(14),
    );
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      cursorColor: kPrimaryColor,
      decoration: InputDecoration(
        hintText: hintText,
        hintStyle: TextStyle(
          fontSize: 12,
          color: const Color(0xFF1B1A57).withOpacity(0.18),
        ),
        enabledBorder: getOutlineInputBorder(kPrimaryColor.withOpacity(0.18)),
        focusedBorder: getOutlineInputBorder(kPrimaryColor.withOpacity(0.18)),
        errorBorder: getOutlineInputBorder(Theme.of(context).colorScheme.error),
        focusedErrorBorder: getOutlineInputBorder(
          Theme.of(context).colorScheme.error,
        ),
        suffixIcon: Padding(
          padding: const EdgeInsets.all(10),
          child: SvgPicture.asset(assetPath),
        ),
      ),
      obscureText: obscureText,
      keyboardType: keyboardType,
      validator: validator,
      onSaved: onSaved,
    );
  }
}

import 'package:fastify_app/utils/constants.dart';
import 'package:flutter/material.dart';

class PrimaryButton extends StatelessWidget {
  final String title;
  final VoidCallback onPressed;

  const PrimaryButton({
    super.key,
    required this.title,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      borderRadius: BorderRadius.circular(14),
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 8),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(14),
          color: kPrimaryColor,
        ),
        child: Text(
          title,
          textAlign: TextAlign.center,
          style: const TextStyle(color: Colors.white, fontSize: 14),
        ),
      ),
    );
  }
}

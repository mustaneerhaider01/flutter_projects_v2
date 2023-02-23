import 'package:flutter/material.dart';

class Answer extends StatelessWidget {
  final String title;
  final VoidCallback selectHandler;

  const Answer(this.selectHandler, this.title, {super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: selectHandler,
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.deepPurple,
          foregroundColor: Colors.white,
        ),
        child: Text(title),
      ),
    );
  }
}

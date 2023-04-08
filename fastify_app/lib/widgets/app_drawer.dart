import 'package:flutter/material.dart';

class AppDrawer extends StatelessWidget {
  const AppDrawer({super.key});

  Widget buildListTile(String title, IconData icon, VoidCallback onPressed) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(
          width: 1,
          color: Colors.grey.shade300,
        ),
        borderRadius: BorderRadius.circular(10),
      ),
      child: ListTile(
        onTap: onPressed,
        title: Text(title),
        trailing: Icon(icon),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(
            vertical: 20,
            horizontal: 10,
          ),
          child: Column(
            children: [
              buildListTile(
                'Start New Chat',
                Icons.add,
                () {},
              ),
            ],
          ),
        ),
      ),
    );
  }
}

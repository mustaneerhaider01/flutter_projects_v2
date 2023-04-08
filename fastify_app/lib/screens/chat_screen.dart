import 'package:fastify_app/providers/auth.dart';
import 'package:fastify_app/widgets/app_drawer.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ChatScreen extends StatelessWidget {
  static const routeName = '/chat';

  const ChatScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final userData = Provider.of<Auth>(context).user;
    print('Rebuild.... ${userData?.name}');
    return Scaffold(
      appBar: AppBar(
        title: const Text('Chat AI'),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.add),
            tooltip: 'Start New Chat',
          ),
        ],
      ),
      drawer: const AppDrawer(),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (userData?.image != null)
              ClipOval(
                child: SizedBox(
                  width: 150,
                  height: 150,
                  child: Image.network(
                    userData!.image!,
                    width: double.infinity,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            Text(userData?.name ?? 'Unknown'),
            InkWell(
              onTap: () => Provider.of<Auth>(context, listen: false).logout(),
              child: const Text('Logout'),
            )
          ],
        ),
      ),
    );
  }
}

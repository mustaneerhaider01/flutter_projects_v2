import 'package:fastify_app/models/user.dart';
import 'package:fastify_app/providers/auth.dart';
import 'package:fastify_app/screens/auth_screen.dart';
import 'package:fastify_app/screens/chat_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Wrapper extends StatelessWidget {
  const Wrapper({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (ctx, streamSnapshot) {
        if (streamSnapshot.connectionState == ConnectionState.waiting) {
          return const Center(
            child: CircularProgressIndicator.adaptive(),
          );
        } else if (streamSnapshot.hasError) {
          return Center(
            child: Text(
              'An Error occured!',
              style: TextStyle(
                color: Theme.of(context).colorScheme.error,
                fontSize: 22,
              ),
            ),
          );
        } else if (streamSnapshot.hasData) {
          Provider.of<Auth>(context, listen: false).setAppUser(
            AppUser(
              uid: streamSnapshot.data!.uid,
              email: streamSnapshot.data!.email!,
              name: streamSnapshot.data!.displayName,
              image: streamSnapshot.data!.photoURL,
            ),
          );
          return const ChatScreen();
        }
        return const AuthScreen();
      },
    );
  }
}

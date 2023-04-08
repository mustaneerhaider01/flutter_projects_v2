import 'package:fastify_app/providers/auth.dart';
import 'package:fastify_app/utils/constants.dart';
import 'package:fastify_app/widgets/auth_form.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

class AuthScreen extends StatelessWidget {
  static const routeName = '/auth';

  const AuthScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.only(top: 40, left: 15, right: 15),
            child: SizedBox(
              width: double.infinity,
              child: Column(
                children: [
                  const AuthForm(),
                  const SizedBox(
                    height: 20,
                  ),
                  Row(
                    children: const [
                      Expanded(
                        child: Divider(),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 8),
                        child: Text('or'),
                      ),
                      Expanded(
                        child: Divider(),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  const GoogleButton(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class GoogleButton extends StatelessWidget {
  const GoogleButton({super.key});

  void googleSignIn(BuildContext ctx) {
    try {
      Provider.of<Auth>(ctx, listen: false).signInWithGoogle();
    } on PlatformException catch (error) {
      print(error);
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => googleSignIn(context),
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(
            width: 1,
            color: kPrimaryColor.withOpacity(0.22),
          ),
          borderRadius: BorderRadius.circular(14),
        ),
        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 10),
        child: Row(
          children: [
            Image.asset(
              'assets/images/google.png',
              width: 30,
              height: 30,
              fit: BoxFit.contain,
            ),
            const SizedBox(
              width: 10,
            ),
            const Text('Continue with Google'),
          ],
        ),
      ),
    );
  }
}

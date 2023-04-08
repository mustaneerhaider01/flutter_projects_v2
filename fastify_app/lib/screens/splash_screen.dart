import 'dart:async';

import 'package:fastify_app/screens/wrapper.dart';
import 'package:fastify_app/utils/constants.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    _navigateToMain();
    super.initState();
  }

  void _navigateToMain() async {
    Timer(
      const Duration(milliseconds: 2000),
      () {
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(
            builder: (ctx) => const Wrapper(),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.lightBlue[100],
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              'assets/images/logo.png',
              width: 110,
              height: 110,
              fit: BoxFit.cover,
            ),
            const SizedBox(
              height: 10,
            ),
            const Text(
              'Chat AI',
              style: TextStyle(
                fontFamily: 'Josefin Sans',
                fontSize: 30,
                color: kPrimaryColor,
              ),
            )
          ],
        ),
      ),
    );
  }
}

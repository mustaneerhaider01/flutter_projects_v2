import 'package:fastify_app/firebase_options.dart';
import 'package:fastify_app/providers/auth.dart';
import 'package:fastify_app/screens/auth_screen.dart';
import 'package:fastify_app/screens/chat_screen.dart';
import 'package:fastify_app/screens/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (ctx) => Auth(),
      child: MaterialApp(
        title: 'Chat AI',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          fontFamily: 'Poppins',
          scaffoldBackgroundColor: Colors.white,
          appBarTheme: const AppBarTheme(
            titleTextStyle: TextStyle(fontSize: 20, fontFamily: 'Josefin Sans'),
            elevation: 0,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(14),
              bottomRight: Radius.circular(14),
            )),
          ),
        ),
        home: const SplashScreen(),
        routes: {
          ChatScreen.routeName: (ctx) => const ChatScreen(),
          AuthScreen.routeName: (ctx) => const AuthScreen(),
        },
      ),
    );
  }
}

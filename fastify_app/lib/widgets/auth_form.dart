import 'dart:io';

import 'package:fastify_app/providers/auth.dart';
import 'package:fastify_app/utils/constants.dart';
import 'package:fastify_app/utils/helpers.dart';
import 'package:fastify_app/widgets/image_input.dart';
import 'package:fastify_app/widgets/input_form_field.dart';
import 'package:fastify_app/widgets/primary_button.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

enum AuthMode { login, signup }

class AuthForm extends StatefulWidget {
  const AuthForm({super.key});

  @override
  State<AuthForm> createState() => _AuthFormState();
}

class _AuthFormState extends State<AuthForm> {
  var _authMode = AuthMode.signup;
  final _form = GlobalKey<FormState>();
  final _authData = {
    'userName': '',
    'email': '',
    'password': '',
  };
  var _isAuthenticating = false;
  String? _selectedImage;

  void _switchAuthMode() {
    setState(() {
      if (_authMode == AuthMode.login) {
        _authMode = AuthMode.signup;
      } else {
        _authMode = AuthMode.login;
      }
    });
  }

  void _showErrorDialog(String message) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text(
          'An Error Occured!',
        ),
        content: Text(message),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(ctx).pop();
            },
            child: const Text('Okay'),
          ),
        ],
      ),
    );
  }

  Future<void> _submitForm() async {
    if (!_form.currentState!.validate()) return;
    _form.currentState!.save();

    setState(() {
      _isAuthenticating = true;
    });
    try {
      if (_authMode == AuthMode.signup) {
        await Provider.of<Auth>(context, listen: false).signUp(
          username: _authData['userName']!,
          email: _authData['email']!,
          password: _authData['password']!,
          pickedImage: _selectedImage,
        );
      } else {
        await Provider.of<Auth>(context, listen: false).login(
          email: _authData['email']!,
          password: _authData['password']!,
        );
      }
    } on FirebaseAuthException catch (error) {
      var errorMessage = '';
      if (error.code == 'email-already-in-use') {
        errorMessage = 'This email is already in use';
      } else if (error.code == 'invalid-email') {
        errorMessage = 'This is not a valid email address';
      } else if (error.code == 'weak-password') {
        errorMessage = 'This password is took weak';
      } else if (error.code == 'user-not-found') {
        errorMessage = 'Could not find a user with this email';
      } else if (error.code == 'wrong-password') {
        errorMessage = 'Invalid password';
      }
      _showErrorDialog(errorMessage);
    } catch (error) {
      var errorMessage = 'Could not authenticated you. Please try again later!';
      _showErrorDialog(errorMessage);
    }
    setState(() {
      _isAuthenticating = false;
    });
  }

  Future<void> selectImage(File pickedImage) async {
    final pickedImageUrl = await Helpers.uploadFile(pickedImage);
    setState(() {
      _selectedImage = pickedImageUrl;
    });
  }

  Widget buildLoginTop() {
    return Column(
      children: [
        Container(
          width: 130,
          height: 130,
          margin: const EdgeInsets.only(bottom: 10),
          child: Image.asset(
            'assets/images/logo.png',
            fit: BoxFit.cover,
            width: double.infinity,
          ),
        ),
        const Text(
          'Chat AI',
          style: TextStyle(
            fontFamily: 'Josefin Sans',
            fontSize: 30,
            color: kPrimaryColor,
          ),
        ),
        const SizedBox(
          height: 50,
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        if (_authMode == AuthMode.signup)
          Padding(
            padding: const EdgeInsets.only(bottom: 60),
            child: ImageInput(selectImage),
          ),
        if (_authMode == AuthMode.login) buildLoginTop(),
        Form(
          key: _form,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              if (_authMode == AuthMode.signup)
                Padding(
                  padding: const EdgeInsets.only(bottom: 20),
                  child: InputFormField(
                    hintText: 'Enter User Name',
                    assetPath: 'assets/icons/user.svg',
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'User Name is a requried field';
                      }
                      return null;
                    },
                    onSaved: (value) {
                      _authData['userName'] = value!;
                    },
                  ),
                ),
              InputFormField(
                hintText: 'Enter E-mail Address',
                assetPath: 'assets/icons/mail.svg',
                keyboardType: TextInputType.emailAddress,
                validator: (value) {
                  if (value!.isEmpty || !value.contains('@')) {
                    return 'Invalid email';
                  }
                  return null;
                },
                onSaved: (value) {
                  _authData['email'] = value!;
                },
              ),
              const SizedBox(
                height: 20,
              ),
              InputFormField(
                hintText: 'Enter Password',
                assetPath: 'assets/icons/eye.svg',
                obscureText: true,
                validator: (value) {
                  if (value!.isEmpty || value.length < 6) {
                    return 'Password must be atleast 6 characters long';
                  }
                  return null;
                },
                onSaved: (value) {
                  _authData['password'] = value!;
                },
              ),
              const SizedBox(
                height: 50,
              ),
              _isAuthenticating
                  ? Container(
                      alignment: Alignment.center,
                      child: const CircularProgressIndicator.adaptive(),
                    )
                  : PrimaryButton(
                      onPressed: _submitForm,
                      title:
                          _authMode == AuthMode.signup ? "Sign Up" : "Log In",
                    ),
            ],
          ),
        ),
        const SizedBox(
          height: 20,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              _authMode == AuthMode.signup
                  ? "Already have an account?"
                  : "Dont't have an account?",
            ),
            TextButton(
              onPressed: _switchAuthMode,
              style: TextButton.styleFrom(
                tapTargetSize: MaterialTapTargetSize.shrinkWrap,
              ),
              child: Text(
                _authMode == AuthMode.login ? 'Sign up' : 'Log in',
              ),
            ),
          ],
        ),
      ],
    );
  }
}

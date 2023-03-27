import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flash_chat_new/initialize_firebase.dart';
import 'package:flash_chat_new/screens/chat_screen.dart';
import 'package:flash_chat_new/components/flash_chat_button.dart';
import 'package:flash_chat_new/components/constants.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

class LoginScreen extends StatefulWidget {

  static const id = 'login';

  const LoginScreen({super.key});

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: ModalProgressHUD(
        inAsyncCall: isLoading,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Flexible(
                child: Hero(
                  tag: 'logo_hero_tag',
                  child: Container(
                    height: 200.0,
                    child: Image.asset('images/logo.png'),
                  ),
                ),
              ),
              const SizedBox(
                height: 48.0,
              ),
              TextField(
                keyboardType: TextInputType.emailAddress,
                textAlign: TextAlign.center,
                onChanged: (value) {
                  email = value;
                },
                decoration: kInputDecoration.copyWith(hintText: 'Enter your email'),
              ),
              const SizedBox(
                height: 8.0,
              ),
              TextField(
                textAlign: TextAlign.center,
                obscureText: true,
                onChanged: (value) {
                  password = value;
                },
                decoration: kInputDecoration.copyWith(hintText: 'Enter your password'),
              ),
              const SizedBox(
                height: 24.0,
              ),
              FlashChatButton(
                title: 'Log In', 
                onTap: () {
                  logIn();
                },
                color: Colors.lightBlueAccent
              )
            ],
          ),
        ),
      ),
    );
  }

  bool isLoading = false;

  logIn() async {
    setState(() { isLoading = true; });

    try {
      await ensureFirebaseIsInitialized();

      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email, 
        password: password
      );

      setState(() { isLoading = false; });

      Navigator.pushNamed(context, ChatScreen.id);
    } catch (exception) {
      setState(() { isLoading = false; });
      print(exception);
    }
  }

  String email = '';
  String password = '';
}

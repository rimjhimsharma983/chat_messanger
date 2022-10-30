import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../utility/components.dart';
import '../utility/constants.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  String _email = '';
  String _password = '';
  final _auth = FirebaseAuth.instance;
  final _fireStore = FirebaseFirestore.instance;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Flexible(
              child: Hero(
                tag: 'logo',
                child: Container(
                    height: 120, child: Image.asset('asset/logo.png')),
              ),
            ),
            TextEntry(
              onChanged: (val) {
                setState(() {
                  _email = val;
                });
              },
              icon: Icons.email,
              hintText: 'Enter your email here',
              keyboardType: TextInputType.emailAddress,
            ),
            TextEntry(
              onChanged: (val) {
                setState(() {
                  _password = val;
                });
              },
              icon: Icons.key,
              hintText: 'Enter your password here',
              keyboardType: TextInputType.visiblePassword,
            ),
            ButtonRound(
              onPressed: () async {
                try {
                  final newUser = await _auth.signInWithEmailAndPassword(
                    email: _email,
                    password: _password,
                  );
                  if (newUser != null) {
                    // ignore: use_build_context_synchronously
                    Navigator.pushNamed(context, Routetable.selectchat);
                  }
                } catch (err) {
                  debugPrint(err.toString());
                }
              },
              title: 'Login',
              color: AppColors.primarycolor,
            ),
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text('Not registered?'),
              style: ButtonStyle(
                overlayColor: MaterialStateProperty.all(
                  Colors.transparent,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

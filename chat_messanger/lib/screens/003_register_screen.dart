import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:chat_messanger/utility/components.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';

import '../utility/constants.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
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
              obscureText: true,
              keyboardType: TextInputType.visiblePassword,
            ),
            ButtonRound(
              onPressed: () async {
                debugPrint(_email);
                debugPrint(_password);
                try {
                  final newUser = await _auth.createUserWithEmailAndPassword(
                    email: _email,
                    password: _password,
                  );
                  if (newUser != null) {
                    _fireStore.collection('chatusers').add({
                      'email': _email,
                      'username': '',
                    });
                    // ignore: use_build_context_synchronously
                    Navigator.pushNamed(context, Routetable.selectchat);
                  }
                } catch (err) {
                  debugPrint(err.toString());
                }
              },
              title: 'Register',
              color: AppColors.primarycolor,
            ),
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text('Already registered?'),
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

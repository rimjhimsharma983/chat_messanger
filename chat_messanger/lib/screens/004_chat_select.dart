import 'package:chat_messanger/utility/components.dart';
import 'package:chat_messanger/utility/constants.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'dart:math';

class SelectChatScreen extends StatefulWidget {
  const SelectChatScreen({Key? key}) : super(key: key);

  @override
  State<SelectChatScreen> createState() => _SelectChatState();
}

class _SelectChatState extends State<SelectChatScreen> {
  List<String> users = [];
  int currentIndex = 0;
  final _auth = FirebaseAuth.instance;
  late User currentUser;
  List allUsers = [];
  final _fireStore = FirebaseFirestore.instance;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getCurrentUser();
  }

  void getCurrentUser() async {
    try {
      final user = _auth.currentUser;
      if (user != null) {
        var data =
            await _fireStore.collection('chatusers').orderBy('email').get();

        setState(() {
          currentUser = user;

          for (var d in data.docs) {
            users.add(d.data()['email']);
          }
        });
      }
    } catch (err) {
      debugPrint(err.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        onTap: (ind) {
          if (ind != currentIndex) {
            if (ind == 0) {
              Navigator.pushNamed(context, Routetable.selectchat);
            } else if (ind == 1) {
              Navigator.pushNamed(context, Routetable.UserProfile);
            }
          }
        },
        selectedItemColor: Colors.black,
        currentIndex: currentIndex,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(icon: Icon(Icons.home), label: "home"),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: "profile"),
        ],
      ),
      appBar: AppBar(
        actions: [
          IconButton(
            onPressed: () {
              _auth.signOut();
              Navigator.pushNamedAndRemoveUntil(
                context,
                Routetable.welcome,
                (route) => false,
              );
            },
            icon: Icon(Icons.logout),
          ),
        ],
        elevation: 10,
        leading: SizedBox(),
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(
          bottom: Radius.circular(30),
        )),
        backgroundColor: AppColors.primarycolor,
        title: const Text(
          'LETS TALK',
          style: TextStyle(
            color: Colors.white,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            for (String username in users)
              ChatCard(
                username: username,
                onTap: () {
                  Navigator.pushNamed(
                    context,
                    Routetable.chat,
                    arguments: {'receiver': username},
                  );
                },
              ),
          ],
        ),
      ),
    );
  }
}

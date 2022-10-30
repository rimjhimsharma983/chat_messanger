import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:chat_messanger/utility/constants.dart';
import 'package:flutter/material.dart';

import '../utility/components.dart';

class UserProfile extends StatefulWidget {
  const UserProfile({Key? key}) : super(key: key);

  @override
  State<UserProfile> createState() => _UserProfileState();
}

class _UserProfileState extends State<UserProfile> {
  int currentIndex = 1;
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
        elevation: 10,
        leading: SizedBox(),
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(
          bottom: Radius.circular(30),
        )),
        backgroundColor: AppColors.primarycolor,
        title: const Text(
          'User Profile',
          style: TextStyle(
            color: Colors.white,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: 80,
            ),
            Center(
              child: CircleAvatar(
                radius: 110,
                backgroundColor: Color.fromARGB(255, 238, 84, 73),
                child: CircleAvatar(
                  backgroundImage: AssetImage('asset/profile_pic.jpg'),
                  radius: 80,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(
                vertical: 40,
              ),
              child: Container(
                color: Colors.red,
                height: 50,
                width: 250,
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 40,
                    vertical: 10,
                  ),
                  child: Text(
                    'Rimjhim Sharma',
                    style: TextStyle(
                      fontSize: 20,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ),
            // Padding(
            //   padding: const EdgeInsets.symmetric(vertical: 20),
            //   child: Padding(
            //     padding: const EdgeInsets.symmetric(horizontal: 50),
            //     child: ChatCard(
            //       username: 'Rimjhim sharma',
            //       onTap: () {},
            //     ),
            //   ),
            // ),
          ],
        ),
      ),
    );
  }
}

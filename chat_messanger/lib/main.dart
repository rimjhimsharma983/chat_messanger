import 'package:chat_messanger/screens/001_welcome_screen.dart';
import 'package:chat_messanger/screens/002_login_screen.dart';
import 'package:chat_messanger/screens/003_register_screen.dart';
import 'package:chat_messanger/screens/004_chat_select.dart';
import 'package:chat_messanger/screens/005_chats.dart';
import 'package:chat_messanger/screens/User%20_Profile_Screen.dart';
import 'package:chat_messanger/utility/constants.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        initialRoute: Routetable.welcome,
        debugShowCheckedModeBanner: false,
        routes: {
          Routetable.welcome: (context) => WelcomeScreen(),
          Routetable.register: (context) => RegisterScreen(),
          Routetable.login: (context) => LoginScreen(),
          Routetable.selectchat: (context) => SelectChatScreen(),
          Routetable.chat: (context) => ChatScreen(),
          Routetable.UserProfile: (context) => UserProfile(),
        });
  }
}

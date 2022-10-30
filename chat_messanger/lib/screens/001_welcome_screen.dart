import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:chat_messanger/utility/components.dart';
import 'package:chat_messanger/utility/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';

class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({Key? key}) : super(key: key);

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController controller;
  late Animation animation;
  @override
  void initState() {
    super.initState();
    controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    );
    animation = ColorTween(
      begin: Color.fromARGB(255, 227, 149, 149),
      end: Color.fromARGB(255, 255, 254, 252),
    ).animate(controller);
    controller.forward();
    controller.addListener(() {
      setState(() {});
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose

    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: animation.value,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        // crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Hero(
                tag: 'logo',
                child: Container(
                    height: 120, child: Image.asset('asset/logo.png')),
              ),
              AnimatedTextKit(
                animatedTexts: [
                  TyperAnimatedText(
                    'LETS TALK',
                    textStyle: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: AppColors.primarycolor),
                    speed: Duration(milliseconds: 100),
                  )
                ],
              ),
            ],
          ),
          ButtonRound(
            onPressed: () {
              Navigator.pushNamed(context, Routetable.login);
            },
            title: 'login',
            color: Colors.red,
          ),
          ButtonRound(
            onPressed: () {
              Navigator.pushNamed(context, Routetable.register);
            },
            title: 'Register',
            color: Colors.red,
          ),
        ],
      ),
    );
  }
}

import 'dart:math';

import 'package:flutter/material.dart';

import 'constants.dart';
import 'constants.dart';

class ButtonRound extends StatelessWidget {
  const ButtonRound({
    Key? key,
    required this.onPressed,
    required this.title,
    required this.color,
    this.isicon = false,
  }) : super(key: key);
  final onPressed;
  final String title;
  final Color color;
  final bool isicon;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Material(
        color: color,
        borderRadius: BorderRadius.circular(30),
        elevation: 5,
        child: MaterialButton(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(30.0)),
          ),
          height: 60,
          minWidth: 250,
          onPressed: onPressed,
          child: isicon
              ? Icon(
                  Icons.send,
                  color: Colors.black,
                )
              : Text(
                  title,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                  ),
                ),
        ),
      ),
    );
  }
}

class TextEntry extends StatelessWidget {
  const TextEntry({
    Key? key,
    this.onChanged,
    this.keyboardType,
    this.obscureText = false,
    this.hintText,
    this.icon,
  }) : super(key: key);

  final onChanged;
  final keyboardType;
  final bool obscureText;
  final hintText;
  final icon;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: TextField(
        cursorColor: AppColors.primarycolor,
        onChanged: onChanged,
        textAlign: TextAlign.center,
        keyboardType: keyboardType,
        obscureText: obscureText,
        decoration: InputDecoration(
          prefixIcon: Icon(icon),
          hintText: hintText,
          contentPadding: EdgeInsets.symmetric(),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(30.0),
            ),
            borderSide: BorderSide(color: AppColors.primarycolor),
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(30.0),
            ),
          ),
        ),
      ),
    );
  }
}

class ChatCard extends StatelessWidget {
  const ChatCard({
    Key? key,
    this.username = '',
    this.onTap,
  }) : super(key: key);
  final String username;
  final onTap;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            child: Row(
              children: [
                CircleAvatar(
                  backgroundColor: Color.fromARGB(255, Random().nextInt(255),
                      Random().nextInt(255), Random().nextInt(255)),
                  child: Icon(Icons.person),
                ),
                SizedBox(
                  width: 20,
                ),
                Column(
                  children: [
                    Text(
                      username,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Divider(
            indent: 20,
            endIndent: 20,
            color: Colors.black12,
            thickness: 0.7,
          ),
        ],
      ),
    );
  }
}

class MessageBubble extends StatelessWidget {
  const MessageBubble({
    Key? key,
    this.username = '',
    this.isMe = false,
    this.message = '',
  }) : super(key: key);
  final String username;
  final bool isMe;
  final String message;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: isMe
          ? const EdgeInsets.only(
              top: 10,
              bottom: 10,
              right: 10,
              left: 60,
            )
          : const EdgeInsets.only(
              top: 10,
              bottom: 10,
              right: 60,
              left: 10,
            ),
      child: Column(
        crossAxisAlignment:
            isMe ? CrossAxisAlignment.end : CrossAxisAlignment.start,
        children: [
          Text(
            username,
            style: const TextStyle(
              color: Colors.black45,
              fontSize: 12,
            ),
          ),
          Material(
            elevation: 2,
            borderRadius: isMe
                ? const BorderRadius.only(
                    topLeft: Radius.circular(30),
                    bottomLeft: Radius.circular(30),
                    bottomRight: Radius.circular(30),
                  )
                : const BorderRadius.only(
                    topRight: Radius.circular(30),
                    bottomLeft: Radius.circular(30),
                    bottomRight: Radius.circular(30),
                  ),
            color: isMe ? AppColors.primarycolor : Colors.white30,
            child: Padding(
              padding: const EdgeInsets.symmetric(
                vertical: 10,
                horizontal: 20,
              ),
              child: Text(
                message,
                style: TextStyle(
                  fontSize: 15,
                  color: isMe ? Colors.white : Colors.black,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

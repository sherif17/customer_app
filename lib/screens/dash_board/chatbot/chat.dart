import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ChatBot extends StatefulWidget {
  static String routeName = '/ChatBot';
  @override
  _ChatBotState createState() => _ChatBotState();
}

class _ChatBotState extends State<ChatBot> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Chatbot',
          style: TextStyle(
              color: Colors.redAccent,
              fontWeight: FontWeight.bold,
              fontSize: 30),
        ),
      ),
      body: Align(
        alignment: Alignment.center,
        child: SvgPicture.asset(
          "assets/illustrations/chatbot.svg",
          height: size.height * 0.35,
        ),
      ),
    );
  }
}

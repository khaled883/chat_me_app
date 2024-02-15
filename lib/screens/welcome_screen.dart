// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, avoid_unnecessary_containers

import 'package:chat_me/screens/registration_screen.dart';
import 'package:chat_me/screens/signin_screen.dart';
import 'package:chat_me/widgets/my_button.dart';
import 'package:flutter/material.dart';

class WelcomeScreen extends StatefulWidget {
  //this is the route>>>
  static const String screenRoute='welcome_screen';//this is called a properity
  //static const is used so we donot rebuild the whole stfull widget every time
  // we call the properity

  const WelcomeScreen({super.key});

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
          Column(children: [
            Container(
              height: 180,
              child: Image.asset('images/chat-icon.png'),
            ),
          Text('ChatMe',
          style: TextStyle(
            fontSize: 40, 
            fontWeight: FontWeight.w900,
            color: Color.fromARGB(255, 13, 82, 185),
          ),
          ),
          ],
            
          ),
          SizedBox(height:30),
          MyButton(
          color: Colors.amber, 
          title: 'Sign in', 
          onPressed: (){
            Navigator.pushNamed(context, SignInScreen.screenRoute);
            },
          ),
          MyButton(
            color: Color.fromARGB(255, 13, 82, 185), 
            title: 'Register', 
            onPressed: (){
              Navigator.pushNamed(context, RegistrationScreen.screenRoute);
            },
            ),
        ],
      ),
    ),
    );
  }
}


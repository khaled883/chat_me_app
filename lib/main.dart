// ignore_for_file: unused_import

import 'package:chat_me/screens/chat_screen.dart';
import 'package:chat_me/screens/registration_screen.dart';
import 'package:chat_me/screens/signin_screen.dart';
import 'package:chat_me/screens/welcome_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';


final _auth = FirebaseAuth.instance;

//import 'package:firebase_auth/firebase_auth.dart';

void main() async {
   WidgetsFlutterBinding.ensureInitialized();
   await Firebase.initializeApp(
    options: const FirebaseOptions(apiKey: 'AIzaSyA3uWZoLJ0UWh_vLE2ZFQYI55Ku5rKQG_8', 
    appId: '1:838463091774:android:17318686e15ee5eab50d6f', 
    messagingSenderId: '838463091774', 
    projectId: 'chatme-app-e977a'));
   
 
 
  /*await Firebase.initializeApp(
  options: DefaultFirebaseOptions.currentPlatform,);*/
  runApp( const MyApp());
  //adding (async), widgetsflutterbinding and await firebase are is important 
  //for initializing and using firebase services
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

 
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Chat Me ',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      //home: ChatScreen(),//WelcomeScreen(),
      initialRoute:_auth.currentUser!= null? ChatScreen.screenRoute : WelcomeScreen.screenRoute,
      routes: {
        WelcomeScreen.screenRoute: (context) => const WelcomeScreen(),
        SignInScreen.screenRoute: (context) => const SignInScreen(),
        RegistrationScreen.screenRoute: (context) =>const RegistrationScreen(),
        ChatScreen.screenRoute: (context) => const ChatScreen(),
     },
    );
  }
}

